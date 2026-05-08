import 'package:flutter/material.dart';

class FirstLastNameWidget extends StatelessWidget {
  final String title;
  final String userFirstName;
  final String userLastName;

  const FirstLastNameWidget({
    super.key,
    required TextEditingController controller,
    required this.title,
    required this.userFirstName,
    required this.userLastName,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        TextFormField(
          controller: _controller,
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            enabled: false,
            hintText: title == 'First Name' ? userFirstName : userLastName,
            filled: true,
            fillColor: Color(0xFFD9D9D9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
