import 'package:flutter/material.dart';
import 'package:mind_map/features/tasks/presentation/private/widgets/empty_goals_state_widget.dart';

class PrivateTaskScreen extends StatefulWidget {
  const PrivateTaskScreen({super.key});

  @override
  State<PrivateTaskScreen> createState() => _PrivateTaskScreenState();
}

class _PrivateTaskScreenState extends State<PrivateTaskScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/red_logo.png',
          color: Color(0xFFAD3743),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TITLE
            Text(
              'Private Tasks',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFAD3743),
              ),
            ),

            EmptyGoalsStateWidget(
              title: 'Personal goals and experiences',
              onTap: () {},
            ),
            EmptyGoalsStateWidget(
              title: 'Personal relationships',
              onTap: () {},
            ),
            EmptyGoalsStateWidget(title: 'Other', onTap: () {}),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
