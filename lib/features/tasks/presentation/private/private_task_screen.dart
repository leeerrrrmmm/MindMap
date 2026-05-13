import 'package:flutter/material.dart';

class PrivateTaskScreen extends StatefulWidget {
  const PrivateTaskScreen({super.key});

  @override
  State<PrivateTaskScreen> createState() => _PrivateTaskScreenState();
}

class _PrivateTaskScreenState extends State<PrivateTaskScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Private')),
      body: const Center(child: Text('Private')),
    );
  }
}
