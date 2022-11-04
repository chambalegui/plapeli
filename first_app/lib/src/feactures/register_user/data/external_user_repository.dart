import 'package:first_app/src/feactures/register_user/data/external_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/src/feactures/register_user/domain/external_user_repository.dart';

class ExternalUserRepositore extends IExternalUserRepository {
  @override
  Future<User> create(ExternalUserDTO externaUser) {
    // TODO: implement create
    throw UnimplementedError();
  }
}
