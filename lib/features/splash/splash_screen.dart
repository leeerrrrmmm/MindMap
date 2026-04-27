import 'package:flutter/material.dart';
import 'package:mind_map/features/onboarding/onboarding_screen.dart';
import 'package:mind_map/features/splash/widgets/shadow_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isfirstSplash = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isfirstSplash = true;
      });
    }).then(
      (value) => {
        Future.delayed(const Duration(seconds: 4), () {
          if (!mounted) {
            return;
          } else {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const OnboardingScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            );
          }
        }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          _FirstSplash(),

          _SecondSplash(isfirstSplash: isfirstSplash),
        ],
      ),
    );
  }
}

class _SecondSplash extends StatelessWidget {
  const _SecondSplash({required this.isfirstSplash});

  final bool isfirstSplash;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isfirstSplash ? 1 : 0,
      duration: const Duration(seconds: 1),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          ShadowWidget(),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Column(
              spacing: 28,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 88,
                  height: 82,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      '``',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  '''"If you don't realize what's going on inside you, it feels like fate from the outside.''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  ' - Carl Gustav Jung',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FirstSplash extends StatelessWidget {
  const _FirstSplash();

  @override
  Widget build(BuildContext context) {
    return Center(
      key: Key('splash_screen'),
      child: Column(
        spacing: 26,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          Text(
            'MindMap24',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
            ),
          ),
          Text(
            textAlign: TextAlign.center,
            'A service for managing thoughts,\nideas, and mental stress',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
