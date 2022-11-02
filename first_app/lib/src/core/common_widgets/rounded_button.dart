import 'package:first_app/src/core/utils/colors.dart';
import 'package:first_app/src/core/utils/font_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color textColor, buttonColor, borderColor;
  final bool fullWidth;
  final EdgeInsets padding;

  const RoundedButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      this.textColor = Colors.white,
      this.buttonColor = primaryColor,
      this.borderColor = primaryColor,
      this.fullWidth = true,
      this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 30)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      minSize: 30,
      child: Container(
        height: 60.0,
        width: fullWidth ? double.infinity : null,
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: FontStyles.normal.copyWith(color: textColor),
        ),
      ),
    );
  }
}
