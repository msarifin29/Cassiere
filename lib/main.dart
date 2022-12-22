import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'core.dart';

void main() async {
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget isLogin() {
    final userId = FirebaseAuth.instance.currentUser;
    if (userId != null) {
      return const MainNavigationView();
    } else {
      return const LoginView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: isLogin(),
    );
  }
}
