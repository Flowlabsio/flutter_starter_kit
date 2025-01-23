enum PlatformType {
  unknown,
  android,
  ios;

  String get value {
    switch (this) {
      case PlatformType.unknown:
        return 'unknown';
      case PlatformType.android:
        return 'android';
      case PlatformType.ios:
        return 'ios';
    }
  }

  static PlatformType fromValue(String? value) {
    switch (value) {
      case 'android':
        return PlatformType.android;
      case 'ios':
        return PlatformType.ios;
      default:
        return PlatformType.unknown;
    }
  }
}
