import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/src/feactures/register_user/data/external_user.dart';

abstract class IExternalUserRepository {
  Future<User> create(ExternalUserDTO externaUser);
}
