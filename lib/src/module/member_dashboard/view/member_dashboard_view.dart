import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

import '../../../shared/constant/app_string.dart';

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

class CardProfileUser extends StatelessWidget {
  const CardProfileUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: userCollection.snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(child: Text("request failed"));
          }
          Map<String, dynamic> user =
              snapshot.data!.data() as Map<String, dynamic>;
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: AppSize.s12,
              horizontal: AppSize.s12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Get.to(
                    const ProfileView(),
                  ),
                  child: Container(
                      height: AppSize.s250,
                      width: AppSize.s250,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColor.grey300, width: 2.0),
                          image: const DecorationImage(
                              image: AssetImage(
                                AppString.imageOffline,
                              ),
                              fit: BoxFit.cover),
                          color: AppColor.grey300,
                          shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s250 / 2),
                        child: Image.network(
                          "${user['photo']}",
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Chip(
                  backgroundColor: AppColor.cardColor,
                  label: Text(
                    user['name'],
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class CardPointHistory extends StatelessWidget {
  const CardPointHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Object?>>(
        stream: userCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text("Error");
          if (!snapshot.hasData) return const Text("No Data");

          Map<String, dynamic> data =
              (snapshot.data!.data() as Map<String, dynamic>);
          final point = data["point"].toInt() ?? 0;
          return Container(
            width: Get.width * 0.5,
            margin: const EdgeInsets.symmetric(
              vertical: AppSize.s12,
              horizontal: AppSize.s12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s12),
              color: AppColor.whiteColor,
            ),
            child: InkWell(
              onTap: () => Get.to(const PointHistoryView()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        MdiIcons.bitcoin,
                        color: AppColor.greenColor,
                        size: AppSize.s20,
                      ),
                      Text(
                        " Point",
                        style: GoogleFonts.amiko(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "$point",
                    style: const TextStyle(
                      fontSize: AppSize.s24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Tap to history",
                    style: TextStyle(
                      fontSize: AppSize.s12,
                      color: AppColor.greenColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CustomQRCodeWidget extends StatelessWidget {
  const CustomQRCodeWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.3,
      margin: const EdgeInsets.symmetric(
          horizontal: AppSize.s16, vertical: AppSize.s12),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.qr_code_2_outlined,
                  size: AppSize.s60,
                  color: AppColor.blackColor,
                ),
                Text(
                  "Scan QRCode",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColor.lightBlueColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
