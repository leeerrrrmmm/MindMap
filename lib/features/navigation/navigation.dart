import 'package:flutter/material.dart';
import 'package:mind_map/features/home/presentation/home_screen.dart';
import 'package:mind_map/features/navigation/widget/custom_bottom_nav_bar_widget.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  // Список страниц
  final List<Widget> _pages = [
    const HomeScreen(), // Тот самый HomeScreen с TopWidget
    const Scaffold(body: Center(child: Text('Notifications'))),
    const Scaffold(body: Center(child: Text('Profile'))),
    const Scaffold(body: Center(child: Text('Settings'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Используем Stack, чтобы навигация была ПОВЕРХ контента
      body: Stack(
        children: [
          // 1. Контент страницы
          IndexedStack(index: _currentIndex, children: _pages),

          // 2. Наша кастомная панель навигации
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: CustomBottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
