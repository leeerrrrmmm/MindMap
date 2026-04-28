import 'package:flutter/material.dart';

class TopRightBtnWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const TopRightBtnWidget({required this.onTap, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Color(0xFFAD3743),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
