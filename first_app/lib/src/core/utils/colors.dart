import 'package:flutter/material.dart';

const primaryColor = Colors.lightBlue;
const greyColor = Color.fromARGB(255, 156, 156, 156);
const purpleColor = Color.fromARGB(
  255,
  81,
  111,
  211,
);

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');

  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }

  return Color(int.parse(hexColor, radix: 16));
}
