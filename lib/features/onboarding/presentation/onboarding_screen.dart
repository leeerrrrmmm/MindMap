import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mind_map/components/text_field_widget.dart';
import 'package:mind_map/features/onboarding/widgets/arrow_button_widget.dart';
import 'package:mind_map/features/onboarding/widgets/goals_example_widget.dart';
import 'package:mind_map/features/onboarding/widgets/main_info_widget.dart';
import 'package:mind_map/features/onboarding/widgets/painter/curved_painter_widget.dart';
import 'package:mind_map/features/onboarding/widgets/top_info_bar_widget.dart';
import 'package:mind_map/features/splash/widgets/shadow_widget.dart';
import 'package:mind_map/navigation/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentLayerIndex = 0;

  void nextStep() {
    if (currentLayerIndex <= 1) {
      setState(() {
        currentLayerIndex++;
      });
    } else {
      context.go(AppRoutes.signIn);
    }
  }

  void previousStep() {
    if (currentLayerIndex <= 2) {
      setState(() {
        currentLayerIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> onboardingPages = [
      _FirstOnboardingLayer(
        currentLayerIndex: currentLayerIndex,
        onNext: nextStep,
      ),
      _SecondOnboardingLayer(
        currentLayerIndex: currentLayerIndex,
        onNext: nextStep,
        onPrevious: previousStep,
      ),

      _ThirdOnboardingLayer(
        currentLayerIndex: currentLayerIndex,
        onNext: nextStep,
        onPrevious: previousStep,
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: KeyedSubtree(
          key: ValueKey(currentLayerIndex),
          child: onboardingPages[currentLayerIndex],
        ),
      ),
    );
  }
}

class _FirstOnboardingLayer extends StatelessWidget {
  final int currentLayerIndex;
  final VoidCallback onNext;

  const _FirstOnboardingLayer({
    required this.currentLayerIndex,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/onb_back.png', fit: BoxFit.cover),
        ),
        Positioned(
          top: 10,
          right: 0,
          left: 0,
          child: TopInfoBarWidget(currentLayerIndex: currentLayerIndex),
        ),
        ShadowWidget(),
        MainInfoWidget(currentLayerIndex: currentLayerIndex, onNext: onNext),
      ],
    );
  }
}

class _SecondOnboardingLayer extends StatefulWidget {
  final int currentLayerIndex;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const _SecondOnboardingLayer({
    required this.currentLayerIndex,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<_SecondOnboardingLayer> createState() => _SecondOnboardingLayerState();
}

class _SecondOnboardingLayerState extends State<_SecondOnboardingLayer> {
  final TextEditingController _userOwnOneGoalController =
      TextEditingController();

  @override
  void dispose() {
    _userOwnOneGoalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            /// BACKGROUND
            Positioned.fill(
              child: Image.asset(
                'assets/images/second_onb_back.png',
                fit: BoxFit.cover,
              ),
            ),

            /// TOP BAR
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: TopInfoBarWidget(
                currentLayerIndex: widget.currentLayerIndex,
              ),
            ),

            /// CONTENT
            Positioned.fill(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/logo.png', scale: 2),

                      const SizedBox(height: 60),

                      /// TITLE
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Choose your ',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Text(
                                'goals:',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Positioned(
                                bottom: -42,
                                left: -14,
                                child: Image.asset(
                                  'assets/images/curl_line.png',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 60),

                      /// GOALS
                      Column(
                        spacing: 14,
                        children: [
                          GoalsExampleWidget(
                            dotColor: Theme.of(context).primaryColor,
                            exampleGoalText: 'Reduce stress',
                          ),
                          const SizedBox(height: 10),
                          GoalsExampleWidget(
                            dotColor: Theme.of(context).colorScheme.tertiary,
                            exampleGoalText: 'Organize your thoughts',
                          ),
                          const SizedBox(height: 10),
                          GoalsExampleWidget(
                            dotColor: Theme.of(context).primaryColor,
                            exampleGoalText: 'Increase productivity',
                          ),
                        ],
                      ),

                      const SizedBox(height: 80),

                      const Text(
                        'Write your own ones:',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 8),

                      /// INPUT
                      TextFieldWidget(
                        userController: _userOwnOneGoalController,
                      ),

                      const SizedBox(height: 60),

                      /// BUTTONS (ВНУТРИ ЛОГИКИ, НЕ OVERLAY)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ArrowButtonWidget(
                            icon: Icons.arrow_back,
                            onTap: widget.onPrevious,
                            color: Theme.of(context).primaryColor,
                            iconColor: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(width: 12),
                          ArrowButtonWidget(
                            icon: Icons.arrow_forward,
                            onTap: widget.onNext,
                            color: Theme.of(context).primaryColor,
                            iconColor: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),

                      SizedBox(height: bottomInset > 0 ? 20 : 0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThirdOnboardingLayer extends StatefulWidget {
  final int currentLayerIndex;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const _ThirdOnboardingLayer({
    required this.currentLayerIndex,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<_ThirdOnboardingLayer> createState() => _ThirdOnboardingLayerState();
}

class _ThirdOnboardingLayerState extends State<_ThirdOnboardingLayer> {
  int curAverageMood = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(color: Theme.of(context).primaryColor),
        ),

        Positioned(
          top: 220,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 400,
            child: CurveSlider(
              onChanged: (value) {
                log('value: $value');
                setState(() {
                  curAverageMood = value;
                });
              },
            ),
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.5,
          right: 30,
          child: RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              style: TextStyle(fontSize: 90, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: '${curAverageMood.toString()} ',
                  style: TextStyle(color: Colors.black, fontSize: 120),
                ),
                TextSpan(
                  text: '\nAverage load',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: 10,
          right: 0,
          left: 0,
          child: TopInfoBarWidget(currentLayerIndex: widget.currentLayerIndex),
        ),

        Positioned(
          top: 60,
          right: 0,
          left: 0,
          child: Column(
            spacing: 14,
            children: [
              Image.asset('assets/images/red_logo.png'),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(text: 'How do you feel about your'),
                    TextSpan(
                      text: '\nmental load',
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: '\tright now?'),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// BUTTONS
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              ArrowButtonWidget(
                icon: Icons.arrow_back,
                onTap: widget.onPrevious,
                color: Theme.of(context).colorScheme.secondary,
                iconColor: Theme.of(context).primaryColor,
              ),
              ArrowButtonWidget(
                icon: Icons.arrow_forward,
                onTap: widget.onNext,
                color: Theme.of(context).colorScheme.secondary,
                iconColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
