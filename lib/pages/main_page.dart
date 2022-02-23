import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lol/contents/back_exit.dart';
import 'package:lol/contents/data.dart';
import 'package:lol/normal/debug.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/screen_percentage.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/pages/champion_page.dart';
import 'package:lol/pages/item_page.dart';
import 'package:lol/pages/synergy_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/pages/test_page.dart';
import 'package:lol/pages/user_page.dart';
import 'package:lol/riot/riot_error_code.dart';
import 'package:lol/special_contents/bookmark.dart';
import 'package:lol/special_contents/search_limit.dart';
import 'package:lol/widgets/info_toast.dart';
import 'package:lol/widgets/main_page/my_summoner.dart';
import 'dart:collection';
import 'package:lol/special_contents/search_history.dart';
import 'package:oktoast/oktoast.dart';



class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final int matchNums = 5;
  final TextEditingController _searchTextController = new TextEditingController();

  int maxMatchNum = 30;
  Tft_RequestData tftData = Tft_RequestData(0);
  List<Widget> matchResult = <Widget>[];
  String searchStr = "";
  List<String> searchHistory = [];
  ColorFilter colorFilter = ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstATop);
  bool isLoading = false;

  //bool isLoading = false;


  //#. 위젯 함수

    //#. 검색 박스
  Widget Widget_SearchBox(){
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(size(20))),
        borderSide: BorderSide( color: Palette.Main.boxColor )
    );

    return Padding(
      padding: EdgeInsets.only(left: size(20),right: size(20)),
      child: TextFormField(
        controller: _searchTextController,
        decoration: InputDecoration(
            hintText: "검색할 소환사 이름을 입력해주세요",
            hintStyle: TextStyle(
              fontSize: size(12),
              color: const Color(0xffB6B6B6),
              fontWeight: FontWeight.w500,
              height: 1,
              textBaseline: TextBaseline.alphabetic,
            ),
            enabledBorder: border,
            border: border,
            focusedBorder: border,
            filled: true,
            fillColor: Palette.Main.boxColor,
            suffixIcon: IconButton(
              onPressed: (){
                _goSearch(searchStr, matchNums, context);
              },
              icon: SvgPicture.asset(
                "assets/main_page/search.svg",
                height: size(24),
                width: size(24),
                color: Color(0xff6F6F6F).withOpacity(0.6),
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(size(10),size(25),size(25),0)
        ),
        onChanged : (value){
          searchStr = value;
        },
      ),
    );
  }

    //#. Search History
  Widget Widget_SearchHistory(){
    List<Widget> historyWidgets = <Widget>[];

    return Center(
      child: SizedBox(
        height: size(19),
        child: FutureBuilder(
            future: SearchHistory.get().then((value){
              historyWidgets = <Widget>[];
              searchHistory = value.toList();
              print(searchHistory);
              for(int i = 0; i<value.length; i++){
                historyWidgets.add(Widget_SearchText(value.elementAt(value.length - i - 1),value.length - i - 1));
              }
              for(int i = value.length; i<3; i++){
                historyWidgets.add(Widget_DummyBox());
              }
            }),
            builder: (context_ , snapshot_){
              if(snapshot_.connectionState == ConnectionState.waiting){
                return SizedBox();
              }
              else if(snapshot_.error != null){
                return Text("Error");
              }
              else{
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: historyWidgets,
                );
              }
            }
        ),
      ),
    );
  }

  Widget Widget_SearchText(String str_ , int index_){
    return Container(
      //decoration: Style.testBorder(),
      child: Padding(
        padding: EdgeInsets.only(right: size(0),left: size(0)),
        child: SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  _goSearch(str_, matchNums, context);
                },
                child: Container(
                  decoration: Style.blankDecoration,
                  width: size(65),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          str_,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: size(14),
                            color: Palette.middleColor,
                            fontWeight: FontWeight.w700,
                              height: 1
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Style.wBox(size(5)),
              Widget_HistoryDeleteButton(index_),
            ],
          ),
        ),
      ),
    );
  }

  Widget Widget_DummyBox(){
    return Padding(
      padding: EdgeInsets.only(right: size(7),left: size(10)),
      child: Style.wBox(size(50)),
    );
  }

  Widget Widget_HistoryDeleteButton(int index_){
    return GestureDetector(
      onTap: (){
        searchHistory.removeAt(index_);
        SearchHistory.replace(Queue.from(searchHistory));
        print(searchHistory);
        setState(() {
        });
      },
      child: SvgPicture.asset(
        "assets/main_page/delete.svg",
        width: size(15),
        height: size(15),
        color: Palette.lightColor,
      ),
    );
  }

   //#. 기타


  Widget Widget_MoveButton(
      String imagePath_,
      String dis_,
      BuildContext context_,
      Widget page_,
      )
  {
    return GestureDetector(
      onTap: (){
        PageMove.move(context_, page_);
        _resetPage();
      },
      child: Container(
        height: size(75),
        width: size(80),
        decoration: Style.Main.commonBox,
        child: Column(
          children: [
            Style.hBox(size(5)),
            Image.asset(
              imagePath_,
              height: size(50),
              width: size(50),
            ),
            Text(
              dis_,
              style: TextStyle(
                  fontSize: size(11),
                  fontWeight: FontWeight.w300,
                  color: Palette.lightColor
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Widget_MainDropDown(){

    PopupMenuItem menuItem(String name_, String iconPath_ , int value_){
      return PopupMenuItem(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: size(9)),
              child: SvgPicture.asset(
                iconPath_,
                height: size(24),
                width: size(24),
              ),
            ),
            Text(
              name_,
              style: TextStyle(fontSize: size(14), fontWeight: FontWeight.w900),
            ),
          ],
        ),
        value: value_,
      );
    }

    return PopupMenuButton(
        icon: SvgPicture.asset(
          "assets/main_page/clipboard_list.svg",
          height: size(24),
          width: size(24),
        ),
        onPressed: (){
          colorFilter = ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop);
          setState(() {

          });
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size(15))
        ),
        onSelected: (index){
          setState(() {
            colorFilter = ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstATop);
          });
          PageMove.move(context, TestPage());
        },
        onCanceled: (){
          setState(() {
            colorFilter = ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstATop);
          });
        },
        itemBuilder: (context) => [
          menuItem(
              "전적 검색",
              "assets/main_page/dropdown/user_search.svg",
              0
          ),
          menuItem(
              "시너지",
              "assets/main_page/dropdown/synergy_search.svg",
              1
          ),
          menuItem(
              "아이템 검색",
              "assets/main_page/dropdown/item_search.svg",
              2
          ),
          menuItem(
              "캐릭터 검색",
              "assets/main_page/dropdown/champion_search.svg",
              3
          ),
        ]
    );
  }

  Widget Widget_UserDropDown(){
    PopupMenuItem menuItem(String name_, String iconPath_ , int value_){
      return PopupMenuItem(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: size(9)),
              child: SvgPicture.asset(
                iconPath_,
                height: size(24),
                width: size(24),
              ),
            ),
            Text(
              name_,
              style: TextStyle(fontSize: size(14), fontWeight: FontWeight.w900),
            ),
          ],
        ),
        value: value_,
      );
    }

    return PopupMenuButton(
        icon: SvgPicture.asset(
          "assets/main_page/hamburger.svg",
          height: size(16),
          width: size(16),
        ),
        onPressed: (){
          colorFilter = ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop);
          setState(() {

          });
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size(15))
        ),
        onSelected: (index){
          setState(() {
            colorFilter = ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstATop);
          });
        },
        onCanceled: (){
          setState(() {
            colorFilter = ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstATop);
          });
        },
        itemBuilder: (context) => [
          menuItem(
              "전적 검색",
              "assets/main_page/dropdown/user_search.svg",
              0
          ),
          menuItem(
              "시너지",
              "assets/main_page/dropdown/synergy_search.svg",
              1
          ),
          menuItem(
              "아이템 검색",
              "assets/main_page/dropdown/item_search.svg",
              2
          ),
          menuItem(
              "캐릭터 검색",
              "assets/main_page/dropdown/champion_search.svg",
              3
          ),
        ]
    );
  } // 유저 드롭다운 메뉴 : 작성 필요

  Widget Widget_LoadingIndicator(){
    if(isLoading == true)
      return CircularProgressIndicator(
          color: Color(0xffEB7100),
          backgroundColor: Color(0xffEB7100).withOpacity(0.3),
        );
    else
      return Style.hBox(0);

  }

  Widget Widget_SearchResult(){
    return Container(

    );
  }




  //#. 함수
  void _goSearch(String userName_ , int num_ , BuildContext context_) async{
    setState(() {});

    if(isLoading == true)
      return;

    isLoading = true;

    int limitResult = await SearchLimit.trySearch();

    if(limitResult != 0){
      showSearchResult("1분 동안 최대 5번 검색 할 수 있습니다. (${(limitResult/1000).round()} 초)");
      isLoading = false;
      return;
    }



    await SearchHistory.add(userName_);
    Tft_RequestData tft_requestData = await GetData(userName_ , num_);
    bool isMarked = await BookMark.markCompare(userName_);
    Debug.log("_goSearch : ${tft_requestData.statusCode}");
    isLoading = false;
    if(tft_requestData.statusCode == 200){
      PageMove.move(context_, UserPage(tft_requestData: tft_requestData, isMarked: isMarked));
      _resetPage();
    }
    else{
      showSearchResult(RiotError.getErrorText(tft_requestData.statusCode));
      if(tft_requestData.statusCode == 600)
        await SearchLimit.setMinus();
    }
    setState(() {});
  }



  void goSearchOtherInOther(String userName_) async{
    _goSearch(userName_ ,matchNums , context );
  }

  void _resetPage(){
    print("reset");
    FocusScope.of(context).unfocus();
    _searchTextController.text = "";
    setState(() {});
  }

  Future<Tft_RequestData> GetData(String userName_, int num_)async{
    Tft_RequestData tftData = Tft_RequestData(num_);
    await tftData.getData(userName_, num_);
    return tftData;
  }

  double getHeight(double value_){
    double maxHeight = MediaQuery.of(context).size.width;
    double stdHeight = 800;
    return (value_ / stdHeight ) * maxHeight;
  }

  void showSearchResult(String msg_){
    InfoToast.show(msg_);
    return;
  }


  //#. 빌드
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SearchHistory.get().then((value) => searchHistory = value.toList());
  }

  @override
  Widget build(BuildContext context) {

    final ScreenSize screenSize = ScreenSize(context);

    Debug.setDebugMode(true);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Palette.backColor,
        systemNavigationBarColor: Palette.backColor,
        systemNavigationBarIconBrightness : Brightness.dark,
        statusBarIconBrightness : Brightness.dark
      ),
      child: WillPopScope(
        onWillPop: ()async{
          return BackButtonExit.doubleTap(2);
        },
        child: SafeArea(
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset : false,
              backgroundColor: Palette.Main.backColor,
              body: Stack(
                children: [
                  Column(
                    children: [
                      Style.hBox(size(106)),
                      Widget_SearchBox(),
                      Style.hBox(size(18)),
                      Padding(
                        padding: EdgeInsets.only(left: size(40) , right: size(40)),
                        child: Widget_SearchHistory(),
                      ),
                      Style.hBox(size(56)),
                      MainUser(search : goSearchOtherInOther),
                      Style.hBox(size(56)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Widget_MoveButton(
                            "assets/main_page/champion.png",
                            "챔피언",
                            context,
                            ChampionPage()
                          ),
                          Style.wBox(size(25)),
                          Widget_MoveButton(
                            "assets/main_page/item.png",
                            "아이템",
                            context,
                            ItemPage(),
                          ),
                          Style.wBox(size(25)),
                          Widget_MoveButton(
                            "assets/main_page/synergy.png",
                            "시너지",
                            context,
                            SynergyPage()
                          ),
                        ],
                      ), //메뉴
                      Style.expanded,
                      Padding(
                        padding: EdgeInsets.only(bottom: screenSize.height.sizeByPercent(98/800)),
                        child: Widget_LoadingIndicator(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




