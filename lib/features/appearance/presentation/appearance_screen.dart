import 'package:flutter/material.dart';
import 'package:mind_map/features/appearance/widgets/appearance_selector_widget.dart';
import 'package:mind_map/features/appearance/widgets/custom_theme_switcher_widget.dart';
import 'package:mind_map/features/appearance/widgets/size_selector_widget.dart';

enum AppearanceTheme {
  one(Color(0xFFD96A78)),
  two(Color(0xFFF2C6CB)),
  three(Color(0xFFE9A14E)),
  four(Color(0xFF66C6B9)),
  five(Color(0xFFF3E2C7)),
  six(Color(0xFFA2B3D9)),
  seven(Color(0xFFD96A78));

  final Color color;
  const AppearanceTheme(this.color);
}

enum FontSize {
  defaultSize(20),
  medium(24),
  large(28);

  final int size;
  const FontSize(this.size);
}

class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  AppearanceTheme selectedAppearanceTheme = AppearanceTheme.one;
  FontSize selectedFontSize = FontSize.defaultSize;
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Image.asset('assets/images/red_logo.png'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppearanceSelectorWidget(
                    selectedAppearanceTheme: selectedAppearanceTheme,
                    onSelect: (theme) {
                      setState(() {
                        selectedAppearanceTheme = theme;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  _FontSizeSelector(
                    selectedFontSize: selectedFontSize,
                    onSelect: (size) {
                      setState(() {
                        selectedFontSize = size;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  _CustomThemeDragWisget(
                    isDark: _isDark,
                    onChanged: (newValue) {
                      setState(() {
                        _isDark = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          _SaveAndExitButton(
            onTap: () {
              //!TODO: Implement save and exit functionality
            },
          ),
          const _BottomCircle(),
        ],
      ),
    );
  }
}

class _SaveAndExitButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SaveAndExitButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
          height: 65,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Text(
                'Save and exit',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Icon(Icons.login_outlined, color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomThemeDragWisget extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onChanged;

  const _CustomThemeDragWisget({required this.isDark, required this.onChanged});

  @override
  State<_CustomThemeDragWisget> createState() => _CustomThemeDragWisgetState();
}

class _CustomThemeDragWisgetState extends State<_CustomThemeDragWisget>
    with SingleTickerProviderStateMixin {
  late bool _isDark;
  double _dragX = 0;
  late AnimationController _rotationController;

  final double containerWidth = 113;
  final double containerHeight = 66;
  final double thumbSize = 52;

  bool _initialized = false;

  double get _padding => _isDark ? 7 : 7;

  double get _maxDrag => containerWidth - containerHeight - (_padding * 0.5);

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    _isDark = Theme.of(context).brightness == Brightness.dark;
    _dragX = _isDark ? _maxDrag : 0;

    _initialized = true;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragX = (_dragX + details.delta.dx).clamp(0, _maxDrag);
    });

    _rotationController.forward(from: 0);
  }

  void _onDragEnd(DragEndDetails details) {
    final bool newValue = _dragX > _maxDrag * 0.5;

    setState(() {
      _isDark = newValue;
      _dragX = newValue ? _maxDrag : 0;
      _rotationController.reverse(from: 1);
    });

    widget.onChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Theme',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),

        CustomThemeSwitcherWidget(
          dragX: _dragX,
          maxDrag: _maxDrag,
          switchWidth: containerWidth,
          switchHeight: containerHeight,
          padding: _padding,
          thumbSize: thumbSize,
          rotationController: _rotationController,
          onDragUpdate: _onDragUpdate,
          onDragEnd: _onDragEnd,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }
}

class _FontSizeSelector extends StatelessWidget {
  final FontSize selectedFontSize;
  final ValueChanged<FontSize> onSelect;

  const _FontSizeSelector({
    required this.selectedFontSize,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Font Size',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),

        const SizedBox(height: 10),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizeSelectorWidget(
                  fontSize: FontSize.values[index],
                  onSelect: onSelect,
                  selectedFontSize: selectedFontSize,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomCircle extends StatelessWidget {
  const _BottomCircle();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(200),
            topRight: Radius.circular(200),
          ),
        ),
      ),
    );
  }
}
