import 'package:app_initial/src/models/user.dart';

abstract class UserRepository {
  Future<User> findById(String id);

  Future<User> store({
    required String firstName,
    required String lastName,
    required String email,
    String? id,
  });

  Future<User> update({
    required String? id,
    String? firstName,
    String? lastName,
    String? email,
  });

  Future<void> deleteById(String id);
}

class UserNotFound implements Exception {}

class PermissionDeniedUsers implements Exception {}
