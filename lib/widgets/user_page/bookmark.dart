import 'package:flutter/material.dart';
import 'package:lol/normal/size.dart';
import 'package:flutter_svg/flutter_svg.dart';



class BookMarkButton extends StatefulWidget {
  bool isMarked;
  BookMarkButton({Key? key , required this.isMarked}) : super(key: key);

  @override
  _BookMarkButtonState createState() => _BookMarkButtonState();
}

class _BookMarkButtonState extends State<BookMarkButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){

      },
      iconSize: size(31),
      icon: SvgPicture.asset(
        "assets/user_page/bookmark_off.svg",
        width: size(31),
        height: size(31),
      ),
    );
  }
}
