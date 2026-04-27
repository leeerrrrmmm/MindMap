import 'package:flutter/material.dart';
import 'package:mind_map/features/onboarding/widgets/onboarding_btn_widget.dart';

class MainInfoWidget extends StatelessWidget {
  final int currentLayerIndex;
  final VoidCallback onNext;

  const MainInfoWidget({
    super.key,
    required this.currentLayerIndex,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 60,
      left: 0,
      right: 0,
      child: Column(
        spacing: 24,
        children: [
          Image.asset('assets/images/logo.png'),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              children: [
                const TextSpan(text: 'Do you haves'),
                TextSpan(
                  text: 'a lot of\nthoughts',
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                const TextSpan(text: 'in your\nhead?'),
              ],
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              children: [
                const TextSpan(text: 'We will help you\nstructure'),
                TextSpan(
                  text: ' everything.',
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ],
            ),
          ),
          OnboardingBtnWidget(onTap: onNext, label: 'Continue'),
        ],
      ),
    );
  }
}
