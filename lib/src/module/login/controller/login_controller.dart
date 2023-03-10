import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';

class LoginController extends State<LoginView> {
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
      Get.offAll(const MemberDashboardView());
    }
  }

  doLoginAsVendor() async {
    var isSuccess = await AuthService.doLoginAsVendor();
    if (isSuccess) {
      Get.offAll(const VendorDashboardView());
    }
  }
}
