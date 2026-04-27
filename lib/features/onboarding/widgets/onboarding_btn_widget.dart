import 'package:flutter/material.dart';

class OnboardingBtnWidget extends StatefulWidget {
  final void Function() onTap;
  final String label;
  const OnboardingBtnWidget({
    super.key,
    required this.onTap,
    required this.label,
  });

  @override
  State<OnboardingBtnWidget> createState() => _OnboardingBtnWidgetState();
}

class _OnboardingBtnWidgetState extends State<OnboardingBtnWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 187,
        height: 62,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
