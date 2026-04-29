import 'package:flutter/material.dart';

class DownBlockContainerWidget extends StatelessWidget {
  final String image;
  final Color color;
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const DownBlockContainerWidget({
    required this.image,
    required this.color,
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 158,
        height: 111,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.contain),
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Row(
            spacing: 10,
            children: [
              Icon(icon, color: Theme.of(context).primaryColor, size: 40),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
