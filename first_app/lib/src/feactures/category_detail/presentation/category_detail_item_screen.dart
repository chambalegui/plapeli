import 'dart:ui';

import 'package:first_app/src/core/utils/colors.dart';
import 'package:first_app/src/core/utils/firebase_util.dart';
import 'package:first_app/src/feactures/category_detail/presentation/details_course_screen.dart';
import 'package:first_app/src/feactures/curses/domain/course_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';

class CategoryItemDetailWidget extends StatefulWidget {
  final CourseDTO curso;

  const CategoryItemDetailWidget({super.key, required this.curso});

  @override
  State<CategoryItemDetailWidget> createState() =>
      _CategoryItemDetailWidgetState();
}

class _CategoryItemDetailWidgetState extends State<CategoryItemDetailWidget> {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const BackButton(color: Colors.black),
          title: Text(
            widget.curso.name,
            style: const TextStyle(
              fontFamily: "Pacifico",
              fontSize: 24,
              color: Color.fromARGB(
                255,
                81,
                111,
                211,
              ),
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
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              child: Image.asset(widget.curso.image),
            ),
            scroll(),
          ],
        ),
      ),
    );
  }

  scroll() {
    return DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 1.0,
        minChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Curso: ${widget.curso.name}",
                    style: const TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 24,
                      color: Color.fromARGB(
                        255,
                        81,
                        111,
                        211,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Variante: ${widget.curso.variant}",
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 16,
                      color: Color.fromARGB(
                        255,
                        81,
                        111,
                        211,
                      ).withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: primaryColor,
                          child: Icon(
                            LineIcons.user,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Iván Cruz Zabalegui",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: greyColor),
                      ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(
                          LineIcons.heartAlt,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "273",
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  const Text(
                    "Descripción",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.curso.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: greyColor),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  const Text(
                    "Lecciones",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                ],
              ),
            ),
          );
        });
  }

  ingredients(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 10,
            backgroundColor: Color(0xFFE3FFF8),
            child: Icon(
              Icons.done,
              size: 15,
              color: primaryColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "4 Eggs",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }

  steps(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: greyColor,
            radius: 12,
            child: Text("${index + 1}"),
          ),
          Column(
            children: [
              SizedBox(
                width: 270,
                child: Text(
                  "Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your",
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: greyColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/images/image1.png",
                height: 155,
                width: 270,
              )
            ],
          )
        ],
      ),
    );
  }
}
