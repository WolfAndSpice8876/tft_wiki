
import 'package:lol/normal/debug.dart';
import 'package:lol/dto/dto_class.dart';
import 'package:lol/normal/file_io.dart';
import 'package:lol/riot/riot_api.dart';
import 'package:http/http.dart' as http;

Future<void> SaveData(String name_) async{
  http.Response profileResponse = await RiotResponse.getTftUserDataByName(name_);

  //#. 전체 디렉토리 생성
  await FileIO.makeDirectory("MyUser");

  if(profileResponse.statusCode != 200){
    Debug.log("SaveData : Connect Error : ${profileResponse.statusCode}");
    return;
  }

  await FileIO.writeText("MyUser/user.txt", profileResponse.body);

  Debug.log(profileResponse.body);
}

Future<Tft_UserDto> ReadData() async{

  await FileIO.isFileExist("MyUser/user.txt").then((value){
    if(value == true)
      Debug.log("ReadData : Exist");
    else
      Debug.log("ReadData : unExist");
  });

  String responseBody = await FileIO.readText("MyUser/user.txt");

  if(responseBody == ""){
    Debug.log("ReadData : responseBody is null");
    return Tft_UserDto.blank();
  }

  Tft_UserDto tft_userDto = RiotConvert.userDto(responseBody);

  Debug.log("ReadData :${tft_userDto.name}");
  Debug.log("ReadData :${tft_userDto.puuid}");
  Debug.log("ReadData :${tft_userDto.userLevel}");

  return tft_userDto;
}