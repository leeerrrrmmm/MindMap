import 'package:flutter/material.dart';
import 'package:mind_map/features/add_task/presentation/add_task_screen.dart';
import 'package:mind_map/features/home/presentation/home_screen.dart';
import 'package:mind_map/features/settings/settings_screen.dart';
import 'package:mind_map/navigation/widget/custom_bottom_nav_bar_widget.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  // Список страниц
  final List<Widget> _pages = [
    const HomeScreen(),
    const Scaffold(body: Center(child: Text(' Map Screen '))),
    const AddTaskScreen(),
    const Scaffold(body: Center(child: Text('Task Screen'))),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Контент страницы
          IndexedStack(index: _currentIndex, children: _pages),

          // Кастомная панель навигации
          Positioned(
            bottom: 20,
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
