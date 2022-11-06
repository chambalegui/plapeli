import 'package:first_app/src/core/constants/constant.dart';
import 'package:flutter/material.dart';

class LessonItemWidget extends StatelessWidget {
  final String sesionTitle;
  final String sessionImg;
  final String level;
  final bool isDone;
  final Function press;
  const LessonItemWidget({
    Key? key,
    required this.sesionTitle,
    required this.sessionImg,
    required this.level,
    this.isDone = false,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: Colors.grey,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                      border: new Border(
                        right: new BorderSide(
                          width: 1.0,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: isDone ? Colors.blue[50] : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor),
                      ),
                      child: Image.asset(
                        sessionImg,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  title: Text(
                    sesionTitle,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Icon(
                        Icons.linear_scale,
                        color: Color.fromARGB(255, 84, 146, 89),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(level)
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right, size: 30.0),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
