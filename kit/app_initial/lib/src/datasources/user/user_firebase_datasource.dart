import 'package:app_initial/src/datasources/user/user.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:app_initial/src/mappers/mappers.dart';
import 'package:app_initial/src/models/models.dart';
import 'package:app_initial/src/repositories/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';

class UserFirebaseDatasource implements UserDatasource {
  final _usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> deleteById(String id) async {
    final userDocRef = _usersCollection.doc(id);

    final subCollections = [
      'devices',
      'notifications',
    ];

    for (final subCollectionName in subCollections) {
      final subCollectionRef = userDocRef.collection(subCollectionName);
      final querySnapshot = await subCollectionRef.get();

      final batch = FirebaseFirestore.instance.batch();
      for (final doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    }

    await userDocRef.delete();
  }

  @override
  Future<Result<User>> findById(String id) async {
    try {
      final docRef = _usersCollection.doc(id);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        throw UserNotFound();
      }

      return UserMapper().fromDocumentSnapshot(docSnapshot).toSuccess();
    } on Exception catch (e) {
      if (e is FirebaseException && e.code == 'permission-denied') {
        return PermissionDeniedUsers().toFailure();
      }
      return e.toFailure();
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
    final ref = _usersCollection.doc(id);

    await ref.set({
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'photo': photo,
      'roles': <String, bool>{},
      'updatedAt': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    final createdSnapshot = await ref.get();

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

    final ref = _usersCollection.doc(id);

    await ref.update(updates);

    final updatedSnapshot = await ref.get();

    if (!updatedSnapshot.exists) {
      throw Exception('User not updated');
    }

    return UserMapper().fromDocumentSnapshot(updatedSnapshot);
  }
}
