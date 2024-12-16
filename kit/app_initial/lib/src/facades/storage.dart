import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage._singleton();

  static final instance = Storage._singleton();

  Future<void> set<T>(String key, T value) async {
    final preferences = await SharedPreferences.getInstance();

    if (value is String) {
      await preferences.setString(key, value);
    } else if (value is int) {
      await preferences.setInt(key, value);
    } else if (value is double) {
      await preferences.setDouble(key, value);
    } else if (value is bool) {
      await preferences.setBool(key, value);
    } else if (value is List<String>) {
      await preferences.setStringList(key, value);
    } else {
      throw Exception('Type is not supported');
    }
  }

  Future<T?> get<T>(String key) async {
    final preferences = await SharedPreferences.getInstance();

    if (T == String) {
      return preferences.getString(key) as T?;
    } else if (T == int) {
      return preferences.getInt(key) as T?;
    } else if (T == double) {
      return preferences.getDouble(key) as T?;
    } else if (T == bool) {
      return preferences.getBool(key) as T?;
    } else if (T == List<String>) {
      return preferences.getStringList(key) as T?;
    } else {
      throw Exception('Type is not supported');
    }
  }

  Future<void> remove(String key) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }

  Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
