import 'package:app_initial/src/enums/enums.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.photo,
    required this.roles,
    required this.updatedAt,
    required this.createdAt,
  });

  User.empty({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.photo,
    this.roles = const [],
    DateTime? updatedAt,
    DateTime? createdAt,
  })  : updatedAt = updatedAt ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? photo;
  final List<UserRole> roles;
  final DateTime updatedAt;
  final DateTime createdAt;

  String get initials {
    if (firstName.isEmpty || lastName.isEmpty) return '';

    return '${firstName[0]}${lastName[0]}'.toUpperCase();
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? photo,
    List<UserRole>? roles,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      photo: photo ?? this.photo,
      roles: roles ?? this.roles,
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
        photo,
        roles,
        updatedAt,
        createdAt,
      ];
}
