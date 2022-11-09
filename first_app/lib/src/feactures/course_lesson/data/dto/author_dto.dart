import 'package:flutter/material.dart';

class AuthorDTO {
  String name;
  String authorType;
  String from;

  AuthorDTO({
    Key? key,
    required this.name,
    required this.authorType,
    required this.from,
  });
}
