import 'package:first_app/src/core/common_widgets/rounded_button.dart';
import 'package:first_app/src/core/utils/colors.dart';
import 'package:first_app/src/core/utils/firebase_util.dart';
import 'package:first_app/src/feactures/category_detail/presentation/category_item_detail_controller.dart';
import 'package:first_app/src/feactures/category_detail/presentation/details_course_screen.dart';
import 'package:first_app/src/feactures/category_detail/presentation/widgets/logo_widget.dart';
import 'package:first_app/src/feactures/curses/domain/course_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class CategoryItemDetailPage extends StatefulWidget {
  final CourseDTO curso;

  const CategoryItemDetailPage({super.key, required this.curso});

  @override
  State<CategoryItemDetailPage> createState() =>
      _CategoryItemDetailWidgetState();
}

class _CategoryItemDetailWidgetState extends State<CategoryItemDetailPage> {
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
              backgroundColor: Color.fromARGB(255, 245, 183, 27),
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 2,
                centerTitle: true,
                title: Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  child: Text(
                    widget.curso.name,
                    style: const TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                background: FadeInImage(
                  placeholder: Image.asset("assets/images/loading.gif").image,
                  image: Image.asset(
                    "assets/images/fondo.png",
                  ).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child:
          /*ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: Image.asset("assets/images/loading.gif").image,
              image: Image.asset(
                widget.curso.image,
              ).image,
              height: 100,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.curso.name,
                style: const TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 18,
                  color: Color.fromARGB(
                    255,
                    81,
                    111,
                    211,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.curso.variant,
              ),
            ],
          )*/
          ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 0.0,
        ),
        leading: Container(
          decoration: new BoxDecoration(
            border: new Border(
              right: new BorderSide(
                width: 1.0,
                color: Colors.white24,
              ),
            ),
          ),
          child: Image.asset(
            widget.curso.image,
            height: 60,
            width: 60,
          ),
        ),
        title: Text(
          widget.curso.name,
          style: TextStyle(
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
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
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
          SizedBox(
            height: 15,
          ),
          Text(
            widget.curso.description,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.justify,
          ),
          SizedBox(
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
                return const Text("Cargando lecciones...");
              }
            },
          ),
          const SizedBox(height: 40.0),
          RoundedButton(
            onPressed: () {},
            label: "Iniciar",
            fullWidth: true,
            buttonColor: Color.fromARGB(255, 245, 183, 27),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          ),
        ],
      ),
    );
  }
}
