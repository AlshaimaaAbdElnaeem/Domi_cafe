import 'package:flutter/material.dart';
import 'package:domi_cafe/features/profile/screens/profile_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen()), // بدون const
              );
            },
          ),
        ],
      ),
      body: const Center(child: Text("Home Content")),
    );
  }
}
