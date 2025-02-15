import 'dart:async';
import 'package:app_initial/src/models/user/user.dart';

class Auth {
  Auth._singleton();

  static final Auth instance = Auth._singleton();

  User? _user;

  final _streamController = StreamController<Auth>.broadcast();

  Stream<Auth> get stream => _streamController.stream;

  String? id() => _user?.id;

  User? user() => _user;

  void setUser(User? user) {
    _user = user;
    _streamController.add(this);
  }

  bool check() => _user != null;

  Future<void> dispose() async {
    await _streamController.close();
  }
}
