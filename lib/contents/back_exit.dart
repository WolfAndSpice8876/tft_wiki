
import 'package:flutter/services.dart';
import 'package:lol/widgets/info_toast.dart';
import 'package:oktoast/oktoast.dart';

class BackButtonExit
{
  static DateTime? pressedTime;

  static bool doubleTap(int second_){
    DateTime currentTime = DateTime.now();

    //Statement 1 Or statement2


    if(pressedTime == null){
      pressedTime = currentTime;
      InfoToast.show("한번 더 누르면 종료됩니다.");
      return false;
    }

    else if(currentTime.difference(pressedTime!) > Duration(seconds: second_)){
      pressedTime = currentTime;
      InfoToast.show("한번 더 누르면 종료됩니다.");
      return false;
    }
    else{
      SystemNavigator.pop();
      return true;
    }


    bool backButton = (
        pressedTime == null ||
        currentTime.difference(pressedTime!) > Duration(seconds: second_)
    );

    if (backButton) {
      pressedTime = currentTime;
      return false;
    }

    SystemNavigator.pop();
    return true;
  }
}