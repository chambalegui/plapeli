import 'package:first_app/src/core/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircularButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  const CircularButton({
    Key? key,
    required this.onPressed,
    required this.iconPath,
    this.size = 68,
    this.backgroundColor = primaryColor,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          iconPath,
        ),
      ),
    );
  }
}
