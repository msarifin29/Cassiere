import 'package:cassiere/src/module/main_vendor/view/main_vendor_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core.dart';
import 'src/service/hive_service.dart';

void main() async {
  await initialize();
  if (!kIsWeb) {
    var path = await getTemporaryDirectory();
    Hive.init(path.path);
  }

  mainStorage = await Hive.openBox(productBox);
  HiveProductService.instance.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget isLogin() {
    bool isVendor = AuthService.isVendor;
    final userId = FirebaseAuth.instance.currentUser;
    if (userId != null) {
      return isVendor ? const MainMemberView() : const MainVendorView();
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
