import 'package:flutter/material.dart';

class MindMapBloc extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const MindMapBloc({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 341,
        height: 158,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF90A9BD), Color(0xFF697C8B)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Image.asset('assets/images/mind_map_bloc.png', fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}
