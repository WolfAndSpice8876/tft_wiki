import 'package:flutter/material.dart';
import 'package:lol/dto/dto_class.dart';
import 'package:lol/riot/riot_api.dart';
import 'package:lol/normal/size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/normal/date_calculation.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;

const List<Color> placementColor = <Color>[
  Color(0xffFABA48),
  Color(0xff13B188),
  Color(0xff7F7F7F),
];

final List<Color> rarityColor = [
  Color(0xff7F7F7F),
  Color(0xff13B188),
  Color(0xff237AC3),
  Color(0xffBD44D1),
  Color(0xffFABA48)
];



//#. 위젯 함수

Widget Widget_Placement(int placement_ , int queueId_){

  Color _getColor(){
    Color color_ = Colors.black87;
    if(RiotWords.getGameTypeName(queueId_) == "더블 업")
      placement_ = placement_ * 2 - 1;

    switch(placement_){
      case 1 :
        color_ = placementColor[0];
        break;

      case 2 : case 3 : case 4 :
      color_ = placementColor[1];
      break;

      case 5 : case 6 : case 7 : case 8 :
      color_ = placementColor[2];
      break;
    }
    return color_;
  }

  if(RiotWords.getGameTypeName(queueId_) == "더블 업")
    placement_ = ((placement_ + 1) /2).floor();

  return Padding(
    padding: const EdgeInsets.only(right: 15),
    child: Text(
      "#${placement_}등",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: size(11),
        color: _getColor()
      ),
    ),
  );
}

Widget Widget_Level(int level_){
  return Padding(
    padding: const EdgeInsets.only(right: 23),
    child: Text(
      "#${level_}레벨",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: size(11),
        color: Palette.lightColor,
      ),
    ),
  );
}


Widget _Widget_Star(int nums_ , Color color_){

  Widget _star(){
    return SvgPicture.asset(
      "assets/user_page/star.svg",
      width: size(11),
      height: size(11),
      color: color_,
    );
  }

  switch(nums_)
  {
    case 0:
      return SizedBox(height: size(11),);
    case 1:
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _star(),
        ],
      );
    case 2:
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _star(),
          _star(),
        ],
      );
    case 3:
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _star(),
          _star(),
          _star(),
        ],
      );
    default:
      return SizedBox(height: size(11),);
  }
}

Widget _Widget_ChampionImage(String character_id_, int rarity_){

  return Padding(
    padding: EdgeInsets.only(top: size(2),bottom: size(4)),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: rarityColor[rarity_], width: 3),
        color: rarityColor[rarity_]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Image.asset(
          "assets/image/champion_face/$character_id_.png",
          width: size(34),
          height: size(34),
        ),
      ),
    ),
  );
}

Widget _Widget_Items(){
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(size(2))),
        child: Image.asset(
          "assets/image/item/01.png",
          width: size(10),
          height: size(10),
        ),
      )
    ],
  );
}

Widget Widget_ChampionInfo(Tft_UnitInfoDto unitDto_){
  return Padding(
    padding: EdgeInsets.only(right: size(12),bottom: size(9)),
    child: Column(
      children: [
        _Widget_Star(unitDto_.tier,rarityColor[unitDto_.rarity]),
        _Widget_ChampionImage(unitDto_.character_id ,unitDto_.rarity),
        _Widget_Items(),
      ],
    ),
  );
}

Widget Widget_Champions(Tft_MatchDto match_){
  List<Widget> widgets = <Widget>[];
  match_.myParticipantDto.units.forEach((element) {
    if(widgets.length < 12)
      widgets.add(Widget_ChampionInfo(element));
  });

  return Padding(
    padding: EdgeInsets.only(left : size(23)),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: widgets,
      ),
    ),
  );
}

Widget Widget_Synergy(List<Tft_TraitInfoDto> traits_){

  traits_.sort((a, b) => b.style.compareTo(a.style));

  Widget _makeImage(Tft_TraitInfoDto traitDto_){
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Stack(
        alignment: Alignment.center,
        children:[
          Image.asset(
            "assets/user_page/traits_background/${RiotWords.getSynergyTier(traitDto_.style)}.png",
            width: size(18),
            height: size(18),
          ),
          SvgPicture.asset(
            "assets/image/synergy/${traitDto_.name}.svg",
            width: size(12),
            height: size(12),
          ),
          //
          // Image.asset(
          //
          //   width: size(18),
          //   height: size(18),
          // ),
        ],
      ),
    );
  }

  List<Widget> _makeList(){
    List<Widget> _widgets = <Widget>[];
    traits_.forEach((element) {
      if(element.style > 0)
        _widgets.add(_makeImage(element));
    });

    return _widgets;
  }

  List<Widget> widgets = <Widget>[];
  widgets = _makeList();

  return Row(
    children: widgets
  );
}

Widget Widget_QueueName(int queueId_){
  return Text(
    RiotWords.getGameTypeName(queueId_),
    style: TextStyle(
      color: Color(0xff575757),
      fontWeight: FontWeight.w600,
      fontSize: size(11),
    ),
  );
}

Widget Widget_StartTime(int timeStamp_){
  return Text(
    DataCalculation.getTimeDifferenceNow(timeStamp_),
    style: TextStyle(
      color: Color(0xff8E8E8E),
      fontWeight: FontWeight.w600,
      fontSize: size(11),
    ),
  );
}



//#. 함수
