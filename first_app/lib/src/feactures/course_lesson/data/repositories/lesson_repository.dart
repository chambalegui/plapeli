import 'package:first_app/src/core/utils/firebase_util.dart';
import 'package:first_app/src/feactures/course_lesson/domain/repositories/lesson_repository.dart';

class LessonRepository extends AbstractLessonRepository {
  @override
  Future<Map<dynamic, Map<String, dynamic>>> getItems(String id) async {
    /*return FirebaseUtil.getCollectionByReference(
      "/lesson",
      "course_id",
      id,
    );*/
    return new Map<dynamic, Map<String, dynamic>>();
  }
}
