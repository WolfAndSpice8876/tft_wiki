import 'package:flutter/material.dart';
import 'package:lol/dto/dto_class.dart';
import 'package:lol/riot/riot_api.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/widgets/user_page/match_element_segments.dart';


class MatchElement extends StatefulWidget {
  Tft_MatchDto tft_matchDto;
  MatchElement({Key? key, required this.tft_matchDto}) : super(key: key);
  bool isOpened = false;
  @override
  _MatchElementState createState() => _MatchElementState();
}

class _MatchElementState extends State<MatchElement> {

  bool isOpened = false;
  int animeTime = 150;

  //#. 위젯 함수
  Widget Widget_Closed(){
    Tft_MatchDto match = widget.tft_matchDto;

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.fromLTRB(0, 0, size(10), size(30)),
      height: size(83),
      decoration: BoxDecoration(
        color: Color(0xffEAEEF1),
        borderRadius: BorderRadius.only(topRight: Radius.circular(size(10)) , bottomRight: Radius.circular(size(10))),
        boxShadow: [Style.User.matchElementShadow],
      ),
      child: Column(
        children: [
          Widget_BasicInfo(true),
        ],
      ),
    );
  }

  Widget Widget_Opened(){
    Tft_MatchDto match = widget.tft_matchDto;

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.fromLTRB(0, 0, size(10), size(30)),
      height: size(230),
      decoration: BoxDecoration(
        color: Color(0xffEAEEF1),
        borderRadius: BorderRadius.only(topRight: Radius.circular(size(10)) , bottomRight: Radius.circular(size(10))),
        boxShadow: [Style.User.matchElementShadow],
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Widget_BasicInfo(false),
            Widget_OpenInfo(),
          ],
        ),
      ),
    );
    // return Column(
    //   children: [
    //     Widget_BasicInfo(false),
    //     Widget_OpenInfo(),
    //   ],
    // );
  }

  Widget Widget_BasicInfo(bool set_){
    Tft_MatchDto match = widget.tft_matchDto;

    return SizedBox(
      height: size(80),
      child: Padding(
        padding: EdgeInsets.fromLTRB(size(20), size(15), size(20), size(0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widget_Synergy(match.myParticipantDto.traits), // 시너지 이미지
            Expanded(child: SizedBox()),
            Row(
              children: [
                Widget_QueueName(match.matchinfoDto.queueId), //랭크
                Style.wBox(size(22)),
                Widget_StartTime(match.matchinfoDto.gameDataTime), //시간
                Expanded(child: SizedBox(),),
                Widget_Placement(match.myParticipantDto.placement,match.matchinfoDto.queueId),
                Widget_Level(match.myParticipantDto.level),
                GestureDetector(
                    onTap: (){
                      widget.isOpened = set_;
                      setState(() {});
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/user_page/down.png",
                          width: size(12),
                          height: size(12),
                        ),
                        Container(
                          width: size(20),
                          height: size(20),
                        )
                      ],
                    )
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size(5)),
              child: Divider(color: Color(0xffD4D4D4),thickness: 2,),
            ),
          ],
        ),
      ),
    );
  }

  Widget Widget_OpenInfo(){
    return Widget_Champions(widget.tft_matchDto);
  }


  //#. 빌드
  @override
  Widget build(BuildContext context) {

    //#. 위젯
    if(widget.isOpened  == false)
      return Widget_Closed();
    else
      return Widget_Opened();
  }
}





