import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mind_map/features/account/presentation/account_screen.dart';
import 'package:mind_map/features/appearance/presentation/appearance_screen.dart';
import 'package:mind_map/features/auth/presentation/sign_in/sign_in_screen.dart';
import 'package:mind_map/features/auth/presentation/sign_up/sign_up_screen.dart';
import 'package:mind_map/features/forgot_password/presentation/forgot_password_screen.dart';
import 'package:mind_map/features/onboarding/presentation/onboarding_screen.dart';
import 'package:mind_map/features/splash/presentation/splash_screen.dart';
import 'package:mind_map/navigation/navigation.dart';

abstract final class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const onboarding = '/onboarding';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const forgotPassword = '/forgot-password';
  static const main = '/main';
  static const account = '/account';
  static const appearance = '/appearance';
}

CustomTransitionPage<void> _fadePage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      pageBuilder: (context, state) =>
          _fadePage(state, const OnboardingScreen()),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      pageBuilder: (context, state) => _fadePage(state, const SignInScreen()),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.main,
      builder: (context, state) => const Navigation(),
    ),
    GoRoute(
      path: AppRoutes.account,
      builder: (context, state) => const AccountScreen(),
    ),
    GoRoute(
      path: AppRoutes.appearance,
      builder: (context, state) => const AppearanceScreen(),
    ),
  ],
);
