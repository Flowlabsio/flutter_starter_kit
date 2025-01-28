enum UserRole {
  admin,
  viewer;

  String get value {
    switch (this) {
      case UserRole.admin:
        return 'admin';
      case UserRole.viewer:
        return 'viewer';
    }
  }

  static UserRole fromString(String value) {
    switch (value) {
      case 'admin':
        return UserRole.admin;
      case 'viewer':
        return UserRole.viewer;
      default:
        throw Exception('Unknown user role: $value');
    }
  }
}
