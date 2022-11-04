import 'package:flutter/material.dart';

class ProductDTO {
  final String image, title;
  final int price;
  final Color bgColor;

  ProductDTO({
    required this.image,
    required this.title,
    required this.price,
    this.bgColor = const Color(0xFFEFEFF2),
  });
}

// ignore: non_constant_identifier_names
List<ProductDTO> demo_product = [
  ProductDTO(
    image: "assets/images/languages/MIXE.png",
    title: "Mixe",
    price: 165,
    bgColor: const Color(0xFFFEFBF9),
  ),
  ProductDTO(
    image: "assets/images/languages/NAHUALT.png",
    title: "Nahualt",
    price: 99,
  ),
  ProductDTO(
    image: "assets/images/languages/MAZATECO.png",
    title: "Mazateco",
    price: 180,
    bgColor: const Color(0xFFF8FEFB),
  ),
  ProductDTO(
    image: "assets/images/languages/OTOMI.png",
    title: "Otomi",
    price: 149,
    bgColor: const Color(0xFFEEEEED),
  ),
  ProductDTO(
    image: "assets/images/languages/TSELTAL.png",
    title: "Tseltal",
    price: 99,
  ),
];
