import 'package:first_app/src/core/constants/constant.dart';
import 'package:first_app/src/feactures/curses/presentation/widgets/primary_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Category extends StatefulWidget {
  String imagePath;
  String name;
  int index;

  Category({
    super.key,
    required this.name,
    required this.imagePath,
    required this.index,
  });

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int selectedFoodCard = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        setState(
          () => {
            print(widget.index),
            selectedFoodCard = widget.index,
          },
        ),
      },
      child: Container(
        margin: EdgeInsets.only(right: 20, top: 20, bottom: 20),
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:
                selectedFoodCard == widget.index ? primaryColor : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 15,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(widget.imagePath, width: 40),
            PrimaryText(
                text: widget.name, fontWeight: FontWeight.w800, size: 16),
            RawMaterialButton(
                onPressed: null,
                fillColor: selectedFoodCard == widget.index
                    ? Colors.white
                    : Colors.amberAccent,
                shape: CircleBorder(),
                child: Icon(Icons.chevron_right_rounded,
                    size: 20,
                    color: selectedFoodCard == widget.index
                        ? Colors.black
                        : Colors.white))
          ],
        ),
      ),
    );
  }
}
