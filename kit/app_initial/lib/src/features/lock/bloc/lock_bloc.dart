import 'package:app_helpers/app_helpers.dart';
import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/lock/bloc/bloc.dart';
import 'package:app_initial/src/helpers/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LockBloc extends Bloc<UnlockEvent, UnlockState> {
  LockBloc() : super(const UnlockState.initial()) {
    on<LockApp>(_onUnlockTheApp);
  }

  Future<void> _onUnlockTheApp(
    LockApp event,
    Emitter<UnlockState> emit,
  ) async {
    if (state.isUnlocking) return;

    emit(state.copyWith(isUnlocking: true));

    try {
      final check = await SecurityHelper.instance.authenticate(
        localizedReason: Localization.instance.tr.lock_message,
      );

      if (!check) return;

      await Security.instance.setSecurity(
        lastUnlockAt: DateTime.now(),
        wasUnlocked: true,
      );
    } catch (e, s) {
      CustomSnackbar.instance.error(
        text: Localization.instance.tr.generalError,
      );

      AppLogger.error(e.toString(), stackTrace: s);
    } finally {
      emit(state.copyWith(isUnlocking: false));
    }
  }
}
