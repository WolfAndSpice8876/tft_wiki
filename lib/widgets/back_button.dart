import 'package:flutter/material.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/contents/palette.dart' as Palette;

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        PageMove.back(context);
      },
      icon: SvgPicture.asset(
        "assets/back.svg",
        width: size(24),
        height: size(24),
      ),
      iconSize: size(24),
      padding: EdgeInsets.zero,
      color: Palette.iconColorGray,
    );
  }
}
