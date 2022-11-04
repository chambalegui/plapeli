import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/src/core/common_widgets/rounded_button.dart';
import 'package:first_app/src/core/routing/routes.dart';
import 'package:first_app/src/core/utils/colors.dart';
import 'package:first_app/src/core/utils/styles.dart';
import 'package:first_app/src/feactures/register_user/application/create_user.dart';
import 'package:first_app/src/feactures/sign_in/presentation/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool signInError;
  late String signInErrorMessage;
  late bool isLoading;

  Future<void> submit(BuildContext context) async {
    if (!isLoading) {
      if (_formKey.currentState!.validate()) {
        _signInWithEmailAndPassword();
      }
    }
  }

  void _signInWithEmailAndPassword() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      isLoading = true;
    });

    try {
      final User? user = (await auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;

      if (user != null) {
        setState(() async {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("email", user.email!);
          sharedPreferences.setString("token", await user.getIdToken());
          print("Inicio de sesión completado");

          Navigator.pushReplacementNamed(
            context,
            Routes.dashboard,
          );
        });
      } else {
        setState(() {
          print("Ya se ha iniciado sesión");
        });
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        String errorMessage = "";
        if (e.code.compareTo("user-not-found") == 0) {
          print("external_user_not_found");
          errorMessage = AppLocalizations.of(context)!.user_not_found;
        } else if (e.code.compareTo("wrong-password") == 0) {
          print("external_user_wrong_password");
          errorMessage = AppLocalizations.of(context)!.user_wrong_password;
        } else if (e.code.compareTo("user-disabled") == 0) {
          print("external_user_disabled");
          errorMessage = AppLocalizations.of(context)!.user_disabled;
        } else if (e.code.compareTo("too-many-requests") == 0) {
          print("too-many-requests");
          errorMessage = AppLocalizations.of(context)!.too_many_requests;
        }

        setState(() {
          signInError = true;
          signInErrorMessage = errorMessage;
          isLoading = false;
        });

        await Future.delayed(const Duration(seconds: 3));

        setState(() {
          signInError = false;
          signInErrorMessage = "";
        });
      } else {
        setState(() {
          print("${e}");
          isLoading = false;
        });
      }
    }
  }

  Widget errmsg(String text) {
    return Container(
      padding: const EdgeInsets.all(8.00),
      margin: const EdgeInsets.only(bottom: 10.00, top: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(255, 229, 101, 92),
        border: Border.all(
          color: const Color.fromARGB(255, 229, 101, 92),
          width: 2,
        ),
      ),
      child: Row(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 4.00),
          child: const Icon(
            Icons.info,
            color: Colors.white,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    signInError = false;
    isLoading = false;
    ExternalUserService.singOut();
  }

  OutlineInputBorder myfocusborder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: purpleColor,
        width: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Size size = mediaQueryData.size;
    final EdgeInsets padding = mediaQueryData.padding;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: size.height - padding.top - padding.bottom,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.app_name_label,
                        style: const TextStyle(
                          fontFamily: "Pacifico",
                          fontSize: 40,
                          color: Color.fromARGB(
                            255,
                            81,
                            111,
                            211,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.sign_in_label,
                          style: kSubtitleStyle,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      const SocialLogin(),
                      const SizedBox(height: 40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 1.0,
                            color: Colors.black12,
                          ),
                          const SizedBox(width: 20.0),
                          Text(
                            AppLocalizations.of(context)!.or_label,
                            style: const TextStyle(
                              color: greyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Container(
                            width: 80,
                            height: 1.0,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      signInError ? errmsg(signInErrorMessage) : Container(),
                      const SizedBox(height: 40.0),
                      TextFormField(
                        controller: _emailController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .information_required_label;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20.0),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          focusedBorder: myfocusborder(),
                          labelText: AppLocalizations.of(context)!.email_label,
                          labelStyle: const TextStyle(
                            color: greyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        controller: _passwordController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .information_required_label;
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20.0),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          focusedBorder: myfocusborder(),
                          labelText:
                              AppLocalizations.of(context)!.password_label,
                          labelStyle: const TextStyle(
                            color: greyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      RoundedButton(
                        onPressed: () => submit(context),
                        label: isLoading
                            ? AppLocalizations.of(context)!.loading_label
                            : AppLocalizations.of(context)!.login_label,
                        fullWidth: true,
                        buttonColor: purpleColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 40),
                      ),
                      const SizedBox(height: 20.0),
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.registerUser,
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.do_not_have_account,
                            style: const TextStyle(
                              color: greyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
