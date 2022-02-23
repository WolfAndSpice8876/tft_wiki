import 'package:flutter/material.dart';
import 'package:lol/contents/data.dart';
import 'package:lol/normal/debug.dart';
import 'package:lol/dto/dto_class.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/riot/riot_api.dart';
import 'package:lol/widgets/user_page/user_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/pages/main_page.dart';
import 'package:lol/special_contents/bookmark.dart';
import 'package:lol/widgets/back_button.dart';
import 'package:lol/widgets/user_page/match_view.dart';


class UserPage extends StatefulWidget {
  Tft_RequestData tft_requestData;
  bool isMarked;
  UserPage({Key? key , required this.tft_requestData , required this.isMarked}) : super(key: key);

    @override
  _UserPageState createState() => _UserPageState(tft_requestData);

}

class _UserPageState extends State<UserPage> {

  //#. 변수 선언
  int extraMatchNum = 10;
  late UserWidgets userWidgets;
  late Tft_RequestData requestData;
  late Tft_UserDto userDto;


  //#. 생성자
  _UserPageState(Tft_RequestData requestData_){
    requestData = requestData_;
    userWidgets = UserWidgets(requestData_);
    userDto = requestData_.userData.value!;
  }



  //#. 위젯 함수
  Widget Widget_UserInfo(){
    return Container(
      margin: EdgeInsets.all(size(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              Widget_UserProfile(userDto.profileIconId),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userWidgets.UserLevel(),
              userWidgets.UserName(),
            ],
          ),
        ],
      ),
    );
  }

  Widget Widget_Bookmark(){

    Future<void> _setMark()async{
      widget.isMarked = true;
      await BookMark.set(userDto.name);
    }

    Future<void> _delete()async{
      widget.isMarked = false;
      await BookMark.reset();
    }


    //#. 빌드
    String bookmarkIcon;

    if(widget.isMarked == false)
      bookmarkIcon = "assets/user_page/bookmark_off.svg";
    else
      bookmarkIcon = "assets/user_page/bookmark_on.svg";


    return IconButton(
      onPressed: () async{
        if(widget.isMarked == false)
          await _setMark();
        else{
          showDialog(
            context: context,
            builder: (BuildContext context){
              return Widget_BookmarkCheckAlert(_delete);
            },
          );
        }
        Debug.log("Widget_Bookmark : ${widget.isMarked}");
        BookMark.get().then((value) => Debug.log(value));
        setState(() {});
      },

      iconSize: size(31),
      icon: SvgPicture.asset(
        bookmarkIcon,
        width: size(31),
        height: size(31),
      ),
      padding: EdgeInsets.zero,
    );
  }

  Widget Widget_BookmarkCheckAlert(Function delete_){
    return AlertDialog(
      content: SizedBox(
        height: 30,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "계정을 삭제하시겠습니까?",
            style: TextStyle(
              fontSize: 16
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: ()async{
            await delete_.call();
            setState(() {});
            Navigator.pop(context);
          },
          child: Text("예")
        ),
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text("아니요")
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget Widget_UserProfile(int id_){
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: size(96),
          height: size(96),
          margin: EdgeInsets.fromLTRB(0, size(0.8), size(10), 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size(10)),
            boxShadow: [
              Style.User.profileElementShadow,
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  RiotApiUrl.profileImage(id_),
                ),
              ),

            ],
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: size(10)),
              child: Widget_Bookmark(),
            )
        ),
      ],
    );
  }



  //#. 함수
  List<Widget> _makeWidgetList(){
    return <Widget>[
      Row(
        children: [
          CustomBackButton(),//뒤로가기
          Style.expanded,
          //Widget_Bookmark(),
          //Widget_BookmarkCheckAlert(),
        ],
      ),
      Widget_UserInfo(),//유저 정보
      Style.hBox(size(11)),
      MatchView(tft_requestData: requestData,extraMatchNum: extraMatchNum,),
    ];
  }



  //#. 빌드
  @override
  Widget build(BuildContext context) {

    //#. 변수 선언
    StatusData<Tft_UserDto> userDto = widget.tft_requestData.userData;
    StatusData<Tft_LeagueEntryDto> leagueDto = widget.tft_requestData.leagueEntryDto;

    List<Widget> widgetList = _makeWidgetList();

    //#. 반환
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.userPageBack,
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widgetList.length,
                  itemBuilder: (context,index){
                    return widgetList[index];
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
