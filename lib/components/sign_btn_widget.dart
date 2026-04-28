import 'package:flutter/material.dart';

class SignBtnWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  const SignBtnWidget({required this.onTap, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.login_outlined,
              color: Theme.of(context).primaryColor,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}
