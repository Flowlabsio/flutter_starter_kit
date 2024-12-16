import 'package:app_initial/src/enums/enums.dart';
import 'package:equatable/equatable.dart';

class UserCredential extends Equatable {
  const UserCredential({
    required this.id,
    required this.email,
    required this.providers,
  });

  final String id;
  final String email;
  final List<AuthProvider> providers;

  UserCredential copyWith({
    String? id,
    String? email,
    List<AuthProvider>? providers,
  }) {
    return UserCredential(
      id: id ?? this.id,
      email: email ?? this.email,
      providers: providers ?? this.providers,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        providers,
      ];
}
