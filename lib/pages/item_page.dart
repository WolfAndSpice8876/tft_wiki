import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/widgets/back_button.dart';
import 'package:lol/widgets/page_name.dart';
import 'package:lol/widgets/style_image.dart';


class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {


  Widget Widget_ItemCombination(){
    return Padding(
      padding: EdgeInsets.only(right: size(33),left: size(33)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size(63)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,size(4)),
                    blurRadius: size(4),
                    color: Colors.black.withOpacity(0.25),
                  )
                ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size(63)),
              child: Image.asset(
                "assets/image/item/01.png",
                width: size(63),
                height: size(63),
              )),
          ),
          SvgPicture.asset("assets/image/item/01.png",),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size(63)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,size(4)),
                    blurRadius: size(4),
                    color: Colors.black.withOpacity(0.25),
                  )
                ]
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(size(63)),
                child: Image.asset(
                  "assets/image/item/01.png",
                  width: size(63),
                  height: size(63),
                )),
          ),
          SvgPicture.asset("assets/image/item/01.png"),
          StyleImage(
            path: "assets/image/item/01.png",
            width: size(63), 
            height: size(63),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size(10)),
              boxShadow: [BoxShadow(
                offset: Offset(0,size(4)),
                blurRadius: size(4),
                color: Colors.black.withOpacity(0.25),
              )],
            ),
            borderRadius: BorderRadius.circular(size(10)),
          )
        ],
      ),
    );
  }

  Widget Widget_ItemDescription(){
    return Container(
      width: size(276),
      height: size(192),
      decoration: BoxDecoration(
        color: Palette.mainColor,
        borderRadius: BorderRadius.circular(size(15)),
        boxShadow: [Style.tftShadow],
      ),
    );
  }

  Widget Widget_Items(){
    return Column(
      children: [
        SizedBox(
          width: size(300),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Widget_ItemImage(),
              Widget_ItemImage(),
              Widget_ItemImage(),
              Widget_ItemImage(),
              Widget_ItemImage(),
            ],
          ),
        ),
        SizedBox(
          width: size(234),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Widget_ItemImage(),
              Widget_ItemImage(),
              Widget_ItemImage(),
              Widget_ItemImage(),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget Widget_ItemImage(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size(45)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0,size(4)),
            blurRadius: size(4),
            color: Colors.black.withOpacity(0.25),
          )
        ],
        color: Colors.grey,
      ),
      width: size(48),
      height: size(48),
      // child: ClipRRect(
      //   child: Image.asset(
      //     "assets/champion_face/TFT6_Akali.jpg",
      //     width: size(48),
      //     height: size(48),
      //   ),
      //   borderRadius: BorderRadius.circular(size(45)),
      // ),
    );
  }


  //#. 빌드
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  CustomBackButton(),
                  Style.wBox(size(7)),
                  PageName("아이템 검색"),
                  Style.expanded,
                ],
              ),
              Style.hBox(size(58)),
              Widget_ItemCombination(),
              Style.hBox(size(73)),
              Widget_ItemDescription(),
              Style.hBox(size(74)),
              Widget_Items()
            ],
          ),
        ),
      ),
    );
  }
}



