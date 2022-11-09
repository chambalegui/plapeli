import 'package:first_app/src/feactures/course_lesson/data/repositories/lesson_repository.dart';

class LessonFinder {
  LessonFinder(this.repository);

  final LessonRepository repository;

  Future<Map<dynamic, Map<String, dynamic>>> getItems(String id) async {
    return repository.getItems(id);
  }
}
