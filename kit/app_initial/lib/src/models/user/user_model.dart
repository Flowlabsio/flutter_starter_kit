  import 'package:app_initial/src/enums/enums.dart';
  import 'package:freezed_annotation/freezed_annotation.dart';

  part 'user_model.freezed.dart';
  part 'user_model.g.dart';

  @freezed
  class User with _$User {
    const factory User({
      /// The user's id.
      required String id,

      /// The user's first name.
      required String firstName,

      /// The user's last name.
      required String lastName,

      /// The user's email.
      required String email,

      /// The user's photo.
      required String? photo,

      /// The user's roles.
      required List<UserRole> roles,

      /// The user's updated at.
      required DateTime updatedAt,

      /// The user's created at.
      required DateTime createdAt,
    }) = _User;

    factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

    const User._();

    factory User.empty({
      String id = '',
      String firstName = '',
      String lastName = '',
      String email = '',
      String? photo,
      List<UserRole> roles = const [],
      DateTime? updatedAt,
      DateTime? createdAt,
    }) {
      return User(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        photo: photo,
        roles: roles,
        updatedAt: updatedAt ?? DateTime.now(),
        createdAt: createdAt ?? DateTime.now(),
      );
    }

    String get initials {
      if (firstName.isEmpty || lastName.isEmpty) return '';
      return '${firstName[0]}${lastName[0]}'.toUpperCase();
    }

    String get fullName => '$firstName $lastName';
  }
