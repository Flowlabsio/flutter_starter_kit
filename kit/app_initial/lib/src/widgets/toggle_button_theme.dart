import 'dart:async';

import 'package:app_initial/src/facades/facades.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ToggleButtonTheme extends StatefulWidget {
  const ToggleButtonTheme({super.key});

  @override
  State<ToggleButtonTheme> createState() => _ToggleButtonThemeState();
}

class _ToggleButtonThemeState extends State<ToggleButtonTheme> {
  late final StreamSubscription<Preference> _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = Preference.instance.stream.listen((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = Preference.instance.themeMode;

    return ToggleButtons(
      borderRadius: BorderRadius.circular(UISpacing.space2x),
      isSelected: [
        themeMode == ThemeMode.light,
        themeMode == ThemeMode.dark,
        themeMode == ThemeMode.system,
      ],
      onPressed: (int index) {
        switch (index) {
          case 0:
            Preference.instance.setThemeMode(ThemeMode.light);
          case 1:
            Preference.instance.setThemeMode(ThemeMode.dark);
          case 2:
            Preference.instance.setThemeMode(ThemeMode.system);
        }
      },
      children: const [
        Icon(Icons.wb_sunny_outlined),
        Icon(Icons.nights_stay_outlined),
        Icon(Icons.brightness_6_outlined),
      ],
    );
  }
}
