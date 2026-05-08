import 'package:flutter/material.dart';
import 'package:mind_map/features/appearance/widgets/appearance_selector_widget.dart';
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  AppearanceSelectorWidget(
                    selectedAppearanceTheme: selectedAppearanceTheme,
                    onSelect: (theme) {
                      setState(() {
                        selectedAppearanceTheme = theme;
                      });
                    },
                  ),
                  _FontSizeSelector(
                    selectedFontSize: selectedFontSize,
                    onSelect: (size) {
                      setState(() {
                        selectedFontSize = size;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          _BottomCircle(),
        ],
      ),
    );
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
      spacing: 10,
      children: [
        Text(
          'Font Size',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                spacing: 20,
                children: [
                  ...List.generate(
                    3,
                    (index) => SizeSelectorWidget(
                      fontSize: FontSize.values[index],
                      onSelect: onSelect,
                      selectedFontSize: selectedFontSize,
                    ),
                  ),
                ],
              ),
            ],
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
          color: Color(0xFF000000).withValues(alpha: 0.1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(200),
            topLeft: Radius.circular(200),
          ),
        ),
      ),
    );
  }
}
