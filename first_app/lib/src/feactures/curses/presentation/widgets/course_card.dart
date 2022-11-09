import 'package:first_app/src/core/utils/colors.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String image;
  final String name;
  final String variant;
  final int colorA;
  final int colorR;
  final int colorG;
  final int colorB;
  final Function press;

  const CourseCard({
    Key? key,
    required this.image,
    required this.name,
    required this.variant,
    required this.press,
    required this.colorA,
    required this.colorR,
    required this.colorG,
    required this.colorB,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: getColorFromHex("#ffefba").withOpacity(0.5),
        borderRadius: BorderRadius.circular(13),
      ),
      child: InkWell(
        onTap: () {
          press();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(colorA, colorR, colorG, colorB),
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryColor),
                ),
                child: Image.asset(
                  "assets/images/languages/LANGUAGE.png",
                  height: 30,
                  width: 30,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                variant,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
