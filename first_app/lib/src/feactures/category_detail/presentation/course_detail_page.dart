import 'package:first_app/src/core/common_widgets/rounded_button.dart';
import 'package:first_app/src/core/utils/colors.dart';
import 'package:first_app/src/core/utils/firebase_util.dart';
import 'package:first_app/src/feactures/category_detail/application/category_item_detail_controller.dart';
import 'package:first_app/src/feactures/category_detail/presentation/widgets/lesson_item_widget.dart';
import 'package:first_app/src/feactures/course_lesson/presentation/course_lesson_page.dart';
import 'package:first_app/src/feactures/curses/domain/course_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CourseDetailPage extends StatefulWidget {
  final CourseDTO curso;

  const CourseDetailPage({super.key, required this.curso});

  @override
  State<CourseDetailPage> createState() => _CategoryItemDetailWidgetState();
}

class _CategoryItemDetailWidgetState extends State<CourseDetailPage> {
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
    return ChangeNotifierProvider<CategoryItemDetailController>(
      create: (_) => CategoryItemDetailController(course: widget.curso),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
                pinned: true,
                floating: false,
                elevation: 1,
                expandedHeight: 160,
                backgroundColor: Color.fromARGB(
                  widget.curso.colorA,
                  widget.curso.colorR,
                  widget.curso.colorG,
                  widget.curso.colorB,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    child: Text(
                      widget.curso.name,
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: const [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(2, 1),
                            blurRadius: 15,
                          ),
                        ],
                        color: Color.fromARGB(
                          widget.curso.colorA,
                          widget.curso.colorR,
                          widget.curso.colorG,
                          widget.curso.colorB,
                        ),
                      ),
                    ),
                  ),
                  background: Hero(
                    tag: widget.curso.id,
                    child: FadeInImage(
                      placeholder:
                          Image.asset("assets/images/loading.gif").image,
                      image: Image.asset(
                        "assets/images/fondo.png",
                      ).image,
                      fadeInDuration: const Duration(milliseconds: 150),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ];
        },
        body: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    courseDetail(),
                    courseDetailDescription(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget courseDetail() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 0.0,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(
              widget.curso.colorA,
              widget.curso.colorR,
              widget.curso.colorG,
              widget.curso.colorB,
            ),
            border: Border.all(color: primaryColor),
          ),
          child: Image.asset(
            "assets/images/languages/LANGUAGE.png",
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          widget.curso.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(widget.curso.variant),
        trailing: IconButton(
          onPressed: () {
            print("Add heart");
          },
          icon: CircleAvatar(
            backgroundColor: Colors.white,
            child: SvgPicture.asset(
              "assets/icons/Heart.svg",
              height: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget courseDetailDescription() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Descripción",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.curso.description,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Lecciones",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<Map<dynamic, Map<String, dynamic>>>(
            future: leccionColletion,
            builder: (
              BuildContext context,
              AsyncSnapshot<Map<dynamic, Map<String, dynamic>>> snapshot,
            ) {
              if (snapshot.hasData) {
                return Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: List.generate(
                    snapshot.data!.length,
                    (index) {
                      return LessonItemWidget(
                        sesionTitle: snapshot.data![index]!["name"],
                        sessionImg: snapshot.data![index]!["image"],
                        level: snapshot.data![index]!["level"],
                        isDone: true,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseLessonPage(
                                  lessonId: snapshot.data![index]!["id"]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              } else {
                return const Text("Cargando lecciones...");
              }
            },
          ),
          const SizedBox(height: 40.0),
          RoundedButton(
            onPressed: () {},
            label: "Iniciar",
            fullWidth: true,
            buttonColor: Color.fromARGB(
              widget.curso.colorA,
              widget.curso.colorR,
              widget.curso.colorG,
              widget.curso.colorB,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          ),
        ],
      ),
    );
  }
}
