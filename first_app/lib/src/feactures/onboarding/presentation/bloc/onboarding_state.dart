// Estado actual de la aplicación
part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingState {}

class InitialState extends OnboardingState {}

class LoadingState extends OnboardingState {}

class SuccessState extends OnboardingState {
  final List<OnboardingItemDTO> response;
  SuccessState({required this.response});
}

class FailureState extends OnboardingState {
  final Object response;

  FailureState({required this.response});
}
