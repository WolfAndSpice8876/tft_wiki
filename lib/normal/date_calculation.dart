
class DataCalculation
{
  static String getTimeDifference(int stamp1, int stamp2){
    var date1 = DateTime.fromMillisecondsSinceEpoch(stamp1);
    var date2 = DateTime.fromMillisecondsSinceEpoch(stamp1);
    int difference = int.parse(
        date1.difference(date2).inMinutes.toString());
    print(difference);
    return difference.toString();
  }

  static String getTimeDifferenceNow(int stamp){
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(stamp);
    int difference = int.parse(
        now.difference(date).inMinutes.toString());
    String result = "null";


    if(difference < 0){
      result = "null";
    }
    else if(difference < 60){
      result = "${difference} 분 전";
    }
    else if(difference < 1440){
      result = "${(difference/60).floor()} 시간 전";
    }
    else if(difference < 10080){
      result = "${(difference/60/24).floor()} 일 전";
    }
    else if(difference < 40320){
      result = "${(difference/60/24/7).floor()} 주 전";
    }
    else if(difference < 483840){
      result = "${(difference/60/24/7/4).floor()} 달 전";
    }
    else
      result = "오래 전";

    return result;
  }
}