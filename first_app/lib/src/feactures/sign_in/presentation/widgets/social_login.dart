import 'package:first_app/src/core/common_widgets/circular_button.dart';
import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularButton(
              onPressed: () {},
              iconPath: "assets/images/svg/facebook.svg",
            ),
            const SizedBox(
              width: 20,
            ),
            CircularButton(
              onPressed: () {},
              iconPath: "assets/images/svg/google.svg",
            ),
            const SizedBox(
              width: 20,
            ),
            CircularButton(
              onPressed: () {},
              iconPath: "assets/images/svg/apple.svg",
            )
          ],
        ),
      ],
    );
  }
}
