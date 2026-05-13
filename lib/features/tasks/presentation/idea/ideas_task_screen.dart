import 'package:flutter/material.dart';

class IdeasTaskScreen extends StatefulWidget {
  const IdeasTaskScreen({super.key});

  @override
  State<IdeasTaskScreen> createState() => _IdeasTaskScreenState();
}

class _IdeasTaskScreenState extends State<IdeasTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ideas')),
      body: const Center(child: Text('Ideas')),
    );
  }
}
