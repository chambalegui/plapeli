import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/src/core/dto/generic_result.dart';
import 'package:first_app/src/feactures/register_user/data/external_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExternalUserService {
  static Future<GenericResult<String>> create(
      String username, String email, String password) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final User? user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      ExternalUserDTO externalUserDTO = ExternalUserDTO(
        username,
        user!.uid,
        user.emailVerified,
        user.photoURL,
      );

      DocumentReference<Map<String, dynamic>> documentReferenceResult =
          await FirebaseFirestore.instance
              .collection('external_user')
              .add(externalUserDTO.toJson());

      return GenericResult(status: true, result: "external_user_created");
    } catch (e) {
      String errorMessage = "external_user_error_to_create";
      if (e is FirebaseAuthException) {
        errorMessage = "external_user_repeat";
      }

      return GenericResult(status: false, result: errorMessage);
    }
  }

  static singOut() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.signOut();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
