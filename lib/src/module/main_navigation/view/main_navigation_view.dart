import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({Key? key}) : super(key: key);

  Widget build(context, MainNavigationController controller) {
    controller.view = this;

    return DefaultTabController(
      length: 4,
      initialIndex: controller.selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: const [
            DashboardView(),
            PointHistoryView(),
            ChatView(),
            ProfileView(),
          ],
        ),
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
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.handCoinOutline),
              label: "Point",
            ),
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
  State<MainNavigationView> createState() => MainNavigationController();
}
