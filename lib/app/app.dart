import 'package:flutter/material.dart';
import 'package:mind_map/navigation/navigation.dart';
import 'package:mind_map/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Navigation(),
      theme: AppThemeData.light,
    );
  }
}
