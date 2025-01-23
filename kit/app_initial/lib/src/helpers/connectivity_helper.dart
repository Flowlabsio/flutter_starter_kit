import 'dart:async';
import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityHelper {
  ConnectivityHelper._singleton();

  static final ConnectivityHelper instance = ConnectivityHelper._singleton();

  late final AppLifecycleListener listener;

  bool hasConnection = true;

  Future<void> initialize() async {
    InternetConnection().onStatusChange.listen((InternetStatus status) async {
      final state = AppLifecycleHelper.instance.previousEvent.state;

      if (state != AppLifecycleState.inactive &&
          state != AppLifecycleState.resumed) {
        return;
      }

      if (status == InternetStatus.disconnected) {
        if (hasConnection) {
          showNoConnectionSnackbar();
        }
      } else {
        if (!hasConnection) {
          showConnectedSnackbar();
        }
      }
    });
  }

  Future<bool> checkConnection({
    bool doubleCheck = true,
  }) async {
    return InternetConnection().hasInternetAccess;
  }

  Future<void> analyzeConnection() async {
    final check = await checkConnection();

    if (!check) {
      showNoConnectionSnackbar();
    } else {
      if (!hasConnection) {
        showConnectedSnackbar();
      }
    }
  }

  void showConnectedSnackbar() {
    hasConnection = true;

    CustomSnackbar.instance.info(
      text: Localization.instance.tr.connected,
    );
  }

  void showNoConnectionSnackbar() {
    hasConnection = false;

    CustomSnackbar.instance.error(
      text: Localization.instance.tr.notConnected,
      duration: const Duration(seconds: 10),
    );
  }
}
