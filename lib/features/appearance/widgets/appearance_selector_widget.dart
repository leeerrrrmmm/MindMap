import 'package:flutter/material.dart';
import 'package:mind_map/features/appearance/presentation/appearance_screen.dart';

class AppearanceSelectorWidget extends StatelessWidget {
  final AppearanceTheme selectedAppearanceTheme;
  final ValueChanged<AppearanceTheme> onSelect;
  const AppearanceSelectorWidget({
    super.key,
    required this.selectedAppearanceTheme,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Accent Color',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        Container(
          height: 65,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.secondary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppearanceTheme.values.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 4.0, left: 10.0),
                  child: GestureDetector(
                    //SELECT THE APPEARANCE THEME LOGIC HERE
                    onTap: () => onSelect(AppearanceTheme.values[index]),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            selectedAppearanceTheme ==
                                AppearanceTheme.values[index]
                            ? Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Container(
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppearanceTheme.values[index].color,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
