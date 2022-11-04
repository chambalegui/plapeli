import 'package:first_app/src/core/common_widgets/rounded_button.dart';
import 'package:first_app/src/core/dto/generic_result.dart';
import 'package:first_app/src/core/routing/routes.dart';
import 'package:first_app/src/core/utils/colors.dart';
import 'package:first_app/src/core/utils/styles.dart';
import 'package:first_app/src/feactures/register_user/application/create_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({Key? key}) : super(key: key);

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        GenericResult<String> response = await ExternalUserService.create(
            _userNameController.text,
            _emailController.text,
            _passwordController.text);
        if (response.status == true) {
          setState(() {
            Navigator.pushReplacementNamed(
              context,
              Routes.signInRoute,
            );
          });
        } else {
          setState(() {
            print("Error: ${response.result}");
          });
        }
      } catch (e) {
        print("Error: ${e}");
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                          AppLocalizations.of(context)!.register_user_label,
                          style: kSubtitleStyle,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      TextFormField(
                        controller: _userNameController,
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
                          labelText:
                              AppLocalizations.of(context)!.user_name_label,
                          labelStyle: const TextStyle(
                            color: greyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
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
                        label: AppLocalizations.of(context)!.register_label,
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
                              Routes.signInRoute,
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.do_you_have_account,
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
