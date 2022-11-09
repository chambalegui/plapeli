import 'package:bloc/bloc.dart';
import 'package:first_app/src/feactures/course_lesson/application/find/lesson_finder.dart';
import 'package:first_app/src/feactures/course_lesson/data/dto/author_dto.dart';
import 'package:first_app/src/feactures/course_lesson/data/dto/lesson_item_dto.dart';
import 'package:flutter/material.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final LessonFinder lessonFinder;

  LessonBloc(
    this.lessonFinder,
  ) : super(InitialState()) {
    on<LessonRequest>((event, emit) {
      emit(LoadingState());

      try {
        lessonFinder.getItems("id").then((lesson) {
          AuthorDTO authorDTO = AuthorDTO(
            name: "Florentio Ruíz Aquino",
            authorType: "Traducción",
            from: "Juchitán de Zaragoza, Oaxaca.",
          );

          LessonItemDTO lessonItem = LessonItemDTO(
            id: "KJHjkhJGFJGhjgjLKNkoTjf",
            word: "Buenos días / Buenas tardes / Buenas noches",
            traduction: "Padiuxhi",
            authors: [authorDTO],
            image: "assets/images/languages/lessons/saludos/saludos.png",
            audio: "assets/images/languages/lessons/saludos/saludos.mp3",
          );

          emit(SuccessState(response: [lessonItem]));
        });
      } catch (e) {
        emit(FailureState(response: e));
      }
    });
  }
}
