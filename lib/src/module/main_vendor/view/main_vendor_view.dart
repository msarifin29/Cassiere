import 'package:cassiere/src/module/main_vendor/controller/main_vendor_controller.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

class MainVendorView extends StatefulWidget {
  const MainVendorView({Key? key}) : super(key: key);

  Widget build(context, MainVendorController controller) {
    controller.view = this;
    List<Widget> screens = [
      const VendorDashboardView(),
      const ChatView(),
      const ProfileView(),
    ];
    return DefaultTabController(
      length: 3,
      initialIndex: controller.selectedIndex,
      child: Scaffold(
        body: IndexedStack(index: controller.selectedIndex, children: screens),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          onTap: (newIndex) {
            controller.selectedIndex = newIndex;
            controller.setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.homeCircleOutline),
              label: "Home",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(MdiIcons.handCoinOutline),
            //   label: "Point",
            // ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.chatProcessingOutline),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.accountCircleOutline),
              label: "Account",
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<MainVendorView> createState() => MainVendorController();
}
