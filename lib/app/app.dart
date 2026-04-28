import 'package:flutter/material.dart';
import 'package:mind_map/features/sign_up/sign_up_screen.dart';
import 'package:mind_map/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignUpScreen(),
      theme: AppThemeData.light,
    );
  }
}
