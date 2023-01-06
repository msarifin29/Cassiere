// ignore_for_file: void_checks

import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';

enum PageView { member, vendor }

Future<void> errorPage(BuildContext context, VoidCallback? onPressed) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 300.0,
                width: 300.0,
                margin: const EdgeInsets.only(bottom: AppSize.s40),
                child: Image.asset("assets/images/error_image.jpg"),
              ),
              ElevatedButton(
                onPressed: onPressed,
                child: const Text("Home"),
              ),
            ],
          ),
        );
      });
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300.0,
              width: 300.0,
              margin: const EdgeInsets.only(bottom: AppSize.s40),
              child: Image.asset("assets/images/error_image.jpg"),
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text("Home"),
            ),
          ],
        ),
      ),
    );
  }
}
