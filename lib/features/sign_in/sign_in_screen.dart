import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mind_map/components/text_field_widget.dart';

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
      body: Stack(
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
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        'Sign in',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.login_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 26,
                      ),
                    ],
                  ),
                ),
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
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class LogingWithAnotherWayWidget extends StatelessWidget {
  final FaIcon icon;
  final VoidCallback onTap;
  const LogingWithAnotherWayWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Center(child: icon)),
      ),
    );
  }
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
