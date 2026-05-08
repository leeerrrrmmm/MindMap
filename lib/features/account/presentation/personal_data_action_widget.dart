import 'package:flutter/material.dart';

class PersonalDataActionWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;
  final Color textColor;
  final bool titleCenter;
  const PersonalDataActionWidget({
    required this.onTap,
    required this.icon,
    required this.label,
    required this.color,
    required this.iconColor,
    required this.textColor,
    this.titleCenter = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: titleCenter
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          spacing: 10,
          children: [
            Icon(icon, color: iconColor, size: 25),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
