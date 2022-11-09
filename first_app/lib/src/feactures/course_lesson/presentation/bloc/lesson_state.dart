// Estado actual de la aplicación
part of 'lesson_bloc.dart';

@immutable
abstract class LessonState {}

class InitialState extends LessonState {}

class LoadingState extends LessonState {}

class SuccessState extends LessonState {
  final List<LessonItemDTO> response;
  SuccessState({required this.response});
}

class FailureState extends LessonState {
  final Object response;

  FailureState({required this.response});
}
