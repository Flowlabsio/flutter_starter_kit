import 'dart:async';

import 'package:app_initial/src/facades/facades.dart';
import 'package:app_initial/src/features/home/bloc/bloc.dart';
import 'package:app_initial/src/helpers/data_notifier.dart';
import 'package:app_initial/src/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.initial()) {
    on<HomeInitial>(_onHomeInitial);
    on<HomeListen>(_onHomeListen);
    on<UpdateUserName>(_onUpdateUserName);
  }

  late final StreamSubscription<User> userSubscription;

  @override
  Future<void> close() async {
    await userSubscription.cancel();
    return super.close();
  }

  Future<void> _onHomeInitial(
    HomeInitial event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(userName: Auth.instance.user()!.firstName));
  }

  void _onHomeListen(
    HomeListen event,
    Emitter<HomeState> emit,
  ) {
    userSubscription = userUpdateNotifier.stream.listen((user) {
      add(UpdateUserName(user.firstName));
    });
  }

  void _onUpdateUserName(
    UpdateUserName event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(userName: event.userName));
  }
}
