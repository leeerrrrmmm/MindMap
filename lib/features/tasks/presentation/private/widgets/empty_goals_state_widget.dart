import 'package:flutter/material.dart';

class EmptyGoalsStateWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const EmptyGoalsStateWidget({
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 93,
            height: 68,
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.add, color: Colors.black, size: 34),
          ),
        ),
      ],
    );
  }
}
