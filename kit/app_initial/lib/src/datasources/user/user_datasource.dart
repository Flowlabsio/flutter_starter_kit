import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/models/user/user.dart';

abstract class UserDatasource {
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
