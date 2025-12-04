import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/screens/auth_screen.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/home/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyADuDp22Yd6kZOdtbG4Vm2UeRG2vfsadPk", // من Firebase Console
      authDomain: "coffee-site-iti.firebaseapp.com",
      projectId: "coffee-site-iti",
      storageBucket: "coffee-site-iti.firebasestorage.app",
      messagingSenderId: "330809796631",
      appId: "1:330809796631:web:a4f0db5ffc334ff16ad452",
      measurementId: "G-6QMBCFKMJB", // اختياري للويب
    ),
  );

  runApp(
    BlocProvider(
      create: (_) => AuthCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Domi Cafe',
      initialRoute: '/auth',
      routes: {
        '/auth': (_) => const AuthScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
