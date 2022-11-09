import 'dart:io';

import 'package:first_app/src/core/utils/colors.dart';
import 'package:first_app/src/core/utils/styles.dart';
import 'package:first_app/src/feactures/course_lesson/application/controller/course_lesson_item_detail_controller.dart';
import 'package:first_app/src/feactures/course_lesson/data/dto/lesson_item_dto.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'bloc/lesson_bloc_export.dart';

class CourseLessonPage extends StatefulWidget {
  String lessonId;
  CourseLessonPage({super.key, required this.lessonId});

  @override
  State<CourseLessonPage> createState() => _CourseLessonPageState();
}

class _CourseLessonPageState extends State<CourseLessonPage> {
  late Future<Map<dynamic, Map<String, dynamic>>> leccionColletion;
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late List<LessonItemDTO> _pages;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive
            ? const Color.fromARGB(
                255,
                81,
                111,
                211,
              )
            : Colors.black45,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CourseLessonItemDetailController>(
      create: (_) => CourseLessonItemDetailController(),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return const [
            SliverAppBar(
              pinned: true,
              floating: false,
              elevation: 1,
              backgroundColor: Color.fromARGB(255, 203, 224, 241),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Saludos",
                  style: TextStyle(
                    fontFamily: "Pacifico",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 1),
                        blurRadius: 15,
                      ),
                    ],
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ];
        },
        body: CourseItemDetail(context),
      ),
    );
  }

  Widget principalCardContainer(int index) {
    return Container(
      margin: const EdgeInsets.all(25.0),
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Wrap(
        spacing: 10,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text(
            _pages[index].word,
            style: courseLessonTitleStyle,
            textAlign: TextAlign.center,
          ),
          Container(
            padding: const EdgeInsets.all(25.0),
            child: Image.asset(
              _pages[index].image,
              height: 200,
              width: 200,
            ),
          ),
          const SizedBox(height: 15.0),
          Text(
            _pages[index].traduction,
            style: courseLessonSubtitleStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget backDetail() {
    return Container(
      margin: const EdgeInsets.all(25.0),
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                "Top Doctors",
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 3)
              ], color: Colors.white, borderRadius: BorderRadius.circular(9.0)),
              margin: const EdgeInsets.all(9.0),
              padding: const EdgeInsets.all(9.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 226, 162, 157),
                      border: Border.all(color: primaryColor),
                    ),
                    child: Image.asset(
                      "assets/images/languages/LANGUAGE.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Iván Cruz Zabalegui",
                        ),
                        const Text(
                          "Traductor",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Row(
                          children: const <Widget>[
                            Text("iczabalegui@gmail.com"),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget CourseItemDetail(BuildContext context) {
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

    return Scaffold(
      body: BlocConsumer<LessonBloc, LessonState>(listener: (
        context,
        state,
      ) {
        if (state is LoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Loading lesson"),
            ),
          );
        }
      }, builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FailureState) {
          return const Center(
            child: Text("Something went wrong"),
          );
        } else if (state is SuccessState) {
          _pages = state.response;
          return Scaffold(
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 0.4, 0.7, 0.9],
                      colors: [
                        Color.fromARGB(255, 203, 224, 241),
                        Color.fromARGB(255, 232, 232, 233),
                        Color.fromARGB(255, 249, 249, 252),
                        Color.fromARGB(255, 251, 250, 253),
                      ],
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, right: 30, left: 30),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 0.0,
                            vertical: 0.0,
                          ),
                          leading: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(255, 226, 162, 157),
                              border: Border.all(color: primaryColor),
                            ),
                            child: Image.asset(
                              "assets/images/languages/LANGUAGE.png",
                              height: 30,
                              width: 30,
                            ),
                          ),
                          title: const Text(
                            "Los saludos",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: const Text("Saludos y modismos utilizados"),
                        ),
                      ),
                      SizedBox(
                        height: 500.0,
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              itemCount: _pages.length,
                              onPageChanged: (int page) {
                                setState(() {
                                  _currentPage = page;
                                });
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    FlipCard(
                                      key: cardKey,
                                      flipOnTouch: true,
                                      front: principalCardContainer(index),
                                      back: backDetail(),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        /*Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 10,
                                                  color: Colors.black,
                                                  spreadRadius: 2)
                                            ],
                                          ),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.thumb_down_alt_rounded,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                // _matchEngine!.currentItem?.nope();
                                              },
                                              // child: const Text("Nope"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),*/
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 10,
                                                  color: Colors.black,
                                                  spreadRadius: 2)
                                            ],
                                          ),
                                          child: CircleAvatar(
                                            radius: 25.0,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 32.0,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 127, 186, 235),
                                              child: Center(
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.play_arrow,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    //  _matchEngine!.currentItem?.superLike();
                                                  },
                                                  //child: const Text("Superlike"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        /*SizedBox(
                                          width: 50,
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 10,
                                                  color: Colors.black,
                                                  spreadRadius: 2)
                                            ],
                                          ),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.thumb_up_alt_rounded,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () {
                                                //_matchEngine!.currentItem?.like();
                                              },
                                              //  child: const Text("Like"),
                                            ),
                                          ),
                                        ),*/
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
              bottomSheet: _currentPage == _numPages - 1
                  ? InkWell(
                      onTap: () {},
                      child: Container(
                        height: Platform.isIOS ? 70 : 60,
                        color: const Color.fromARGB(255, 81, 111, 211),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.started_now_label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Platform.isIOS ? 70 : 60,
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              _pageController.jumpToPage(_pages.length - 1);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.skip_label,
                              style: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: Platform.isIOS ? 70 : 60,
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(
                                  milliseconds: 500,
                                ),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)!.next_label,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black45,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
        } else {
          return Container();
        }
      }),
    );
  }
}
