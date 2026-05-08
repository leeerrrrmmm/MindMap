import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mind_map/features/account/presentation/account_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/red_logo.png'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              spacing: 20,
              children: [
                Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                _SettingsActionWidget(
                  icon: Icons.person,
                  label: 'Account',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountScreen(),
                      ),
                    );
                  },
                ),
                _SettingsActionWidget(
                  icon: CupertinoIcons.paintbrush_fill,
                  label: 'Appearance',
                  onTap: () {
                    //TODO: Implemet navigation to appearance screen
                  },
                ),
              ],
            ),
          ),
          _BottomCircle(),
        ],
      ),
    );
  }
}

class _SettingsActionWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SettingsActionWidget({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 40),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomCircle extends StatelessWidget {
  const _BottomCircle();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF000000).withValues(alpha: 0.1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(200),
            topLeft: Radius.circular(200),
          ),
        ),
      ),
    );
  }
}
