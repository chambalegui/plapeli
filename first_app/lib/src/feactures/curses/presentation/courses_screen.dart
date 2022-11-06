import 'package:first_app/src/core/constants/constant.dart';
import 'package:first_app/src/core/utils/firebase_util.dart';
import 'package:first_app/src/feactures/category_detail/presentation/category_detail_item_widget.dart';
import 'package:first_app/src/feactures/category_detail/presentation/category_item_detail_page.dart';
import 'package:first_app/src/feactures/curses/domain/course_dto.dart';
import 'package:first_app/src/feactures/curses/presentation/widgets/category_card.dart';
import 'package:first_app/src/feactures/curses/presentation/widgets/primary_text.dart';
import 'package:first_app/src/feactures/search/presentation/search_screen.dart';
import 'package:flutter/material.dart';

class Curses extends StatefulWidget {
  const Curses({Key? key}) : super(key: key);

  @override
  State<Curses> createState() => _CursesState();
}

class _CursesState extends State<Curses> {
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
                    "Cursos",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: defaultPadding,
                    ),
                    child: SearchForm(),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: PrimaryText(
                      text: 'Categorias',
                      fontWeight: FontWeight.w700,
                      size: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: .85,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(
                        cursos.length,
                        (index) => CategoryCard(
                          title: cursos[index].name,
                          image: cursos[index].image,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryItemDetailPage(
                                    curso: cursos[
                                        index]), /*DetailsCourseScreen(
                                  curso: cursos[index],
                                )*/
                              ),
                            );
                          },
                        ),
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
