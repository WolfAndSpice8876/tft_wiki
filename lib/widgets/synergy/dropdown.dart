import 'package:flutter/material.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/contents/style.dart' as Style;

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {

  bool isOpen = true;
  late double boxHeight;
  late double boxWidth;

  Widget Widget_Element(){
    return Container(
      child: Text(
        "돌연변이",
        style: TextStyle(
          color: Colors.black,
          fontSize: size(14)
        ),
      ),
    );
  }

  Widget Widget_ElementBox(){
    
    if(isOpen == true){
      return Column(
        children: [
          Widget_Element(),
          Widget_Element(),
          Widget_Element(),
          Widget_Element(),
        ],
      );
    }
    else
      return Container(
        width: 100,
        height: 0,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            isOpen = !isOpen;
            print(boxHeight);
            setState(() {});
          },
          child: Container(
            child: Text(
              "직업을 선택하세요",
              style: TextStyle(
                  fontSize: size(14),
                  color: Palette.lightColor
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 200),
          child: LayoutBuilder (
            builder: (BuildContext context, BoxConstraints constraints) {
              boxHeight = constraints.minHeight;
              return Widget_ElementBox();
            }
          )
        ),
      ],
    );
  }
}
