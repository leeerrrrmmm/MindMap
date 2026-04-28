import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mind_map/components/login_with_another_way_widget.dart';
import 'package:mind_map/components/sign_btn_widget.dart';
import 'package:mind_map/components/text_field_widget.dart';
import 'package:mind_map/features/forgot_password/forgot_password_screen.dart';
import 'package:mind_map/features/sign_up/sign_up_screen.dart';

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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Positioned(
              child: Image.asset(
                'assets/images/log_reg_back.png',
                fit: BoxFit.cover,
              ),
            ),

            ///SHADOW
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

            ///BOTTOM CONTAINER
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: _BottomContainerClipper(),
                child: Container(
                  width: double.infinity,
                  height: 295,
                  decoration: BoxDecoration(
                    color: Color(0xFFAD3743).withValues(alpha: 0.3),
                  ),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(text: "Don't have an account?"),
                          TextSpan(
                            text: ' Sign up',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              decoration: TextDecoration.underline,
                            ),

                            ///Navigate to Sign Up Screen
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => const SignUpScreen(),
                                  ),
                                );
                              },
                          ),

                          ///Navigate to Forgot Password Screen
                          TextSpan(
                            text: '\n\nForgot password?',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            ///SIGN IN CONTAINER
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  ///LOGO AND TITLE
                  Column(
                    children: [
                      Image.asset('assets/images/logo.png', scale: 2),
                      Text(
                        'Sign in to MindMap24',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Quick sign in to start organizing your mind today!',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  //TextFieldForm for email and password
                  Column(
                    spacing: 10,
                    children: [
                      _EmailAndPasswWidget(
                        controller: emailController,
                        title: 'Email Address',
                        prefixIcon: Icons.alternate_email_outlined,
                        hintText: 'Enter your email address...',
                        isPassword: false,
                        suffixIcon: null,
                      ),
                      _EmailAndPasswWidget(
                        controller: passwordController,
                        title: 'Password',
                        prefixIcon: Icons.lock_outline,
                        hintText: 'Enter your password...',
                        isPassword: true,
                        suffixIcon: Icons.visibility_off_outlined,
                      ),
                    ],
                  ),

                  ///SIGN IN BUTTON
                  SignBtnWidget(
                    onTap: () {
                      //TODO: Implement sign in logic
                    },
                    label: 'Sign in',
                  ),

                  const SizedBox(height: 20),

                  ///LOGIN WITH ANOTHER WAY
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 40,
                    children: [
                      LogingWithAnotherWayWidget(
                        icon: FaIcon(FontAwesomeIcons.instagram),
                        onTap: () {},
                      ),
                      LogingWithAnotherWayWidget(
                        icon: FaIcon(FontAwesomeIcons.google),
                        onTap: () {},
                      ),
                      LogingWithAnotherWayWidget(
                        icon: FaIcon(FontAwesomeIcons.linkedin),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

class _BottomContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.moveTo(0, 150);

    path.quadraticBezierTo(w * 0.5, 0, w, 150);

    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _EmailAndPasswWidget extends StatelessWidget {
  const _EmailAndPasswWidget({
    required this.controller,
    required this.title,
    required this.prefixIcon,
    required this.hintText,
    required this.isPassword,
    required this.suffixIcon,
  });

  final TextEditingController controller;
  final String title;
  final IconData prefixIcon;
  final String hintText;
  final bool? isPassword;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        TextFieldWidget(
          userController: controller,
          hintText: hintText,
          prefixIcon: prefixIcon,
          isPassword: isPassword ?? false,
          suffixIcon: suffixIcon,
        ),
      ],
    );
  }
}
