// Son acciones ejecutadas por el usuario
part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent {
  List<Object?> get props => [];
}

class OnboardingRequest extends OnboardingEvent {
  OnboardingRequest();
}

class OnboardingInitial extends OnboardingEvent {
  @override
  List<Object?> get props => [];
}

class OnboardingSuccess extends OnboardingEvent {
  @override
  List<Object?> get props => [];
}

class OnboardingFailure extends OnboardingEvent {
  @override
  List<Object?> get props => [];
}
