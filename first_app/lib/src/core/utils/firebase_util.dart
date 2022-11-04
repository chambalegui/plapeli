import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtil {
  static late FirebaseFirestore db;

  static Future<Map<dynamic, Map<String, dynamic>>> getCollection(
      String collection) async {
    final firestoreInstance = FirebaseFirestore.instance;
    Map<dynamic, Map<String, dynamic>> result = {};
    int index = 0;
    await firestoreInstance.collection(collection).get().then((querySnapshot) {
      for (var document in querySnapshot.docs) {
        result[index] = document.data();
        result[index]?.putIfAbsent("id", () => document.id);
        index += 1;
      }
    });

    return result;
  }

  static Future<Map<dynamic, Map<String, dynamic>>> getCollectionByReference(
      String collection, String reference, String referenceId) async {
    final firestoreInstance = FirebaseFirestore.instance;
    Map<dynamic, Map<String, dynamic>> result = {};
    int index = 0;
    await firestoreInstance.collection(collection).get().then((querySnapshot) {
      for (var document in querySnapshot.docs) {
        //dynamic documentDb = document.data();
        //dynamic referenceInDB = documentDb["curso_id"];
        if (document.data()[reference].id == referenceId) {
          result[index] = document.data();
          result[index]?.putIfAbsent("id", () => document.id);
          index += 1;
        }
      }
    });

    return result;
  }
}
