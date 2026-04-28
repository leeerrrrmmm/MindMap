import 'package:flutter/material.dart';
import 'package:mind_map/features/home/home_screen.dart';
import 'package:mind_map/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: AppThemeData.light,
    );
  }
}
