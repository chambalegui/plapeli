import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DrawerWidget extends StatelessWidget {
  final ZoomDrawerController zoomController;
  final BuildContext contextZoom;
  const DrawerWidget(
      {Key? key, required this.zoomController, required this.contextZoom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (ZoomDrawer.of(context)!.isOpen()) {
          ZoomDrawer.of(context)!.close();
        } else {
          ZoomDrawer.of(context)!.open();
        }
      },
      icon: SvgPicture.asset("assets/icons/menu.svg"),
    );
  }
}
