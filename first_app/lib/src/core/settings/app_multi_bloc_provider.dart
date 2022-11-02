import 'package:first_app/src/feactures/onboarding/application/find/onboarding_finder.dart';
import 'package:first_app/src/feactures/onboarding/data/onboarding_repository.dart';
import 'package:first_app/src/feactures/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ],
      child: child,
    );
  }
}
