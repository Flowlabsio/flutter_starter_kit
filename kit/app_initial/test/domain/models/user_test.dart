import 'package:app_initial/src/enums/enums.dart';
import 'package:app_initial/src/models/user/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User Model Tests', () {
    test('should create a User instance with provided values', () {
      final user = User(
        id: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        photo: 'https://example.com/photo.jpg',
        roles: [UserRole.admin],
        updatedAt: DateTime(2022, 1, 1),
        createdAt: DateTime(2022, 1, 1),
      );

      expect(user.id, '123');
      expect(user.firstName, 'John');
      expect(user.lastName, 'Doe');
      expect(user.email, 'john.doe@example.com');
      expect(user.photo, 'https://example.com/photo.jpg');
      expect(user.roles, [UserRole.admin]);
      expect(user.updatedAt, DateTime(2022, 1, 1));
      expect(user.createdAt, DateTime(2022, 1, 1));
    });

    test('should create an empty User instance with default values', () {
      final emptyUser = User.empty();

      expect(emptyUser.id, '');
      expect(emptyUser.firstName, '');
      expect(emptyUser.lastName, '');
      expect(emptyUser.email, '');
      expect(emptyUser.photo, isNull);
      expect(emptyUser.roles, isEmpty);
      expect(emptyUser.updatedAt, isA<DateTime>());
      expect(emptyUser.createdAt, isA<DateTime>());
    });

    test('should generate correct initials', () {
      final user = User(
        id: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        photo: null,
        roles: [],
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      );

      expect(user.initials, 'JD');
    });

    test('should return an empty string for initials if names are empty', () {
      final emptyUser = User.empty();
      expect(emptyUser.initials, '');
    });

    test('should return the correct fullName', () {
      final user = User(
        id: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        photo: null,
        roles: [],
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
      );

      expect(user.fullName, 'John Doe');
    });

    test('should correctly serialize and deserialize JSON', () {
      final user = User(
        id: '123',
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        photo: 'https://example.com/photo.jpg',
        roles: [UserRole.admin],
        updatedAt: DateTime(2022, 1, 1),
        createdAt: DateTime(2022, 1, 1),
      );

      final json = user.toJson();
      final newUser = User.fromJson(json);

      expect(newUser, user);
    });
  });
}
