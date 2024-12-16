import 'package:app_initial/src/datasources/user/user.dart';
import 'package:app_initial/src/models/models.dart';
import 'package:app_initial/src/repositories/user/user.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({required this.userDatasource});

  final UserDatasource userDatasource;

  @override
  Future<void> deleteById(String id) {
    return userDatasource.deleteById(id);
  }

  @override
  Future<User> findById(String id) {
    return userDatasource.findById(id);
  }

  @override
  Future<User> store({
    required String firstName,
    required String lastName,
    required String email,
    String? id,
  }) {
    return userDatasource.store(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
    );
  }

  @override
  Future<User> update({
    required String? id,
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return userDatasource.update(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
    );
  }
}
