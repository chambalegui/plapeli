import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/src/core/dto/generic_result.dart';
import 'package:flutter/widgets.dart';

class SignInController extends ChangeNotifier {
  String email = "", password = "";

  void onEmailChanged(String text) {
    email = text;
  }

  void onPasswordChanged(String text) {
    password = text;
  }

  Future<bool> submit() async {
    /*GenericResult<User> genericResult =
        await _authenticationRepository.login(email, password);
    if (genericResult.status == true) {
      print("El usuario ha iniciado sesión correctamente.");
      return true;
    } else {
      print("El usuario/contraseña son incorrectos.");
      return false;
    }*/

    return true;
  }
}
