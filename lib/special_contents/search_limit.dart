import 'package:lol/normal/file_io.dart';

const _path = "/search_limit.txt";

class SearchLimit
{
  //static DateTime? lastTime;

  static int num = 0;
  static Duration limitSecond = Duration(seconds: 60);
  static int limitNum = 3;

  static Future<int> get()async{

    String text = "";

    if(await FileIO.isFileExist(_path) == false){
      print("SearchLimit : 파일 없음");
      await FileIO.writeText(_path, "0,/null/");
      return 0;
    }

    print("SearchLimit : 파일 있음");


    text = await FileIO.readText(_path);
    num = int.parse(text.split(",")[0]);
    String timeResult = text.split(",")[1];
    DateTime lastTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timeResult));

    if(timeResult == "/null/" || num < limitNum)
      return 0;

    if(DateTime.now().difference(lastTime) > limitSecond){
      await reset();
      return 0;
    }

    return (limitSecond - DateTime.now().difference(lastTime)).inMilliseconds;

  }

  static Future<void> setPlus()async{
    if(num > limitNum)
      await FileIO.writeText(_path, "0,${DateTime.now().millisecondsSinceEpoch}");
    else
      await FileIO.writeText(_path, "${num + 1},${DateTime.now().millisecondsSinceEpoch}");
  }

  static Future<void> setMinus()async{
    if(num != 0)
      await FileIO.writeText(_path, "${num - 1},${DateTime.now().millisecondsSinceEpoch}");
    num = num - 1;
  }

  static Future<void> reset()async{
    await FileIO.writeText(_path, "0,${DateTime.now().millisecondsSinceEpoch}");
    num = 0;
  }

  static Future<int> trySearch()async{
    int result = 0;

    result = await get();

    if(result == 0){
      await setPlus();
      return result;
    }

    return result;
  }

}