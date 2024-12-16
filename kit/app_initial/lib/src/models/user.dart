import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
  });

  User.empty({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
  })  : updatedAt = DateTime.now(),
        createdAt = DateTime.now();

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime updatedAt;
  final DateTime createdAt;

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    bool? emailVerified,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        updatedAt,
        createdAt,
      ];
}
