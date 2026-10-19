import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
