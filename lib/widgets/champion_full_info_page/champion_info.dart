import 'package:flutter/material.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/database/data_library.dart';
import 'package:lol/dto/champion_dto.dart';
import 'package:lol/dto/item_dto.dart';
import 'package:lol/special_contents/data_materialization.dart';

class Champion_Info extends StatefulWidget {
  bool isOpened;
  ChampionDto championDto;
  Champion_Info({Key? key , required this.isOpened ,required this.championDto}) : super(key: key);

  @override
  State<Champion_Info> createState() => _Champion_InfoState(championData: SpecificChampion(championDto: championDto));
}

class _Champion_InfoState extends State<Champion_Info> {

  SpecificChampion championData;

  _Champion_InfoState({required this.championData});

  Widget Widget_Traits(){

    Widget _Widget_TraitElement(String traitName_){
      return Container(
        width: size(59),
        height: size(28),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size(10)),
            color: Color(0xffEAEEF1)
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            traitName_,
            style: TextStyle(color: Palette.lightColor,fontSize: size(13), fontWeight: FontWeight.w400),
          ),
        ),
      );
    }

    List<Widget> _Widget_TraitElements(){
      List<Widget> result = <Widget>[];
      championData.origins.forEach((element) {
        result.add(_Widget_TraitElement(element!.koreanName));
      });

      championData.classes.forEach((element) {
        result.add(_Widget_TraitElement(element!.koreanName));
      });

      return result;
    }


    return  Padding(
      padding: EdgeInsets.only(left: size(28)),
      child: SizedBox(
        width: size(136),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _Widget_TraitElements()
        ),
      ),
    );
  }

  Widget Widget_Description(){
    return Padding(
      padding: EdgeInsets.only(right: size(15),left: size(15)),
      child: SizedBox(
        height: size(203),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              championData.championDto.skillName,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size(14),
                color: Palette.middleColor
              ),
            ),
            Style.hBox(size(33)),
            Text(
              championData.championDto.skillDescription,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: size(13),
                  color: Palette.lightColor
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Widget_Item(ItemDto itemDto){

    Widget _Widget_Material(ItemDto itemDto){
      return Container(
        width: size(18),
        height: size(18),
        decoration: BoxDecoration(
            color: Palette.mainColor,
            boxShadow: [Style.commonBoxShadow],
            borderRadius: BorderRadius.circular(size(18))
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size(18)),
          child: Image.asset(itemDto.image),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: size(54),
          height: size(54),
          decoration: BoxDecoration(
              color: Palette.mainColor,
              boxShadow: [Style.commonBoxShadow],
              borderRadius: BorderRadius.circular(size(5))
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size(5)),
            child: Image.asset(itemDto.image),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: size(6),left: size(8)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: size(2)),
                child: Row(
                  children: [
                    _Widget_Material(DataLibrary.item.findByName(itemDto.materials[0])),
                    Style.wBox(size(4)),
                    _Widget_Material(DataLibrary.item.findByName(itemDto.materials[0])),
                  ],
                ),
              ),
              Text(
                itemDto.koreanName,
                style: TextStyle(fontSize: size(11), fontWeight: FontWeight.w600, color: Palette.lightColor),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget Widget_ItemView(){
    return Padding(
      padding: EdgeInsets.only(left: size(20)),
      child: Column(
        children: [
          Row(
            children: [
              Widget_Item(DataLibrary.item.findByName("죽음의 검")),
              Style.wBox(size(70)),
              Widget_Item(DataLibrary.item.findByName("죽음의 검")),
            ],
          ),
          Style.hBox(size(46)),
          Row(
            children: [
              Widget_Item(DataLibrary.item.findByName("죽음의 검")),
              Style.wBox(size(70)),
              Widget_Item(DataLibrary.item.findByName("죽음의 검")),
            ],
          ),
        ],
      ),
    );
  }

  Widget Widget_Result(){
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      //height: size(widget.height),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Style.hBox(size(31)),
            Padding(
              padding: EdgeInsets.only(left: size(34), bottom:size(24)),
              child: Text(
                championData.championDto.koreanName,
                style: TextStyle(fontSize: size(18), fontWeight: FontWeight.w700),
              ),
            ),
            Widget_Traits(),
            Style.hBox(size(63)),
            Widget_Description(),
            LimitedBox(maxHeight: size(79),),
            Widget_ItemView(),
            Style.hBox(size(51))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    double _getHeight(double height_){
      return screenHeight * (height_ / 800);
    }
    
    if(widget.isOpened == true)
      return Widget_Result();
    else
      return AnimatedContainer(duration: Duration(milliseconds: 200),height: 0,);
  }
}
