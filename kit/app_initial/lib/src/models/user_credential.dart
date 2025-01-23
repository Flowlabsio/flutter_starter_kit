import 'package:app_initial/src/enums/enums.dart';
import 'package:equatable/equatable.dart';

class UserCredential extends Equatable {
  const UserCredential({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.providers,
  });

  const UserCredential.initial({
    this.id = '',
    this.email,
    this.firstName,
    this.lastName,
    this.providers = const [],
  });

  final String id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final List<AuthProvider> providers;

  UserCredential copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    List<AuthProvider>? providers,
  }) {
    return UserCredential(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      providers: providers ?? this.providers,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        providers,
      ];
}
