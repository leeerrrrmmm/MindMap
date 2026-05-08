import 'package:flutter/material.dart';
import 'package:mind_map/features/appearance/presentation/appearance_screen.dart';

class SizeSelectorWidget extends StatelessWidget {
  final FontSize selectedFontSize;
  final FontSize fontSize;
  final ValueChanged<FontSize> onSelect;
  const SizeSelectorWidget({
    super.key,
    required this.selectedFontSize,
    required this.fontSize,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        GestureDetector(
          onTap: () => onSelect(fontSize),
          child: Container(
            margin: EdgeInsets.only(right: 10),
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Theme.of(
                context,
              ).colorScheme.secondary.withValues(alpha: 0.2),
            ),
            child: Center(
              child: Text(
                'Aa',
                style: TextStyle(
                  fontSize: fontSize.size.toDouble(),
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          width: 28,
          height: 28,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(
              context,
            ).colorScheme.secondary.withValues(alpha: 0.2),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:fontSize == selectedFontSize ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
            ),
          ),
        ),
      ],
    );
  }
}
