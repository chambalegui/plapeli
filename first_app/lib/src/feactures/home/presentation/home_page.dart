import 'package:first_app/src/core/constants/constant.dart';
import 'package:first_app/src/core/routing/routes.dart';
import 'package:first_app/src/core/utils/firebase_util.dart';
import 'package:first_app/src/feactures/category_detail/presentation/course_detail_page.dart';
import 'package:first_app/src/feactures/curses/domain/course_dto.dart';
import 'package:first_app/src/feactures/curses/presentation/widgets/course_card.dart';
import 'package:first_app/src/feactures/curses/presentation/widgets/primary_text.dart';
import 'package:first_app/src/feactures/search/presentation/search_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<dynamic, Map<String, dynamic>>> cursosColletion;

  @override
  void initState() {
    super.initState();
    cursosColletion = FirebaseUtil.getCollection("/course");
  }

  @override
  Widget build(BuildContext context) {
    List<CourseDTO> cursos = [];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<Map<dynamic, Map<String, dynamic>>>(
          future: cursosColletion,
          builder: (
            BuildContext context,
            AsyncSnapshot<Map<dynamic, Map<String, dynamic>>> snapshot,
          ) {
            if (snapshot.hasData) {
              snapshot.data?.forEach(
                (key, value) {
                  cursos.add(
                    CourseDTO(
                      id: value["id"],
                      description: value["description"],
                      image: value["image"],
                      name: value["name"],
                      price: value["price"],
                      variant: value["variant"],
                      colorA: value["colorA"],
                      colorR: value["colorR"],
                      colorG: value["colorG"],
                      colorB: value["colorB"],
                    ),
                  );
                },
              );
              //return Text('Con cursos...');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 15),
                  const Text(
                    "Mi aprendizaje",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.network(
                                "https://image.freepik.com/free-vector/doctor-concept-illustration_114360-1269.jpg",
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              padding: const EdgeInsets.all(11.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.blue.withOpacity(.3),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "¿No has iniciado con alguno de nuestros cursos?",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Text('Sin cursos...');
            }
          },
        ),
      ),
    );
  }
}
