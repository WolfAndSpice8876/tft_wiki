
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lol/contents/data.dart';
import 'package:lol/dto/dto_class.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/riot/riot_error_code.dart';
import 'package:lol/widgets/info_toast.dart';
import 'package:lol/widgets/user_page/match_element.dart';

class MatchView extends StatefulWidget {
  Tft_RequestData tft_requestData;
  int extraMatchNum;
  MatchView({Key? key, required this.tft_requestData , required this.extraMatchNum}) : super(key: key);

  @override
  _MatchViewState createState() => _MatchViewState(requestData: tft_requestData , matchDatas: tft_requestData.matchesData);
}

class _MatchViewState extends State<MatchView> {

  //#. 선언
  Tft_RequestData requestData;
  Tft_MatchesData matchDatas;
  int currentPage = 0;
  bool additionalLoad = false;
  bool isLoading = false;
  late List<List<Widget>> matchElementsLists;

  //#. 생성자
  _MatchViewState({required this.requestData, required this.matchDatas}){
    _makeMatchLists();
  }



  //#. 함수
  Future<void> _getExtraMatchDatas() async{
    matchDatas = await Tft_DataGetter.getExtraMatchDatas(requestData.userData.value!.puuid, widget.extraMatchNum);
    for(final element in matchDatas.allMatches){
      if(element.status != 200){
        InfoToast.show(RiotError.getErrorText(element.status!));
        break;
      }
    }
    _makeMatchLists();
    additionalLoad = true;
  }

  List<StatusData<Tft_MatchDto>> _getShowMatches(int currentPage_){
    switch(currentPage_){
      case 0:
        return matchDatas.allMatches;

      case 1:
        return matchDatas.rankMatchDatas;

      case 2:
        return matchDatas.turboMatchDatas;

      case 3:
        return matchDatas.doubleMatchDatas;

      case 4:
        return matchDatas.normalMatchDatas;

      default:
        return matchDatas.allMatches;
    }
  }

  void _makeMatchLists(){
    matchElementsLists = <List<Widget>>[];
    for(int i = 0; i<matchDatas.allMatches.length; i++){
      List<Widget> widgets_ = <Widget>[];
      _getShowMatches(i).forEach((element) {
        widgets_.add(MatchElement(tft_matchDto: element.value!));
      });
      matchElementsLists.add(widgets_);
    }
  }



  //#. 위젯 함수
  Widget Widget_PageButtonTable(){

    Widget Widget_PageButton(String str_ ,int thisPage_){
      return GestureDetector(
        onTap: (){
          currentPage = thisPage_;
          setState(() {});
        },
        child: Container(
          padding: EdgeInsets.only(left: size(12) , right: size(12)),
          margin: EdgeInsets.only(top: size(5),bottom: size(5)),
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(color: Palette.userPageBack)),
          child: Text(
            str_,
            style: TextStyle(
              fontSize: size(11),
              fontWeight: FontWeight.w700,
              color: currentPage == thisPage_ ? Palette.User.pageButtonHighlight : Palette.lightColor,
            ),
          ),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.only(right: size(30), left: size(30)),
        child: SizedBox(
          height: size(49),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Widget_PageButton("전체" , 0),
              Widget_PageButton("랭크" , 1),
              Widget_PageButton("초고속모드" , 2),
              Widget_PageButton("더블업" , 3),
              Widget_PageButton("일반" , 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget Widget_MatchLoadInfo(){

    if(isLoading == true)
      return Padding(
        padding: EdgeInsets.only(bottom: size(10)),
        child: CircularProgressIndicator(
          color: Color(0xffEB7100),
        ),
      );

    if(matchDatas.allMatches.length == 0){
      return Text(
        "[정보가 없습니다.]",
        style: TextStyle(
            fontSize: size(12),
            fontWeight: FontWeight.w300,
            color: Color(0xff8E8E8E)
        ),
      );
    }

    if(additionalLoad == false){
      return TextButton(
        onPressed: () async{
          isLoading = true;
          setState(() {});
          await _getExtraMatchDatas().then((value){
            isLoading = false;
            setState(() {});
          });
        },
        child: Text(
          "[더보기]",
          style: TextStyle(
              fontSize: size(12),
              fontWeight: FontWeight.w300,
              color: Color(0xff8E8E8E)
          ),
        ),
      );
    }
    else{
      return TextButton(
        onPressed: (){},
        child: Text(
          "[정보가 없습니다.]",
          style: TextStyle(
            fontSize: size(12),
            fontWeight: FontWeight.w300,
            color: Color(0xff8E8E8E)
          ),
        ),
      );
    }
  }


  Widget Widget_MatchView(){
    if(matchDatas.allMatches.length > 0)
      return Column(children: matchElementsLists[currentPage],);
    else
      return Style.hBox(0);
  }


  //#. 빌드
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Widget_PageButtonTable(),
        Widget_MatchView(),
        Widget_MatchLoadInfo(),
      ],
    );
  }
}



