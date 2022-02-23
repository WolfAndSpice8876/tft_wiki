import 'package:flutter/material.dart';

class StyleImage extends StatelessWidget {

  String path;
  double width;
  double height;
  BoxDecoration? decoration = BoxDecoration();
  BorderRadius? borderRadius = BorderRadius.zero;

  StyleImage({
    Key? key,
    required this.path,
    required this.width,
    required this.height,
    this.decoration,
    this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          path,
          width: width,
          height: height,
        ),
      ),
    );
  }
}