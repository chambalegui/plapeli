import 'package:first_app/src/feactures/course_lesson/data/dto/author_dto.dart';
import 'package:flutter/material.dart';

class LessonItemDTO {
  String word;
  String traduction;
  String image;
  String audio;
  String id;
  List<AuthorDTO> authors;

  LessonItemDTO({
    Key? key,
    required this.id,
    required this.word,
    required this.traduction,
    required this.authors,
    required this.image,
    required this.audio,
  });
}
