import 'package:first_app/src/feactures/curses/domain/course_dto.dart';
import 'package:flutter/foundation.dart';

class CategoryItemDetailController extends ChangeNotifier {
  CourseDTO course;
  CategoryItemDetailController({required this.course});
}
