import 'package:first_app/src/core/common_widgets/rounded_button.dart';
import 'package:first_app/src/core/routing/routes.dart';
import 'package:first_app/src/core/utils/colors.dart';
import 'package:first_app/src/core/utils/styles.dart';
import 'package:first_app/src/feactures/sign_in/presentation/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Future<void> submit(BuildContext context) async {
    //final controller = context.read<LoginController>();
    //bool response = await controller.submit();
    //if (response) {
    Navigator.pushReplacementNamed(
      context,
      Routes.homePage,
    );
    //}
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
                    const SizedBox(height: 40.0),
                    TextField(
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
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20.0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        focusedBorder: myfocusborder(),
                        labelText: AppLocalizations.of(context)!.password_label,
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
                      label: AppLocalizations.of(context)!.login_label,
                      fullWidth: true,
                      buttonColor: purpleColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.do_not_have_account,
                        style: const TextStyle(
                          color: greyColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
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
    );
  }
}
