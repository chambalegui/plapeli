import 'package:bloc/bloc.dart';
import 'package:first_app/src/feactures/onboarding/application/find/onboarding_finder.dart';
import 'package:first_app/src/feactures/onboarding/data/onboarding_item_dto.dart';
import 'package:flutter/material.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingFinder onboardingFinder;

  OnboardingBloc(this.onboardingFinder) : super(InitialState()) {
    // Es necesario agregar el On<T>, debido a que es el similar a Add del BlocBuilder.
    on<OnboardingRequest>((event, emit) {
      emit(LoadingState());

      try {
        onboardingFinder.getItems().then((brokerageDetail) {
          emit(SuccessState(response: brokerageDetail));
        });
      } catch (e) {
        emit(FailureState(response: e));
      }
    });
  }
}
