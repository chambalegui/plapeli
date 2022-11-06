import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoWidget extends StatelessWidget {
  final String url;
  final double transformX;
  final double transformY;
  final double transformZ;
  final bool isLoading;

  const LogoWidget({
    Key? key,
    required this.url,
    this.transformX = 0.0,
    this.transformY = -45.0,
    this.transformZ = 0.0,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSvgPicture = false;
    if (url.contains(".svg")) isSvgPicture = true;

    return Center(
      child: Container(
        transform:
            Matrix4.translationValues(transformX, transformY, transformZ),
        width: 90,
        height: 90,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              offset: Offset(0.0, 6.0),
            )
          ],
        ),
        child: ClipOval(
          child: Column(
            children: [
              Expanded(
                  child: isSvgPicture
                      ? SvgPicture.network(
                          url,
                          fit: BoxFit.fitWidth,
                        )
                      : Image.asset(
                          url,
                          fit: BoxFit.fitWidth,
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
