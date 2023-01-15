// ignore_for_file: unnecessary_null_comparison

import 'package:cassiere/src/service/local_service.dart/hive_service.dart';
import 'package:flutter/material.dart';

import 'core.dart';

void main() async {
  await initialize();
  await HiveProductService.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: const LoginView(),
    );
  }
}
