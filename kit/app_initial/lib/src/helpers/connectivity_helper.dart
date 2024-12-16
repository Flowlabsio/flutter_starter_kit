import 'dart:async';
import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityHelper with WidgetsBindingObserver {
  ConnectivityHelper._singleton();

  static final ConnectivityHelper instance = ConnectivityHelper._singleton();

  final connectivity = Connectivity();
  late final StreamSubscription<InternetStatus> subscription;

  late final AppLifecycleListener listener;

  AppLifecycleState lastAppStatus = AppLifecycleState.detached;

  bool hasConnection = true;

  void initialize() {
    WidgetsBinding.instance.addObserver(this);

    subscription = InternetConnection()
        .onStatusChange
        .listen((InternetStatus status) async {
      if (lastAppStatus != AppLifecycleState.detached &&
          lastAppStatus != AppLifecycleState.resumed) {
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

    listener = AppLifecycleListener(
      onResume: subscription.resume,
      onHide: subscription.pause,
      onPause: subscription.pause,
    );
  }

  Future<bool> checkConnection({
    bool doubleCheck = true,
  }) async {
    return InternetConnection().hasInternetAccess;
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    final auxLastStatus = lastAppStatus;
    lastAppStatus = state;

    final isAppBack = auxLastStatus == AppLifecycleState.inactive &&
        state == AppLifecycleState.resumed;

    if (isAppBack) {
      final check = await checkConnection();

      if (!check) {
        showNoConnectionSnackbar();
      } else {
        if (!hasConnection) {
          showConnectedSnackbar();
        }
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

  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    await subscription.cancel();
    listener.dispose();
  }
}
