import 'package:app_initial/src/datasources/user/user.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/mappers/mappers.dart';
import 'package:app_initial/src/models/models.dart';
import 'package:app_initial/src/repositories/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebaseDatasource implements UserDatasource {
  final _usersCollection = FirebaseFirestore.instance
      .collection(UserFirebaseDatasource._collectionName);

  static const String _collectionName = 'users';

  @override
  Future<void> deleteById(String id) async {
    await _usersCollection.doc(id).delete();
  }

  @override
  Future<User> findById(String id) async {
    try {
      final docRef = _usersCollection.doc(id);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        throw UserNotFound();
      }

      return UserMapper().fromDocumentSnapshot(docSnapshot);
    } catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        throw PermissionDeniedUsers();
      }
      rethrow;
    }
  }

  @override
  Future<User> store({
    required String firstName,
    required String lastName,
    required String email,
    String? id,
    String? photo,
  }) async {
    final docRef = _usersCollection.doc(id);

    final userData = {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'photo': photo,
      'updatedAt': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    };

    await docRef.set(userData);
    final createdSnapshot = await docRef.get();

    if (!createdSnapshot.exists) {
      throw Exception('User not created');
    }

    return UserMapper().fromDocumentSnapshot(createdSnapshot);
  }

  @override
  Future<User> update({
    required String? id,
    String? firstName,
    String? lastName,
    String? email,
    Parameter<String?>? photo,
  }) async {
    final docRef = _usersCollection.doc(id);
    final updates = <String, dynamic>{};

    if (firstName != null) {
      updates['firstName'] = firstName;
    }

    if (lastName != null) {
      updates['lastName'] = lastName;
    }

    if (email != null) {
      updates['email'] = email;
    }

    if (photo != null) {
      updates['photo'] = photo.value;
    }

    updates['updatedAt'] = FieldValue.serverTimestamp();

    await docRef.update(updates);
    final updatedSnapshot = await docRef.get();

    if (!updatedSnapshot.exists) {
      throw Exception('User not updated');
    }

    return UserMapper().fromDocumentSnapshot(updatedSnapshot);
  }
}
