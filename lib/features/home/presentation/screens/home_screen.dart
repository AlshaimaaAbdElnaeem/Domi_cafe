import 'package:domi_cafe/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:domi_cafe/features/profile/screens/profile_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pushNamed(context, Routes.cart);
        }, icon: const Icon(Icons.shopping_cart)),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen()), 
              );
            },
          ),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, Routes.menu);
          }, icon: Icon(Icons.menu))
        ],
      ),
      body: const Center(child: Text("Home Content")),
    );
  }
}
