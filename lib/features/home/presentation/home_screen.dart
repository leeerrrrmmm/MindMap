import 'package:flutter/material.dart';
import 'package:mind_map/features/home/widgets/top_right_btn_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [_TopWidget()]),
    );
  }
}

class _TopWidget extends StatelessWidget {
  const _TopWidget();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
        height: 184,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: -50,
              child: CircleAvatar(
                radius: 140,
                backgroundColor: Color(0xFFAD3743).withValues(alpha: 0.7),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(26.0, 50.0, 20.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///LEFT COLUMN
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///LOGO AND TITLE
                      Row(
                        spacing: 10,
                        children: [
                          Image.asset('assets/images/logo.png', scale: 3),
                          Text(
                            'MindMap24',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      ///USER INFO
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(text: 'Hi, '),
                              TextSpan(
                                text: 'John Doe',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '\nWelcome to your mind map!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///RIGHT COLUMN
                  Column(
                    spacing: 20,
                    children: [
                      TopRightBtnWidget(
                        onTap: () {
                          ///TODO: Implement notification logic
                        },
                        icon: Icons.notifications_outlined,
                      ),
                      TopRightBtnWidget(
                        onTap: () {
                          ///TODO: Implement edit logic
                        },
                        icon: Icons.edit_outlined,
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
}
