import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                // image: NetworkImage(
                //   "https://i.ibb.co/Y20L5Mr/photo-1502899576159-f224dc2349fa-ixlib-rb-4-0.jpg",
                // ),
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: sizeHeight * 0.7,
            margin: const EdgeInsets.symmetric(vertical: 150.0),
            child: Column(
              children: [
                const SizedBox(
                  height: AppSize.s40,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(250.0 * 0.5),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 250.0,
                    height: 250.0,
                    // width: Get.width / 1.7,
                    // height: Get.width / 1.7,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 48.0,
                  child: ElevatedButton.icon(
                    icon: const Icon(MdiIcons.google),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.greenColor,
                    ),
                    label: const Text("Sign in Member"),
                    onPressed: () => controller.doLoginAsMember(),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 48.0,
                  child: ElevatedButton.icon(
                    icon: const Icon(MdiIcons.google),
                    label: const Text("Sign in Vendor"),
                    onPressed: () => controller.doLoginAsVendor(),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                const Text(
                  "Term of service",
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
