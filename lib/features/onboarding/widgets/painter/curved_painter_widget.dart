import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class CurveSlider extends StatefulWidget {
  final ValueChanged<int> onChanged;
  const CurveSlider({super.key, required this.onChanged});

  @override
  State<CurveSlider> createState() => _CurveSliderState();
}

class _CurveSliderState extends State<CurveSlider> {
  static const int _segmentCount = 4;

  static const double _handleSize = 56;
  static const double _handleRadius = _handleSize / 2;
  static const double _horizontalInset = 24;
  static const double _topInset = 18;
  static const double _bottomInset = 24;

  double progress = 0.5;

  int currentIndex = 3;
  late final List<double> steps = List<double>.generate(
    _segmentCount + 1,
    (i) => i / _segmentCount,
  );

  Path buildCurvePath(Size size) {
    final path = Path();
    final start = Offset(
      _handleRadius + _horizontalInset,
      size.height - _handleRadius - _bottomInset,
    );
    final end = Offset(
      size.width - _handleRadius - _horizontalInset,
      _handleRadius + _topInset,
    );

    path.moveTo(start.dx, start.dy);

    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.20,
      end.dx,
      end.dy,
    );

    return path;
  }

  double _offsetAlongPath(PathMetric metric, double lengthFraction) {
    final len = metric.length;
    if (len == 0) return 0;
    final t = lengthFraction.clamp(0.0, 1.0);
    if (t >= 1) return math.max(0.0, len - 0.35);
    return len * t;
  }

  Offset getPoint(Path path, double lengthFraction) {
    final metric = path.computeMetrics().first;
    return metric
        .getTangentForOffset(_offsetAlongPath(metric, lengthFraction))!
        .position;
  }

  void update(Offset local, Size size) {
    final path = buildCurvePath(size);
    final metric = path.computeMetrics().first;

    final length = metric.length;

    double closestOffset = 0;
    double minDist = double.infinity;

    for (double i = 0; i < length; i += 2) {
      final pos = metric.getTangentForOffset(i)!.position;
      final dist = (pos - local).distance;

      if (dist < minDist) {
        minDist = dist;
        closestOffset = i;
      }
    }

    setState(() {
      progress = closestOffset / length;
    });
  }

  void snap() {
    double best = steps.first;
    double min = double.infinity;
    int index = 0;

    for (int i = 0; i < steps.length; i++) {
      final d = (progress - steps[i]).abs();
      if (d < min) {
        min = d;
        best = steps[i];
        index = i + 1;
      }
    }

    setState(() {
      progress = best;
      currentIndex = index;
    });

    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final size = Size(c.maxWidth, c.maxHeight);
        final path = buildCurvePath(size);
        final pos = getPoint(path, progress);

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanStart: (d) {
            final box = context.findRenderObject() as RenderBox;
            final local = box.globalToLocal(d.globalPosition);
            update(local, size);
          },
          onPanUpdate: (d) {
            final box = context.findRenderObject() as RenderBox;
            final local = box.globalToLocal(d.globalPosition);
            update(local, size);
          },
          onPanEnd: (_) => snap(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                size: size,
                painter: _CurvePainter(
                  progress,
                  buildCurvePath,
                  segmentCount: _segmentCount,
                ),
              ),

              /// 🔴 DRAG HANDLE
              Positioned(
                left: pos.dx - _handleRadius,
                top: pos.dy - _handleRadius,
                child: Transform.rotate(
                  angle: math.pi / 2,
                  alignment: Alignment.center,
                  child: Container(
                    width: _handleSize,
                    height: _handleSize,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF5A5A),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 12,
                          offset: Offset(0, 6),
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: Transform.rotate(
                      angle: -math.pi / 2,
                      child: Image.asset('assets/images/mood_btn_img.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CurvePainter extends CustomPainter {
  final double progress;
  final Path Function(Size) buildPath;
  final int segmentCount;

  _CurvePainter(this.progress, this.buildPath, {required this.segmentCount});

  double _offsetAlongPath(PathMetric metric, double lengthFraction) {
    final len = metric.length;
    if (len == 0) return 0;
    final t = lengthFraction.clamp(0.0, 1.0);
    if (t >= 1) return math.max(0.0, len - 0.35);
    return len * t;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = buildPath(size);

    final base = Paint()
      ..color = const Color(0xFF3B3133)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final active = Paint()
      ..color = const Color(0xFFFF5A5A)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final dotPaint = Paint()..color = Colors.white;

    canvas.drawPath(path, base);

    final metric = path.computeMetrics().first;

    final activePath = metric.extractPath(0, metric.length * progress);

    canvas.drawPath(activePath, active);

    for (var i = 0; i <= segmentCount; i++) {
      final lengthFraction = i / segmentCount;
      final tangent = metric.getTangentForOffset(
        _offsetAlongPath(metric, lengthFraction),
      )!;

      final pos = tangent.position;
      const dotRadius = 4.5;
      canvas.drawCircle(pos, dotRadius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
