import 'package:flutter/material.dart';

class CourseDTO {
  final String id, image, name, description, variant;
  final int price;
  final Color bgColor;

  CourseDTO({
    required this.id,
    required this.description,
    required this.image,
    required this.name,
    required this.price,
    required this.variant,
    this.bgColor = const Color(0xFFEFEFF2),
  });
}
