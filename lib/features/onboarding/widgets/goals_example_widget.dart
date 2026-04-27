import 'package:flutter/material.dart';

class GoalsExampleWidget extends StatelessWidget {
  final Color dotColor;
  final String exampleGoalText;
  const GoalsExampleWidget({
    super.key,
    required this.dotColor,
    required this.exampleGoalText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: [
        CircleAvatar(radius: 10, backgroundColor: dotColor),
        Text(
          exampleGoalText,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
