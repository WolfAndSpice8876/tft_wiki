
import 'package:flutter/material.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/database/data_library.dart';
import 'package:lol/dto/trait_dto.dart';
import 'package:lol/pages/champion_full_info_page.dart';
import 'package:lol/dto/champion_dto.dart';
import 'package:page_transition/page_transition.dart';

class ChampionElement extends StatelessWidget {
  ChampionDto championDto;

  List<TraitDto> origins = <TraitDto>[];
  List<TraitDto> classes = <TraitDto>[];


  ChampionElement({required this.championDto}){
    origins = <TraitDto>[];
    classes = <TraitDto>[];

    championDto.origins.forEach((element) {
      TraitDto? temp = DataLibrary.trait.allByKoreanName[element];
      temp ??= TraitDto.blank();
      origins.add(temp);
    });

    championDto.classes.forEach((element) {
      TraitDto? temp = DataLibrary.trait.allByKoreanName[element];
      temp ??= TraitDto.blank();
      classes.add(temp);
    });
  }






  //#. 위젯 함수

  Widget _Widget_Face(){
    return Padding(
      padding: EdgeInsets.only(left: size(7), right: size(17)),
      child: Container(
        width: size(73),
        height: size(73),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size(73)),
            color: Colors.black,
            boxShadow: [Style.Champions.commonShadow]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size(73)),
          child: Image.asset(championDto.image),
        ),
      ),
    );
  }

  Widget _Widget_Info(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 6,bottom: size(10)),
          child: Text(
            championDto.koreanName,
            style: TextStyle(
              fontSize: size(12),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 2,bottom: 2),
              child: Image.asset(
                origins[0].image,
                width: size(15),
                height: size(15),
              ),
            ),
            Text(
              origins[0].koreanName,
              style: TextStyle(
                fontSize: size(10),
                fontWeight: FontWeight.w600,
                color: Palette.lightColor
              ),
            ),
          ],
        ),
        Style.hBox(size(2)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 2),
              child: Image.asset(
                classes[0].image,
                width: size(15),
                height: size(15),
              ),
            ),
            Text(
              classes[0].koreanName,
              style: TextStyle(
                fontSize: size(10),
                fontWeight: FontWeight.w600,
                color: Palette.lightColor
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _Widget_Item(){

    Widget _image(){
      return Container(
        width: size(25),
        height: size(25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size(25)),
            color: Colors.black,
            boxShadow: [Style.Champions.commonShadow]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size(25)),
          child: Image.asset(championDto.image),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(right: size(15)),
      child: SizedBox(
        width: size(124),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _image(),
            _image(),
            _image(),
            _image(),
          ],
        ),
      ),
    );
  }


  //#. 빌드
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        PageMove.moveWithAnime(
          context,
          ChampionFullInfo(championDto: championDto),
          PageTransitionType.bottomToTop,
          Duration(milliseconds: 300),
        );
        //PageMove.move(context, ChampionFullInfo(championDto: championDto,));
      },
      child: Container(
        height: size(86),
        margin: EdgeInsets.fromLTRB(size(7), 0, size(7), size(21)),
        decoration: BoxDecoration(
            color: Palette.mainColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [Style.Champions.commonShadow]
        ),
        child: Row(
          children: [
            _Widget_Face(),
            _Widget_Info(),
            Style.expanded,
            _Widget_Item(),
          ],
        ),
      ),
    );
  }
}