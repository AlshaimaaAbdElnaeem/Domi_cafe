import 'package:flutter/material.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tables Screen'),
      ),
      body: const Center(
        child: Text('This is the Tables Screen'),
      ),
    );
  }
}