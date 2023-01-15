import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

import '../widget/card_point_history.dart';
import '../widget/card_profile.dart';
import '../widget/custom_qrcode_widget.dart';

class MemberDashboardView extends StatefulWidget {
  const MemberDashboardView({Key? key}) : super(key: key);

  Widget build(context, MemberDashboardController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cassiere"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: AppSize.s20,
          ),
          Card(
            color: AppColor.cardColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomQRCodeWidget(
                  onTap: () async {
                    await controller.scanQrCode();
                  },
                ),
                const CardPointHistory(),
              ],
            ),
          ),
          const SizedBox(
            height: AppSize.s20,
          ),
          const CardProfileUser(),
        ],
      ),
    );
  }

  @override
  State<MemberDashboardView> createState() => MemberDashboardController();
}
