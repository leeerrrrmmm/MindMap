import 'package:flutter/material.dart';

class TopInfoBarWidget extends StatelessWidget {
  final int currentLayerIndex;

  const TopInfoBarWidget({super.key, required this.currentLayerIndex});

  @override
  Widget build(BuildContext context) {
    double progressWidth;

    if (currentLayerIndex == 0) {
      progressWidth = 100;
    } else if (currentLayerIndex == 1) {
      progressWidth = 165;
    } else {
      progressWidth = 230;
    }

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 6,
            width: 230,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 6,
                width: progressWidth,
                decoration: BoxDecoration(
                  color: currentLayerIndex <= 1
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
