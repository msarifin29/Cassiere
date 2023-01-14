import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:cassiere/src/shared/constant/app_string.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

import '../widget/custom_list_tile.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  Widget build(context, ProfileController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: AppSize.s40,
              ),
              GestureDetector(
                onTap: () => controller.editUserPhoto(),
                child: Stack(
                  children: [
                    Container(
                        height: AppSize.s250,
                        width: AppSize.s250,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.grey300),
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
                    Positioned(
                      right: AppSize.s6,
                      bottom: AppSize.s6,
                      child: CircleAvatar(
                        radius: AppSize.s30,
                        backgroundColor: AppColor.grey400,
                        child: IconButton(
                          color: Colors.white,
                          icon: const Icon(
                            MdiIcons.cameraOutline,
                            size: AppSize.s30,
                          ),
                          onPressed: () {
                            controller.editUserPhoto();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              CustomListTile(
                leadingIcon: MdiIcons.accountBadgeOutline,
                title: "Name",
                subtitle: "${user['name']}",
                trailingIcon: MdiIcons.pencilOutline,
                onPressed: () => controller.editUserName(
                    context: context, name: user["name"]),
              ),
              CustomListTile(
                  title: "Email",
                  subtitle: "${user['email']}",
                  leadingIcon: MdiIcons.emailCheckOutline),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        height: AppSize.s50,
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s50),
        margin: const EdgeInsets.only(bottom: AppSize.s70),
        child: ElevatedButton(
          onPressed: () => controller.signOut(context),
          child: const Text("Sign out"),
        ),
      ),
    );
  }

  @override
  State<ProfileView> createState() => ProfileController();
}

Future logOutDialog(BuildContext context, {required Function()? onContinue}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Are you sure you ?',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: AppColor.grey600),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: AppColor.appBarColor,
                // ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("No"),
              ),
              ElevatedButton(
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: AppColor.appBarColor,
                // ),
                onPressed: onContinue,
                child: const Text("Yes"),
              ),
            ],
          ),
        ],
      );
    },
  );
}
