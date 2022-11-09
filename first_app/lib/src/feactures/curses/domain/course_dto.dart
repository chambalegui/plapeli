import 'package:flutter/material.dart';

class CourseDTO {
  final String id, image, name, description, variant;
  final int price, colorA, colorR, colorG, colorB;
  final Color bgColor;

  CourseDTO({
    required this.id,
    required this.description,
    required this.image,
    required this.name,
    required this.price,
    required this.variant,
    required this.colorA,
    required this.colorR,
    required this.colorG,
    required this.colorB,
    this.bgColor = const Color(0xFFEFEFF2),
  });
}
