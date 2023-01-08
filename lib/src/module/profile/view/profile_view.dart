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
            color: AppColor.whiteColor,
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
    );
  }

  @override
  State<ProfileView> createState() => ProfileController();
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.trailingIcon,
    this.onPressed,
  });
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final IconData? trailingIcon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppSize.s14,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: AppSize.s16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(trailingIcon),
      ),
    );
  }
}
