import 'package:flutter/material.dart';

class CustomThemeSwitcherWidget extends StatelessWidget {
  final double dragX;
  final double maxDrag;
  final double switchWidth;
  final double switchHeight;
  final double padding;
  final double thumbSize;
  final AnimationController rotationController;
  final Function(DragUpdateDetails) onDragUpdate;
  final Function(DragEndDetails) onDragEnd;
  const CustomThemeSwitcherWidget({
    super.key,
    required this.dragX,
    required this.maxDrag,
    required this.switchWidth,
    required this.switchHeight,
    required this.padding,
    required this.thumbSize,
    required this.rotationController,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (dragX / maxDrag).clamp(0.0, 1.0);

    final thumbColor = Color.lerp(
      const Color(0xFFFFA726),
      const Color(0xFF37474F),
      progress,
    )!;

    final backgroundColor = Color.lerp(
      const Color(0xFFFFF3E0),
      const Color(0xFF1E1E1E),
      progress,
    )!;

    final icon = progress < 0.5
        ? Icons.light_mode_rounded
        : Icons.dark_mode_rounded;
    return Container(
      width: switchWidth,
      height: switchHeight,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            left: dragX,
            top: 0,

            child: GestureDetector(
              onHorizontalDragUpdate: onDragUpdate,
              onHorizontalDragEnd: onDragEnd,

              child: RotationTransition(
                turns: Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                    parent: rotationController,
                    curve: Curves.easeInOut,
                  ),
                ),

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: thumbSize,
                  height: thumbSize,
                  decoration: BoxDecoration(
                    color: thumbColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        turns: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },

                    child: Icon(
                      icon,
                      key: ValueKey(icon),
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
