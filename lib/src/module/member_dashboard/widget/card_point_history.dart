import 'package:cassiere/core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../shared/constant/app_color.dart';

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
