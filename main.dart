import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';
import 'register_screen.dart';
import 'courses_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const firebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyB7bc3Prwx_wm4p16OkNF31JDF4Q5oAU6g',
    appId: '1:315197849680:web:f7ac02d64edd5107001155',
    messagingSenderId: '315197849680',
    projectId: 'flutterapp1-797b2',
    authDomain: 'flutterapp1-797b2.firebaseapp.com',
    databaseURL: 'https://flutterapp1-797b2.firebaseio.com',
    storageBucket: 'flutterapp1-797b2.firebasestorage.app',
  );

  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Courses App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/courses': (context) => const CoursesScreen(),
      },
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const CoursesScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
