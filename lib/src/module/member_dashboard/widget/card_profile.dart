import 'package:cassiere/core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../shared/constant/app_color.dart';
import '../../../shared/constant/app_string.dart';

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
