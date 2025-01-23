import 'dart:math' as math;

import 'package:app_initial/src/facades/facades.dart' as f;
import 'package:app_initial/src/features/public_onboard/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicOnboardBloc extends Bloc<PublicOnboardEvent, PublicOnboardState> {
  PublicOnboardBloc() : super(const PublicOnboardState.initial()) {
    on<PublicOnboardListeners>(_onPublicOnboardListeners);
    on<UpdatePublicOnboardIndex>(_onUpdatePublicOnboardIndex);
    on<FinishPublicOnboard>(_onFinishPublicOnboard);
  }

  final pageController = PageController();

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  void _onPublicOnboardListeners(
    PublicOnboardListeners event,
    Emitter<PublicOnboardState> emit,
  ) {
    pageController.addListener(() {
      var newPage =
          pageController.offset / pageController.position.viewportDimension;

      var waveIndicator = math.sin(math.pi * newPage).abs();
      if (waveIndicator.abs() < 1e-4) {
        waveIndicator = 0.0;
      }

      if (waveIndicator < 0.40) {
        newPage = newPage.round().toDouble();
      }

      final newPageRounded = newPage.round();

      if (newPageRounded == newPage && newPageRounded != state.index) {
        add(UpdatePublicOnboardIndex(newPageRounded));
      }
    });
  }

  void _onUpdatePublicOnboardIndex(
    UpdatePublicOnboardIndex event,
    Emitter<PublicOnboardState> emit,
  ) {
    emit(state.copyWith(index: event.index));
  }

  void _onFinishPublicOnboard(
    FinishPublicOnboard event,
    Emitter<PublicOnboardState> emit,
  ) {
    f.Session.instance.setIsOnboardingCompleted(
      isPublicOnboardCompleted: true,
    );

    f.Router.instance.goRouter.refresh();
  }
}
