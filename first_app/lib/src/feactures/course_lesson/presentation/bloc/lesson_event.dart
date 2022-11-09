// Son acciones ejecutadas por el usuario
part of 'lesson_bloc.dart';

@immutable
abstract class LessonEvent {
  List<Object?> get props => [];
}

class LessonRequest extends LessonEvent {
  LessonRequest();
}

class LessonInitial extends LessonEvent {
  @override
  List<Object?> get props => [];
}

class LessonSuccess extends LessonEvent {
  @override
  List<Object?> get props => [];
}

class LessonFailure extends LessonEvent {
  @override
  List<Object?> get props => [];
}
