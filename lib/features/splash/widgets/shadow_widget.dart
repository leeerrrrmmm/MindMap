import 'package:flutter/material.dart';

class ShadowWidget extends StatelessWidget {
  const ShadowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.01),
          ],
        ),
      ),
    );
  }
}
