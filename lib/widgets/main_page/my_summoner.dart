import 'package:flutter/material.dart';
import 'package:lol/contents/data.dart';
import 'package:lol/dto/dto_class.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/normal/size.dart';
import 'package:lol/special_contents/bookmark.dart';
import 'package:lol/contents/style.dart' as Style;
import 'package:flutter_svg/flutter_svg.dart';

class MainUser extends StatefulWidget {
  Function search;
  MainUser({Key? key , required this.search}) : super(key: key);

  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {

  bool isLoaded = false;
  bool isExist = false;
  StatusData<Tft_UserDto> userDto = StatusData(status: 0 , value: Tft_UserDto.blank());
  String backImage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }


  Future<void> getUser()async{
    String userName = await BookMark.get();
    isLoaded = true;

    if(userName == "/null/"){
      isExist = false;
      setState(() {});
      return;
    }

    isExist = true;
    userDto = await Tft_DataGetter.getUserDtoByName(userName);
    setState(() {});
    return;
  }

  Widget Widget_Description(){

    Widget _Widget_Content(String text_){
      return Align(
        alignment: Alignment.center,
        child: Text(
            text_,
            style: TextStyle(
                color: Palette.lightColor,
                fontSize: size(12),
                fontWeight: FontWeight.w300
            )
        )
      );
    }

    if(isLoaded == false)
      return _Widget_Content("로딩중");

    if(isExist == false)
      return _Widget_Content("소환사 계정 즐겨찾기");

    if(userDto.status != 200)
      return _Widget_Content("Riot Api 연결이 불안정 합니다.");
    else{
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userDto.value!.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size(18),
                  fontWeight: FontWeight.w700
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size(5)),
              child: Text(
                 "LV. ${userDto.value!.userLevel}",
                style: TextStyle(
                  fontFamily: "roboto",
                    color: Colors.white,
                    fontSize: size(9),
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget Widget_Back(){
    if(isLoaded == true && isExist == true && userDto.status == 200){
      return ClipRRect(
        borderRadius: BorderRadius.circular(size(10)),
        child: Image.asset(
          "assets/image/champion_main/TFT6_Viktor.jpg",
          fit: BoxFit.fitWidth,
        ),
      );
    }
    else
      return Style.hBox(0);
  }

  Widget Widget_BookmarkCheckAlert(){
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
              await BookMark.reset();
              getUser();
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

  Widget Widget_DeleteIcon(){
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          onPressed: ()async{
            if(isLoaded == true && isExist){
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return Widget_BookmarkCheckAlert();
                },
              );
            }
          },
          icon: SvgPicture.asset("assets/main_page/user_delete.svg")
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Center(
      child: GestureDetector(
        onTap: (){
          if(isLoaded == true && isExist == true && userDto.status == 200)
            widget.search(userDto.value!.name);
        },
        child: Container(
          width: size(294),
          height: size(165),
          child: Stack(
            children: [
              Container(
                width: size(294),
                height: size(165),
                decoration: Style.Main.commonShadowBox,
                child: Widget_Back(),
              ),
              Align(
                alignment: Alignment.center,
                child: Widget_Description(),
              ),
              Widget_DeleteIcon(),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: (){
                    getUser();
                  },
                  icon: SvgPicture.asset("assets/refresh.svg" , color: Palette.iconColorOrange,),
                )
              )
            ],
          ),
        ),
      ),
    );

    return Center(
      child: Container(
        width: size(276),
        height: size(132),
        decoration: Style.Main.commonShadowBox,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size(10)),
                child: Image.asset(
                  "assets/main_user_champion/Viktor.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(onPressed: (){},icon: Icon(Icons.settings),),
            ),
            Align(
              alignment: Alignment.center,
              child: Widget_Description(),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: (){
                      getUser();
                    },
                    icon: Icon(Icons.settings)
                )
            )
          ],
        ),
      ),
    );
    return Center(
      child: Container(
        width: size(276),
        height: size(132),
        decoration: Style.Main.commonShadowBox,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size(10)),
                child: Image.asset(
                  "assets/main_user_champion/Viktor.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(onPressed: (){},icon: Icon(Icons.settings),),
            ),
            Align(
              alignment: Alignment.center,
              child: Widget_Description(),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: (){
                      getUser();
                    },
                    icon: Icon(Icons.settings)
                )
            )
          ],
        ),
      ),
    );

    return Stack(
      children : [
        ClipRRect(
          borderRadius: BorderRadius.circular(size(10)),
          child: Image.asset(
            "assets/main_user_champion/Viktor.png",
            fit: BoxFit.contain,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Widget_Description(),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: (){
              getUser();
            },
            icon: Icon(Icons.settings)
          )
        )
      ]
    );
  }
}
