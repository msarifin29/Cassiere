import 'package:cassiere/src/module/product_form/widget/select_dialog.dart';
import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:cassiere/src/shared/constant/app_string.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  Widget build(context, LoginController controller) {
    controller.view = this;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: size.height * 0.8,
        width: size.width,
        margin: const EdgeInsets.symmetric(vertical: 150.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cassiere",
              style: GoogleFonts.cinzel(
                  fontSize: AppSize.s70,
                  color: AppColor.appBarColor,
                  fontWeight: FontWeight.bold),
            ),
            const CircleAvatar(
              radius: AppSize.s150,
              backgroundImage: AssetImage(AppString.iconImage),
            ),
            SizedBox(
              height: AppSize.s60,
              width: size.width * 0.5,
              child: InkWell(
                onTap: () async {
                  selectDialog(
                    iconFirst: MdiIcons.accountOutline,
                    titleFirst: "Customer",
                    onPressedFirst: () async {
                      controller.doLoginAsMember();
                      await Get.back();
                    },
                    iconSecond: MdiIcons.accountTieOutline,
                    titleSecond: "Owner",
                    onPressedSecond: () async {
                      controller.doLoginAsVendor();
                      await Get.back();
                    },
                  );
                },
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/google.png",
                        height: AppSize.s40,
                        width: AppSize.s60,
                      ),
                      const SizedBox(
                        width: AppSize.s12,
                      ),
                      Text(
                        "Sign in",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<LoginView> createState() => LoginController();
}
