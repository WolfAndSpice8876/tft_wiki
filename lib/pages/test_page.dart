import 'package:flutter/material.dart';
import 'package:lol/normal/screen_percentage.dart';
import 'package:lol/normal/search.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/normal/wrapping.dart';
import 'package:lol/database/champion_data.dart';
import 'package:lol/database/data_library.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lol/widgets/back_button.dart';
import 'package:lol/widgets/champions_page/champion_element.dart';
import 'package:lol/widgets/page_name.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  List<List<Widget>> elementLists = <List<Widget>>[];
  String searchText = "";
  bool isSearchBarOn = false;

  _ChampionPageState(){

    DataLibrary.champion.byCost.forEach((element) {
      List<Widget> temp = <Widget>[];
      element.forEach((element) {
        temp.add(ChampionElement(championDto: element));
      });

      elementLists.add(temp);
    });

    print("gd");
  }



  int currentPage = 0;



  //#. 위젯 함수
  Widget Widget_ButtonTable(){
    ScreenSize screenSize = ScreenSize(context);

    Widget _button(String str_, Color color_, int setPage_){

      if(setPage_ != currentPage)
        color_ = Colors.grey;

      return Expanded(
        child: GestureDetector(
          onTap: (){
            if(checkSearchFocus() == false){
              currentPage = setPage_;
              setState(() {});
            }
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0))
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                str_,
                style: TextStyle(
                  fontSize: size(14),
                  fontWeight: FontWeight.w700,
                  color: color_,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(screenSize.width.sizeByPercent(21/360), size(28), screenSize.width.sizeByPercent(21/360), 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _button("1골드" , Palette.middleColor,0),
          _button("2골드" , Color(0xff13B188),1),
          _button("3골드" , Color(0xff237AC3),2),
          _button("4골드" , Color(0xffBD44D1),3),
          _button("5골드" , Color(0xffFF8311),4),
        ],
      ),
    );
  }

  Widget Widget_ChampionsView(){

    if(currentPage == 5)
      return Expanded(
        child: ListView(
          children: getSearchResult(searchText),
        ),
      );

    return Expanded(
      child: ListView(
          children: elementLists[currentPage]
      ),
    );
  }

  Widget Widget_SearchBar(){

    double _width = 0;
    double _iconSize = 24;

    Widget _SearchBar(){
      return SizedBox(
          width: size(200),
          child: Padding(
            padding: EdgeInsets.only(left: size(10)),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    "assets/search.svg",
                    width: size(_iconSize),
                    height: size(_iconSize),
                  ),
                  onPressed: (){
                    isSearchBarOn = false;
                    setState(() {});
                  },
                  iconSize: size(_iconSize),
                ),
                hintText: "캐릭터를 검색하세요",
                hintStyle: TextStyle(
                    fontSize: size(12),
                    textBaseline : TextBaseline.alphabetic
                ),
                //contentPadding: EdgeInsets.fromLTRB(0, 0, 0, size(5))

              ),
              onChanged: (value){
                searchText = value;
                if(value != "" || searchText != null){
                  currentPage = 5;
                  setState(() {});
                }
              },
              onEditingComplete: (){
                isSearchBarOn = false;
                if(searchText != ""  || searchText != null){
                  currentPage = 5;
                  setState(() {});
                  print("com");
                }
              },
              autofocus: true,
            ),
          )
      );
    }

    Widget _Button(){
      return Padding(
        padding: const EdgeInsets.only(top : 5.5 , bottom: 5.5),
        child: IconButton(
          onPressed: (){
            isSearchBarOn = true;
            setState(() {});
          },
          icon: SvgPicture.asset(
            "assets/search.svg",
            width: size(_iconSize),
            height: size(_iconSize),
          ),
          iconSize: size(_iconSize),
        ),
      );
    }

    Widget _getChild(){
      if(isSearchBarOn == false)
        return _Button();
      else
        return Align(
            alignment: Alignment.centerRight,
            child: _SearchBar()
        );
    }

    if(isSearchBarOn == true)
      _width = size(200);
    else
      _width = size(0);

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: _width,
            height: size(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: _getChild()
        ),
      ],
    );

  }



  //#. 함수
  List<Widget> getSearchResult(String searchText_){
    List<Widget> result = <Widget>[];
    Search.findWithMap(DataLibrary.champion.allByKoreanName, searchText_).forEach((element) {
      result.add(ChampionElement(championDto: element,));
    });
    return result;
  }

  bool checkSearchFocus(){
    if(isSearchBarOn == true){
      isSearchBarOn = false;
      FocusScope.of(context).unfocus();
      setState(() {});
      return true;
    }
    else
      return false;
  }



  //#. 빌드
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Palette.backColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: (){
            checkSearchFocus();
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Style.hBox(size(10)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomBackButton(), // 뒤로가기
                      Style.wBox(size(7)),
                      PageName("챔피언 검색"),
                      Style.expanded,
                      //Widget_SearchBar()
                    ],
                  ),
                  Widget_ButtonTable(),
                  Style.hBox(size(43)),
                  Widget_ChampionsView(),
                ],
              ),
              Widget_SearchBar(),
            ],
          ),
        ),
      ),
    );
  }
}
