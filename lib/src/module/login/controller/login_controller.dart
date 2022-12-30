import 'package:cassiere/core.dart';
import 'package:cassiere/src/module/main_vendor/view/main_vendor_view.dart';
import 'package:flutter/material.dart';

class LoginController extends State<LoginView> implements MvcController {
  static late LoginController instance;
  late LoginView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  doLoginAsMember() async {
    var isSuccess = await AuthService.doLoginAsMember();
    if (isSuccess) {
      Get.offAll(const MainMemberView());
    }
  }

  doLoginAsVendor() async {
    var isSuccess = await AuthService.doLoginAsVendor();
    if (isSuccess) {
      Get.offAll(const MainVendorView());
    }
  }
}
