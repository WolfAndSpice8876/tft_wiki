
import 'dart:collection';
import 'package:lol/normal/debug.dart';
import 'package:lol/normal/file_io.dart';

class SearchHistory
{

  //#. 데이터 널 표시 = ""

  static const String _path = '/search_history.txt';
  static const int _maxNum = 3;
  static const String _separator = ',';
  static const String nullOperator= "/null/";

  static Future<bool> isFileExist() async{
    bool result = await FileIO.isFileExist(_path);
    return result;
  }

  static Future<void> make()async{
    try{
      FileIO.writeText(_path, "/null/");
    }catch(e){
      Debug.logError("_resetSearchHistory : ${e}");
    }
  }

  static Future<void> dataCheck() async{
    await isFileExist().then((value){
      if(value == false){
        Debug.log("SearchHistory : dataCheck : 파일이 없습니다. 생성합니다.");
        make();
      }
    });
  }

  static Future<Queue<String>> get()async {
    String result = await FileIO.readText(_path);
    return _stringToQueue(result);
  }

  static Future<void> reset()async{
    try{
      FileIO.writeText(_path, "/null/");
    }catch(e){
      Debug.logError("_resetSearchHistory : ${e}");
    }
  }

  static Future<void> add(String str_)async {
    Queue<String> result = await get();

    result.remove(str_);
    if(str_ != "")
      result.add(str_);
    if(result.length > _maxNum)
      result.removeFirst();
    FileIO.writeText(_path, _queueToString(result));
  }

  static Future<void> replace(Queue<String> strs_)async{
    FileIO.writeText(_path, _queueToString(strs_));
  }

  static String _queueToString(Queue<String> strs_){
    String result = "";
    strs_.forEach((element) {
      result = result + element + _separator;
    });
    result += nullOperator;
    return result;
  }

  static Queue<String> _stringToQueue(String str){
    Queue<String> result = Queue.from(str.split(_separator));
    result.removeWhere((element) => element == nullOperator);
    
    return result;
  }

}