import 'package:first_app/src/core/common_widgets/drawer_menu.dart';
import 'package:first_app/src/feactures/dashboard/presentation/dashboard_screen.dart';
import 'package:first_app/src/feactures/sign_in/presentation/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MenuItem {
  String title;
  IconData icon;
  MenuItem(this.icon, this.title);
}

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int currentIndex = 0;
  final ZoomDrawerController zoomController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomController,
      menuScreen: DrawerMenu(
        setIndex: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      mainScreen: currentScreen(),
      borderRadius: 30,
      showShadow: true,
      androidCloseOnBackTap: true,
      mainScreenTapClose: true,
      moveMenuScreen: true,
      angle: 0.0,
      slideWidth: 200,
      menuBackgroundColor: Colors.deepPurple,
    );
  }

  Widget currentScreen() {
    switch (currentIndex) {
      case 4:
        return const SignInScreen();
      default:
        return const DashboardScreen();
    }
  }
}
