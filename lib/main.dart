// import 'package:domi_cafe/app.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'features/auth/presentation/cubit/auth_cubit.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyADuDp22Yd6kZOdtbG4Vm2UeRG2vfsadPk", // من Firebase Console
//       authDomain: "coffee-site-iti.firebaseapp.com",
//       projectId: "coffee-site-iti",
//       storageBucket: "coffee-site-iti.firebasestorage.app",
//       messagingSenderId: "330809796631",
//       appId: "1:330809796631:web:a4f0db5ffc334ff16ad452",
//       measurementId: "G-6QMBCFKMJB", // اختياري للويب
//     ),
//   );

//   runApp(
//     BlocProvider(
//       create: (_) => AuthCubit(),
//       child: const MyApp(),
//     ),
//   );
// }
















import 'package:domi_cafe/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'firebase_options.dart'; // مهم جداً

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ⭐ تهيئة Firebase بالطريقة الصحيحة
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (_) => AuthCubit(),
      child: const MyApp(),
    ),
  );
}
