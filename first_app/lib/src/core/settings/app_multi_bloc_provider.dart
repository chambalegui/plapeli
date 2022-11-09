import 'package:first_app/src/feactures/course_lesson/application/find/lesson_finder.dart';
import 'package:first_app/src/feactures/course_lesson/data/repositories/lesson_repository.dart';
import 'package:first_app/src/feactures/onboarding/application/find/onboarding_finder.dart';
import 'package:first_app/src/feactures/onboarding/data/onboarding_repository.dart';
import 'package:first_app/src/feactures/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feactures/course_lesson/presentation/bloc/lesson_bloc_export.dart';

class AppMultiBlocProvider extends StatelessWidget {
  final Widget child;
  const AppMultiBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingBloc>(
          create: (context) => OnboardingBloc(
            OnboardingFinder(
              OnboardingRepository(),
            ),
          )..add(OnboardingRequest()),
        ),
        BlocProvider<LessonBloc>(
          create: (context) => LessonBloc(
            LessonFinder(
              LessonRepository(),
            ),
          )..add(LessonRequest()),
        ),
      ],
      child: child,
    );
  }
}
