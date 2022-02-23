import 'package:http/http.dart' as http;
import 'package:lol/normal/debug.dart';
import 'package:lol/dto/dto_class.dart';
import 'package:lol/normal/file_io.dart';
import 'package:lol/riot/riot_api.dart';

class RiotDataIo
{
  static void SaveData(String name_) async{
    http.Response profileResponse = await RiotResponse.getTftUserDataByName(name_);

    //#. 전체 디렉토리 생성
    await FileIO.makeDirectory("test");

    if(profileResponse.statusCode != 200){
      Debug.log("SaveData : Connect Error : ${profileResponse.statusCode}");
      return;
    }

    await FileIO.makeDirectory("test/profile");

    await FileIO.writeText("test/profile/$name_.txt", profileResponse.body);

    FileIO.writeText("testData/test.txt", profileResponse.body);
    Debug.log(profileResponse.body);
  }

  static void ReadData(String name_) async{

    await FileIO.isFileExist("testData/test.txt").then((value){
      if(value == true)
        Debug.log("ReadData : Exist");
      else
        Debug.log("ReadData : unExist");
    });

    String responseBody = await FileIO.readText("test/profile/$name_.txt");


    if(responseBody == ""){
      Debug.log("ReadData : responseBody is null");
      return;
    }

    Tft_UserDto tft_userDto = RiotConvert.userDto(responseBody);

    Debug.log("ReadData :${tft_userDto.name}");
    Debug.log("ReadData :${tft_userDto.puuid}");
    Debug.log("ReadData :${tft_userDto.userLevel}");

  }
}

