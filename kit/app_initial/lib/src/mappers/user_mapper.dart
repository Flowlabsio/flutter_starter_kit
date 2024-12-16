import 'package:app_initial/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserMapper {
  factory UserMapper() {
    return _instance;
  }
  UserMapper._singleton();

  static final UserMapper _instance = UserMapper._singleton();

  User fromDocumentSnapshot(DocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data()! as Map<String, dynamic>;
    return User(
      id: snapshot.id,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      email: data['email'] as String,
      photo: data['photo'] as String?,
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
