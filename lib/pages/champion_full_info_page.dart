import 'package:flutter/material.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/dto/champion_dto.dart';
import 'package:lol/pages/test_page.dart';
import 'package:lol/widgets/champion_full_info_page/champion_info.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ChampionFullInfo extends StatefulWidget {
  ChampionDto championDto;
  ChampionFullInfo({Key? key ,required this.championDto});

  @override
  _ChampionFullInfoState createState() => _ChampionFullInfoState();
}

class _ChampionFullInfoState extends State<ChampionFullInfo> {

  bool isOpened = true;
  double infoHeight = 624;
  String svgPath = "assets/champion_info_page/camera.svg";

  //#. 위젯 함수
  Widget Widget_TopButtonTable(){
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: (){
                PageMove.back(context);
              },
                icon: SvgPicture.asset(
                  "assets/back.svg",
                  color: Colors.white,
                  width: size(30),
                  height: size(30),
                ),
              iconSize: size(30),
            ),
            Style.expanded,
            IconButton(
              onPressed: (){
                if(isOpened == true){
                  isOpened = false;
                  svgPath = "assets/champion_info_page/file.svg";
                  setState(() {});
                }
                else{
                  isOpened = true;
                  svgPath = "assets/champion_info_page/camera.svg";
                  setState(() {});
                }
              },
                icon: SvgPicture.asset(
                  svgPath,
                  width: size(24),
                  height: size(24),
                ),
              iconSize: size(24),
            ),
          ],
        ),
      ],
    );
  }

  //#. 빌드
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    double _getHeight(double height_){
      return screenHeight * (height_ / 800);
    }

    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/champion_full/Fiora.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
              //fit: BoxFit.fitWidth,
            ),
            Column(
              children: [
                Style.expanded,
                Champion_Info(isOpened: isOpened,championDto: widget.championDto,),
              ],
            ),
            Column(
              children: [
                Widget_TopButtonTable(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
