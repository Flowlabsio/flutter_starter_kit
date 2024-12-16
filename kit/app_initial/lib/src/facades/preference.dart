import 'dart:async';

import 'package:app_initial/src/facades/facades.dart';
import 'package:flutter/material.dart';

class Preference {
  Preference._singleton();

  static final instance = Preference._singleton();

  final _streamController = StreamController<Preference>.broadcast();

  Stream<Preference> get stream => _streamController.stream;

  ThemeMode themeMode = ThemeMode.system;
  Locale? locale;

  final themeModeKey = 'themeMode';
  final localeKey = 'locale';

  Future<void> init() async {
    await Future.wait([
      _themeModeInit(),
      _localeInit(),
    ]);
  }

  Future<void> _themeModeInit() async {
    final value = await Storage.instance.get<String>(themeModeKey);

    switch (value) {
      case 'dark':
        themeMode = ThemeMode.dark;
      case 'light':
        themeMode = ThemeMode.light;
      default:
        themeMode = ThemeMode.system;
    }
  }

  Future<void> _localeInit() async {
    final value = await Storage.instance.get<String>(localeKey);

    if (value != null) {
      locale = Locale(value);
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    this.themeMode = themeMode;
    _streamController.add(this);
    await Storage.instance
        .set(themeModeKey, themeMode.toString().split('.').last);
  }

  Future<void> setLocale(Locale? locale) async {
    this.locale = locale;
    _streamController.add(this);

    if (locale == null) {
      await Storage.instance.remove(localeKey);
      return;
    }

    await Storage.instance.set(localeKey, locale.languageCode);
  }

  Future<void> removePreference() async {
    themeMode = ThemeMode.system;
    locale = null;

    _streamController.add(this);

    await Storage.instance.remove(themeModeKey);
    await Storage.instance.remove(localeKey);
  }

  void dispose() {
    _streamController.close();
  }
}
