import 'package:app_initial/l10n/l10n.dart';
import 'package:flutter/material.dart';

class Localization {
  Localization._singleton();

  static final instance = Localization._singleton();

  static late BuildContext buildContext;

  AppLocalizations get tr {
    return AppLocalizations.of(buildContext);
  }
}
