import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mind_map/components/login_with_another_way_widget.dart';
import 'package:mind_map/components/sign_btn_widget.dart';
import 'package:mind_map/components/text_field_widget.dart';
import 'package:mind_map/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:mind_map/navigation/app_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go(AppRoutes.main);
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Positioned(
                  child: Image.asset(
                    'assets/images/log_reg_back.png',
                    fit: BoxFit.cover,
                  ),
                ),

                /// SHADOW
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          blurRadius: 100,
                          spreadRadius: 100,
                        ),
                      ],
                    ),
                  ),
                ),

                /// BOTTOM
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: _BottomContainerClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 295,
                      color: const Color(0xFFAD3743).withValues(alpha: 0.3),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              const TextSpan(text: "Don't have an account?"),
                              TextSpan(
                                text: ' Sign up',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      context.push(AppRoutes.signUp),
                              ),
                              TextSpan(
                                text: '\n\nForgot password?',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      context.push(AppRoutes.forgotPassword),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// CONTENT
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),

                      Column(
                        children: [
                          Image.asset('assets/images/logo.png', scale: 2),
                          const Text(
                            'Sign in to MindMap24',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Quick sign in to start organizing your mind today!',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Column(
                        spacing: 10,
                        children: [
                          _Field(
                            controller: emailController,
                            title: 'Email Address',
                            prefixIcon: Icons.alternate_email_outlined,
                            hint: 'Enter your email...',
                            isPassword: false,
                          ),
                          _Field(
                            controller: passwordController,
                            title: 'Password',
                            prefixIcon: Icons.lock_outline,
                            hint: 'Enter your password...',
                            isPassword: true,
                          ),
                        ],
                      ),

                      SignBtnWidget(
                        label: isLoading ? 'Loading...' : 'Sign in',
                        onTap: isLoading
                            ? () {}
                            : () {
                                context.read<AuthCubit>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              },
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 40,
                        children: [
                          LogingWithAnotherWayWidget(
                            icon: const FaIcon(FontAwesomeIcons.instagram),
                            onTap: () {},
                          ),
                          LogingWithAnotherWayWidget(
                            icon: const FaIcon(FontAwesomeIcons.google),
                            onTap: () {
                              context.read<AuthCubit>().signInWithGoogle();
                            },
                          ),
                          LogingWithAnotherWayWidget(
                            icon: const FaIcon(FontAwesomeIcons.linkedin),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

/// FIELD WIDGET
class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final IconData prefixIcon;
  final String hint;
  final bool isPassword;

  const _Field({
    required this.controller,
    required this.title,
    required this.prefixIcon,
    required this.hint,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        TextFieldWidget(
          userController: controller,
          hintText: hint,
          prefixIcon: prefixIcon,
          isPassword: isPassword,
        ),
      ],
    );
  }
}

/// CLIPPER
class _BottomContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(0, 150)
      ..quadraticBezierTo(w * 0.5, 0, w, 150)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
