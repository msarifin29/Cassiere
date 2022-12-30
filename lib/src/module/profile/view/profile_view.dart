import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  Widget build(context, ProfileController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton.icon(
                  onPressed: () => controller.doLogout(),
                  icon: const Icon(MdiIcons.logout),
                  label: const Text("Logout"),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                ),
              ),
            ],
          ),
        ],
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
                    CircleAvatar(
                      radius: AppSize.s100,
                      backgroundImage: NetworkImage("${user['photo']}"),
                    ),
                    Positioned(
                      right: AppSize.s6,
                      bottom: AppSize.s6,
                      child: CircleAvatar(
                        radius: AppSize.s30,
                        backgroundColor: AppColor.grey400,
                        child: const Icon(
                          MdiIcons.cameraOutline,
                          size: AppSize.s30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppSize.s40,
              ),
              ListTile(
                leading: const Icon(MdiIcons.accountBadgeOutline),
                title: const Text(
                  "Name",
                  style: TextStyle(
                    fontSize: AppSize.s14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  "${user['name']}",
                  style: const TextStyle(
                    fontSize: AppSize.s16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () => controller.editUserName(
                      context: context, name: user["name"]),
                  icon: const Icon(MdiIcons.pencilOutline),
                ),
              ),
              ListTile(
                leading: const Icon(MdiIcons.emailCheckOutline),
                title: const Text(
                  "Email",
                  style: TextStyle(
                    fontSize: AppSize.s14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(
                  "${user['email']}",
                  style: const TextStyle(
                    fontSize: AppSize.s16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  State<ProfileView> createState() => ProfileController();
}
