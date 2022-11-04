import 'package:first_app/src/core/constants/constant.dart';
import 'package:first_app/src/core/utils/firebase_util.dart';
import 'package:first_app/src/feactures/curses/domain/course_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailsCourseScreen extends StatefulWidget {
  final CourseDTO curso;
  const DetailsCourseScreen({Key? key, required this.curso}) : super(key: key);

  @override
  State<DetailsCourseScreen> createState() => _DetailsCourseScreenState();
}

class _DetailsCourseScreenState extends State<DetailsCourseScreen> {
  late Future<Map<dynamic, Map<String, dynamic>>> leccionColletion;

  @override
  void initState() {
    super.initState();
    leccionColletion = FirebaseUtil.getCollectionByReference(
      "/lesson",
      "course_id",
      widget.curso.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: Text(
          widget.curso.name,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: SvgPicture.asset(
                "assets/icons/Heart.svg",
                height: 20,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            shape: BoxShape.circle,
                            border: Border.all(color: primaryColor),
                          ),
                          child: Image.asset(
                            widget.curso.image,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.curso.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    const Text(
                      "Descripción del curso",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(10),
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
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(widget.curso.description),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Lecciones del curso",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<Map<dynamic, Map<String, dynamic>>>(
                      future: leccionColletion,
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<Map<dynamic, Map<String, dynamic>>>
                            snapshot,
                      ) {
                        if (snapshot.hasData) {
                          return Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: List.generate(
                              snapshot.data!.length,
                              (index) {
                                return SeassionCard(
                                  sesionTitle: snapshot.data![index]!["name"],
                                  sessionImg: snapshot.data![index]!["image"],
                                  level: snapshot.data![index]!["level"],
                                  isDone: true,
                                  press: () {},
                                );
                              },
                            ),
                          );
                        } else {
                          return const Text("Sin lecciones");
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SeassionCard extends StatelessWidget {
  final String sesionTitle;
  final String sessionImg;
  final String level;
  final bool isDone;
  final Function press;
  const SeassionCard({
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
                child: /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
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
                    Text(
                      sesionTitle,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                    )
                  ],
                ),*/
                    ListTile(
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
