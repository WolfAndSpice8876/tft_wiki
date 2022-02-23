
import 'package:flutter/material.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/palette.dart' as Palette;

class PageName extends StatelessWidget {
  late String name;
  PageName(String name){
    this.name = name;
  }


  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
          fontSize: size(14),
          color: Palette.orange,
          fontWeight: FontWeight.w600
      ),
    );
  }
}
