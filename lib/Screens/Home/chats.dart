import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'contact'),
        elevation: 0,
        backgroundColor: Colors.teal[600],
        child: const Icon(Icons.message),
      ),
    );
  }
}
