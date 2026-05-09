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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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

                /// FORM
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    spacing: 20,
                    children: [
                      const SizedBox(height: 60),

                      /// LOGO
                      Column(
                        children: [
                          Image.asset('assets/images/logo.png', scale: 2),
                          const SizedBox(height: 10),
                          const Text(
                            'Sign up to MindMap24',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Create account and start organizing your mind',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      /// FIELDS
                      Column(
                        spacing: 10,
                        children: [
                          _field(
                            controller: emailController,
                            title: 'Email',
                            hint: 'Enter email',
                            icon: Icons.alternate_email,
                            isPassword: false,
                          ),
                          _field(
                            controller: passwordController,
                            title: 'Password',
                            hint: 'Enter password',
                            icon: Icons.lock_outline,
                            isPassword: true,
                          ),
                          _field(
                            controller: confirmPasswordController,
                            title: 'Confirm Password',
                            hint: 'Confirm password',
                            icon: Icons.lock_outline,
                            isPassword: true,
                          ),
                        ],
                      ),

                      /// BUTTON
                      SignBtnWidget(
                        onTap: isLoading
                            ? () {}
                            : () {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                final confirm = confirmPasswordController.text
                                    .trim();

                                if (email.isEmpty ||
                                    password.isEmpty ||
                                    confirm.isEmpty) {
                                  return;
                                }

                                if (password != confirm) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Passwords don't match"),
                                    ),
                                  );
                                  return;
                                }

                                context.read<AuthCubit>().signUp(
                                  email: email,
                                  password: password,
                                  confirmPassword: confirm,
                                  goal: 'test gola',
                                  mood: 222,
                                );
                              },
                        label: isLoading ? 'Loading...' : 'Sign up',
                      ),

                      const SizedBox(height: 4),

                      /// SOCIAL LOGIN
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 40,
                        children: [
                          LogingWithAnotherWayWidget(
                            icon: const FaIcon(FontAwesomeIcons.google),
                            onTap: () {
                              context.read<AuthCubit>().signInWithGoogle();
                            },
                          ),
                        ],
                      ),

                      /// NAV TO SIGN IN
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (context.canPop()) {
                                    context.pop();
                                  } else {
                                    context.go(AppRoutes.signIn);
                                  }
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// LOADING OVERLAY
                if (isLoading)
                  Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String title,
    required String hint,
    required IconData icon,
    required bool isPassword,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 6),
        TextFieldWidget(
          userController: controller,
          hintText: hint,
          prefixIcon: icon,
          isPassword: isPassword,
          suffixIcon: isPassword ? Icons.visibility_off : null,
        ),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
