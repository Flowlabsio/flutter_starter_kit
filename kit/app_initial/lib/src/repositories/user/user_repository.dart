import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/models/user.dart';

abstract class UserRepository {
  Future<User> findById(String id);

  Future<User> store({
    required String firstName,
    required String lastName,
    required String email,
    String? id,
    String? photo,
  });

  Future<User> update({
    required String? id,
    String? firstName,
    String? lastName,
    String? email,
    Parameter<String?>? photo,
  });

  Future<void> deleteById(String id);
}

class UserNotFound implements Exception {}

class PermissionDeniedUsers implements Exception {}
