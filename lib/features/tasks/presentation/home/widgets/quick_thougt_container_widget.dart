import 'package:flutter/material.dart';

class QuickThoughtContainerWidget extends StatelessWidget {
  const QuickThoughtContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        width: double.infinity,
        height: 62,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Share your thoughts today...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Icon(Icons.mic, color: Theme.of(context).primaryColor, size: 30),
          ],
        ),
      ),
    );
  }
}
