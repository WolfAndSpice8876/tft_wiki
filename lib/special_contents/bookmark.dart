import 'package:lol/normal/debug.dart';
import 'package:lol/normal/file_io.dart';



class BookMark{
  //#. 데이터 널 표시 = /null/

  static String _path = "/bookmark.txt";

  static Future<bool> isFileExist()async{
    bool result = await FileIO.isFileExist(_path);
    return result;
  }

  static Future<void> makeFile()async{
    FileIO.writeText(_path, "/null/");
  }

  static Future<void> dataCheck()async{
    isFileExist().then((value){
      if(value == false){
        Debug.log("BookMark : dataCheck : 파일이 없습니다. 새로 생성합니다.");
        makeFile();
      }
      else{
        Debug.log("BookMark : dataCheck : 파일이 존재합니다.");
      }

    });
  }

  static Future<String> get() async{
    try{
      String result = await FileIO.readText(_path);
      return result;
    }
    catch(e){
     Debug.logError("BookMark : read : ${e}");
     return "null";
    }
  }

  static Future<void> set(String str_)async{

    try{
      FileIO.writeText(_path, str_);
    }catch(e){
      Debug.logError("BookMark : write : ${e}");
    }

  }

  static Future<void> reset()async{

    try{
      FileIO.writeText(_path, "/null/");
    }catch(e){
      Debug.logError("BookMark : write : ${e}");
    }

  }

  static Future<bool> markCompare(String name_) async{
    String data = await get();
    if(data == name_)
      return true;
    else
      return false;
  }

}