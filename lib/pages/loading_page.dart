import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lol/contents/data.dart';
import 'package:lol/normal/debug.dart';
import 'package:lol/normal/page_move.dart';
import 'package:lol/normal/size.dart';
import 'package:lol/database/data_library.dart';
import 'package:lol/special_contents/bookmark.dart';
import 'package:lol/special_contents/search_history.dart';

import 'main_page.dart';

class LoadingPage extends StatefulWidget {
  String userName = "";
  int maxMatchNum = 0;
  LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Debug.setDebugMode(true);
    Future.delayed(Duration(milliseconds: 1000), () {
      _opacity = 1;
      setState(() {});
    });
    checkData();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Color(0xff00A9B4),
          systemNavigationBarIconBrightness : Brightness.light,
          statusBarIconBrightness : Brightness.dark
      ),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffFFFFFF),
                          Color(0xffFFA800),
                          Color(0xff00A9B4),
                        ]
                    )
                ),
              ),
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(milliseconds: 500),
                child: Image.asset(
                  "assets/beginning/main_logo.png",
                  width: size(233),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkData()async{
    await checkBookMarkData();
    await checkSearchData();
    await checkChampionData();
    Future.delayed(Duration(milliseconds: 1500), () {
      PageMove.popMove(context, MainPage());
    });
  }

  Future<void> checkBookMarkData()async{
    await BookMark.dataCheck();
    return;
  }

  Future<void> checkSearchData()async{
    await SearchHistory.dataCheck();
    return;
  }

  Future<void> checkChampionData()async{
    await DataLibrary.make();
    return;
  }

}
