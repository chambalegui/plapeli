import 'package:first_app/src/feactures/onboarding/presentation/onboarding_screen.dart';
import 'package:first_app/src/feactures/register_user/presentation/register_user_screen.dart';
import 'package:first_app/src/feactures/sign_in/presentation/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';

import 'routes.dart';

abstract class Pages {
  static const String initial = Routes.onboardingRoute;
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.onboardingRoute: (_) => const OnboardingScreen(),
    Routes.signInRoute: (_) => const SignInScreen(),
    Routes.registerUser: (_) => const RegisterUserScreen(),
  };
}
