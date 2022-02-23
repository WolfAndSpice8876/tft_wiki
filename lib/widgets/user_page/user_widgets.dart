import 'package:flutter/material.dart';
import 'package:lol/riot/riot_api.dart';
import '../../contents/data.dart';
import '../../contents/style.dart' as Style;
import 'package:lol/normal/size.dart';

class UserWidgets
{
  Tft_RequestData requestData;

  UserWidgets(this.requestData);

  Widget Profile(int id_)
  {
    return Container(
      width: size(96),
      height: size(96),
      margin: EdgeInsets.only(right: size(10)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size(10)),
        boxShadow: [
          Style.User.profileElementShadow,
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Image.network(
          RiotApiUrl.profileImage(id_),
        ),
      ),
    );
  }

  Widget UserLevel()
  {
    return Container(
      height: size(26),
      alignment: Alignment.center,
      child: Text(
        "LV. " + requestData.userData.value!.userLevel.toString(),
        style: TextStyle(
            fontSize: size(14),
            color: Color(0xff9e9e9e),
            fontWeight: FontWeight.w700,
            fontFamily: "roboto",
        ),
      ),
    );
  }

  Widget UserName()
  {
    return Container(
      height: size(44),
      alignment: Alignment.center,
      child: Text(
        requestData.userData.value!.name,
        style: TextStyle(
          fontSize: size(24) ,
          color: Color(0xff0e0e0e),
          fontWeight: FontWeight.w700 ,
        ),
      ),
    );
  }

  Widget RankPoint(int point_)
  {
    return Container(
      width: 100,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            Style.commonBoxShadow,
          ],
          border: Border.all(color: Colors.black87)
      ),
      child: Center(
        child: Text(
          point_.toString() + " LP",
        ),
      ),
    );
  }

  Widget RankImage(String tier_, BuildContext context_)
  {

    String path = "images/rank/NULL.png";
    switch(tier_)
    {
      case "BRONZE" :
      case "CHALLENGER" :
      case "DIAMOND" :
      case "GOLD" :
      case "GRANDMASTER" :
      case "IRON" :
      case "MASTER" :
      case "PLATINUM" :
      case "SILVER" :
        path = "images/rank/${tier_}.png";
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            Style.commonBoxShadow,
          ],
          border: Border.all(color: Colors.black87)
      ),
      child: Image.asset(
        path,
      )
    );
  }
}







