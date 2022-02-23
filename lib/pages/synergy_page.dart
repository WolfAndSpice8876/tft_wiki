import 'package:flutter/material.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/contents/style.dart' as Style;
import 'package:lol/normal/wrapping.dart';
import 'package:lol/database/data_library.dart';
import 'package:lol/widgets/back_button.dart';
import 'package:lol/widgets/champions_page/champion_element.dart';
import 'package:lol/widgets/page_name.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:lol/normal/screen_percentage.dart' as ScreenPer;
import 'package:lol/dto/champion_dto.dart';


class SynergyPage extends StatefulWidget {
  const SynergyPage({Key? key}) : super(key: key);

  @override
  _SynergyPageState createState() => _SynergyPageState();
}

class _SynergyPageState extends State<SynergyPage> {

  List<String> origins = [ //final
    '전체',
    '범죄조직',
    '집행자',
    '사교계',
    '돌연변이',
  ];

  List<String> classes = [
    '전체',
    '난동꾼',
    '혁신가',
    '도전자',
    '경호대',
    '암살자',
  ];

  List<ChampionDto> championList = <ChampionDto>[];

  Wrapping<String> originValue = Wrapping<String>.blank();
  Wrapping<String> classValue = Wrapping<String>.blank();

  
  //#. 위젯 함수
  DropdownMenuItem<String> Widget_Element(String item_){
    return DropdownMenuItem<String>(
      value: item_,
      child: Row(
        children: [
          Icon(
            Icons.settings,
            size: size(24),
          ),
          Style.wBox(7),
          Text(
            item_,
            style: TextStyle(
              fontSize: size(12),
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget Widget_Button(Wrapping<String> value_){

    Widget _description(){
      if(value_.value == null){
        return Text(
          "직업을 선택하세요",
          style: TextStyle(
              fontSize: size(14),
              color: Palette.lightColor,
              fontWeight: FontWeight.w500
          ),
        );
      }
      else{
        return Text(
          value_.value!,
          style: TextStyle(
              fontSize: size(14),
              color: Colors.black,
              fontWeight: FontWeight.w700
          ),
        );
      }
    }

    return Container(
      width: size(153),
      height: size(42),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size(15))
      ),
      child: SizedBox(
        width: size(137),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _description(),
            Icon(
              Icons.expand_more,
              size: size(22),
              color: Palette.middleColor,
            )
          ],
        ),
      ),
    );
  }

  Widget Widget_DropDown(List<String> items_ , Wrapping<String> selectedValue_){
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                '직업을 선택하세요',
                style: TextStyle(
                  fontSize: size(14),
                  fontWeight: FontWeight.w500,
                  color: Palette.lightColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items_
            .map((item) => Widget_Element(item)).toList(),
        value: selectedValue_.value,
        onChanged: (value) {
          setState(() {
            selectedValue_.value = value as String;
            championList = getChampionList(originValue.value, classValue.value);
            championList.forEach((element) {
            });
          });
        },
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.black,
        ),
        iconSize: 14,
        iconEnabledColor: Colors.yellow,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: size(153),
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        itemHeight: size(36),
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownWidth: size(153),
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size(20)),
            color: Colors.white,
            boxShadow: [Style.tftShadow]
        ),
        dropdownElevation: 1,
        offset: Offset(0, -10),
        customButton: Widget_Button(selectedValue_),
        dropdownMaxHeight: size(800),
      ),
    );
  }

  Widget Widget_ListView(){
    List<Widget> elementList = <Widget>[];
    championList.forEach((element) {
      elementList.add(ChampionElement(championDto: element));
    });

    return Expanded(
      child: ListView(
        children: elementList,
      ),
    );
  }



  //#. 함수
  List<ChampionDto> getChampionList(String? origin_ , String? class_){
    List<ChampionDto> result = <ChampionDto>[];

    if(origin_ == null && class_ == null){
      return result;
    }

    if(origin_ == "전체" && class_ == "전체"){
      DataLibrary.champion.allByKoreanName.forEach((key, value) {
        result.add(value);
      });
      return result;
    }

    if(origin_ == null && class_ == "전체"){
      return result;
    }

    if(origin_ == "전체" && class_ == null){
      return result;
    }

    if(origin_ == null || origin_ == "전체"){
      DataLibrary.trait.findByName(class_!).members.forEach((element){
        result.add(DataLibrary.champion.findByName(element));
      });
      return result;
    }

    if(class_ == null || class_ == "전체"){
      DataLibrary.trait.findByName(origin_).members.forEach((element) {
        result.add(DataLibrary.champion.findByName(element));
      });
      return result;
    }

    List<String> originMembers = DataLibrary.trait.findByName(origin_).members;
    List<String> classMembers =  DataLibrary.trait.findByName(class_).members;

    originMembers.forEach((element0) {
      classMembers.forEach((element1) {
        if(element0 == element1){
          result.add(DataLibrary.champion.findByName(element1));
        }
      });
    });

    return result;
  }



  //#. 빌드
  @override
  Widget build(BuildContext context) {

     ScreenPer.ScreenSize screenSize = ScreenPer.ScreenSize(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size(10)),
              child: Row(
                children: [
                  CustomBackButton(),
                  Style.wBox(size(7)),
                  PageName("시너지검색")
                ],
              ),
            ),
            Style.hBox(screenSize.height.sizeByPercent(56/800)),
            Container(
              width: size(332),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size(20))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Widget_DropDown(origins,originValue),
                  Widget_DropDown(classes,classValue),
                ],
              ),
            ),
            Style.hBox(screenSize.height.sizeByPercent(20/800)),
            //Widget_ListView(),
          ],
        ),
      ),
    );
  }
}
