abstract class AbstractLessonRepository {
  Future<Map<dynamic, Map<String, dynamic>>> getItems(String id);
}
