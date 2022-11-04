import 'package:first_app/src/core/common_widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/config.dart';

class GeneralAppBar extends StatefulWidget with PreferredSizeWidget {
  final ZoomDrawerController zoomController;
  final BuildContext contextZoom;
  const GeneralAppBar({
    Key? key,
    required this.zoomController,
    required this.contextZoom,
  }) : super(key: key);

  @override
  State<GeneralAppBar> createState() => _GeneralAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _GeneralAppBarState extends State<GeneralAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: DrawerWidget(
        zoomController: widget.zoomController,
        contextZoom: widget.contextZoom,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Padiuxhi",
            style: TextStyle(
              fontFamily: "Pacifico",
              fontSize: 25,
              color: Colors.lightGreen,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/Notification.svg"),
          onPressed: () {},
        ),
      ],
    );
  }
}
