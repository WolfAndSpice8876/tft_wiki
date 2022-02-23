import 'dart:convert';
import '../normal/debug.dart';
import '../dto/dto_class.dart';
import '../riot/riot_api.dart';
import 'package:http/http.dart';


class Tft_DataGetter {

  static Future<StatusData<Tft_UserDto>> getUserDtoByName(String name_) async
  {
    Response response;
    late Tft_UserDto tft_userDto;
    response = await RiotResponse.getTftUserDataByName(name_);
    if (response.statusCode == 200) {
      try {
        var json = jsonDecode(response.body);
        tft_userDto = Tft_UserDto(
            puuid: json['puuid'],
            name: json['name'],
            id: json['id'],
            userLevel: json['summonerLevel'],
            profileIconId: json['profileIconId'],
            isLoaded: true
        );
        return StatusData(status: response.statusCode, value: tft_userDto);
      } catch (e) {
        Debug.log("Tft_DataGetter : getUserDtoByName : ${e}");
        return StatusData(status: response.statusCode, value: Tft_UserDto.blank());
      }
    }
    else {
      if (response.statusCode == 403) {
        print("Tft_getUserDtoByName : Connect Error : ${response.statusCode}");
        print("Tft_getUserDtoByName : ${RiotApiUrl.tftUserByName(name_)}");
        return StatusData(
            status: response.statusCode, value: Tft_UserDto.blank());
      }
      else if (response.statusCode == 404) {
        print("Tft_getUserDtoByName : Connect Error : ${response.statusCode}");
        print("Tft_getUserDtoByName : Can not find name");
        return StatusData(
            status: response.statusCode, value: Tft_UserDto.blank());
      }
      return StatusData(
          status: response.statusCode, value: Tft_UserDto.blank());
    }
  }

  static Future<List<String>> getMatchesId(String puuid_, int num_) async
  {
    Response response;
    response = await RiotResponse.getTftMatchesIds(puuid_, num_);
    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    }
    else {
      print("Tft_getMatchDtos : Connect Error : ${response.statusCode}");
      return <String>[];
    }
  }

  static Future<StatusData<Tft_MatchDto>> getMatchDto(String matchId_, String myPuuid_) async
  {
    Response response;
    response = await RiotResponse.getTftMatchDto(matchId_);
    if (response.statusCode == 200) {

      try {
        var jsonData = jsonDecode(response.body)['info'];
        var jsonPart = jsonData['participants'];


        List<Tft_ParticipantDto> pDtos = <Tft_ParticipantDto>[];
        for (int i = 0; i < 8; i++) {
          var jsonTraits = jsonPart[i]['traits'] as List<dynamic>;
          var jsonUnits = jsonPart[i]['units'] as List<dynamic>;
          List<Tft_TraitInfoDto> traits = <Tft_TraitInfoDto>[];
          List<Tft_UnitInfoDto> units = <Tft_UnitInfoDto>[];

          for (int j = 0; j < jsonTraits.length; j++) {
            Tft_TraitInfoDto tft_traitDto = Tft_TraitInfoDto(
                name: jsonTraits[j]['name'],
                numUnits: jsonTraits[j]['num_units'],
                style: jsonTraits[j]['style'],
                tierCurrent: jsonTraits[j]['tier_current'],
                tierTotal: jsonTraits[j]['tier_total'],
                isLoaded: true
            );
            traits.add(tft_traitDto);
          }

          for (int j = 0; j < jsonUnits.length; j++) {
            List<int> items = [];
            var jsonItems = jsonUnits[j]['items'] as List;
            for (int k = 0; k < jsonItems.length; k++) {
              items.add(jsonItems[k]);
            }

            Tft_UnitInfoDto tft_unitDto = Tft_UnitInfoDto(
                character_id: jsonUnits[j]['character_id'],
                name: jsonUnits[j]['name'],
                //chosen: jsonUnits[j]['chosen'],
                rarity: jsonUnits[j]['rarity'],
                tier: jsonUnits[j]['tier'],
                items: items,
                isLoaded: true
            );
            units.add(tft_unitDto);
          }


          Tft_ParticipantDto tmp = Tft_ParticipantDto(
              puuid: jsonPart[i]['puuid'],
              level: jsonPart[i]['level'],
              placement: jsonPart[i]['placement'],
              traits: traits,
              units: units,
              isLoaded: true
          );
          pDtos.add(tmp);
        }

        Tft_MatchDto matchDTO = Tft_MatchDto.makeByPuuid(
            Tft_MatchInfoDto(
                gameDataTime: jsonData['game_datetime'],
                gameLength: jsonData['game_length'],
                gameType: jsonData['tft_game_type'],
                queueId: jsonData['queue_id'],
                isLoaded: true
            ),
            pDtos,
            myPuuid_
        );
        return StatusData(status: response.statusCode, value: matchDTO);

      }catch (e) {
       Debug.log("Tft_DataGetter : getMatchDto : ${e}");
       return StatusData(status: 0, value: Tft_MatchDto.blank());
      }


    }
    else {
      print("Tft_getMatchDto : Connect Error : ${response.statusCode}");
      return StatusData(
          status: response.statusCode, value: Tft_MatchDto.blank());
    }
  }

  static Future<List<StatusData<Tft_MatchDto>>> getMatchDtos(String puuid_ , int nums_) async
  {
    int requestedMatches = 0;
    List<String> matchIds_ = await getMatchesId(puuid_ ,nums_ );
    List<StatusData<Tft_MatchDto>> matchDtos = <StatusData<Tft_MatchDto>>[];
    int requestedNum = matchIds_.length;

    for (int i = 0; i < requestedNum; i++) {
      matchDtos.add(StatusData(value: Tft_MatchDto.blank()));
    }

    await Future.wait([
      for(int i = 0; i<requestedNum; i++)
        getMatchDto(matchIds_[i], puuid_).then((value){
          int j = i;
          matchDtos[j] = value;
          requestedMatches++;
        }),
    ]);

    return matchDtos;
  }

  static Future<Tft_MatchesData> getExtraMatchDatas(String puuid_ , int nums_) async{
    List<StatusData<Tft_MatchDto>> _allMatches = <StatusData<Tft_MatchDto>>[];
    List<StatusData<Tft_MatchDto>> _normalMatchDatas = <StatusData<Tft_MatchDto>>[];
    List<StatusData<Tft_MatchDto>> _rankMatchDatas = <StatusData<Tft_MatchDto>>[];
    List<StatusData<Tft_MatchDto>> _turboMatchDatas = <StatusData<Tft_MatchDto>>[];
    List<StatusData<Tft_MatchDto>> _doubleMatchDatas = <StatusData<Tft_MatchDto>>[];

    _allMatches = await getMatchDtos(puuid_, nums_);

    _allMatches.forEach((element) {
      if(element.status == 200){
        switch(element.value!.matchinfoDto.queueId){
          case 1090:
            _normalMatchDatas.add(element);
            break ;

          case 1100:
            _rankMatchDatas.add(element);
            break ;

          case 1130:
            _turboMatchDatas.add(element);
            break ;
          case 1150:
            _doubleMatchDatas.add(element);
            break ;

          default :
            break ;
        }
      }
    });

    return Tft_MatchesData(
        allMatches: _allMatches,
        normalMatchDatas: _normalMatchDatas,
        rankMatchDatas: _rankMatchDatas,
        turboMatchDatas: _turboMatchDatas,
        doubleMatchDatas: _doubleMatchDatas
    );
  }

  static Future<StatusData<Tft_LeagueEntryDto>> getLeagueEntryDto(
      String summonerId_) async
  {
    Response response;
    Tft_LeagueEntryDto tft_leagueEntryDto = Tft_LeagueEntryDto.blank();
    Tft_TurboLeagueEntryDto tft_turboLeagueEntryDto = Tft_TurboLeagueEntryDto.blank();
    response = await RiotResponse.getTftLeagueEntryDTO(summonerId_);
    if (response.statusCode != 200) {
      Debug.log("Tft_DataGetter : getLeagueEntryDto : Connect Error : ${response.statusCode}");
      return StatusData(
          status: response.statusCode, value: Tft_LeagueEntryDto.blank());
    }

    try {
      var jsonData = jsonDecode(response.body);
      var jsonDatas = jsonData as List<dynamic>;

      jsonDatas.forEach((element) {
        if(element['queueType'] == "RANKED_TFT"){
          tft_leagueEntryDto = Tft_LeagueEntryDto(
            leagueId: element['leagueId'],
            summonerId: element['summonerId'],
            summonerName: element['summonerName'],
            queueType: element['queueType'],
            tier: element['tier'],
            rank: element['rank'],
            //turboTier: jsonData['leagueId'],
            //turboRating: jsonData['leagueId'],
            leaguePoints: element['leaguePoints'],
            wins: element['wins'],
            losses: element['losses'],
            isLoaded: true,
          );
        }
        else if(element['queueType'] == "RANKED_TFT_TURBO"){
          tft_turboLeagueEntryDto = Tft_TurboLeagueEntryDto(
              queueType: element['queueType'],
              ratedTier: element['ratedTier'],
              ratedRating: element['ratedRating'],
              summonerId: element['summonerId'],
              summonerName: element['summonerName'],
              wins: element['wins'],
              losses: element['losses'],
              isLoaded: true
          );
        }
      });

      return StatusData(status: response.statusCode, value: tft_leagueEntryDto);
    }catch (e) {
      Debug.log("Tft_DataGetter : getExtraMatchDatas : ${e}");
      return StatusData(status: response.statusCode, value: Tft_LeagueEntryDto.blank());
    }
  }

}



class Tft_RequestData {
  late int maxRequestMatches;
  late int requestedMatches;
  late StatusData<Tft_UserDto> userData;
  late List<String> matchIds;
  late int statusCode;
  late StatusData<Tft_LeagueEntryDto> leagueEntryDto;
  late Tft_MatchesData matchesData;

  Tft_RequestData(int matchNums) {
    maxRequestMatches = matchNums;
    requestedMatches = 0;
    userData = StatusData(value: Tft_UserDto.blank());
    matchIds = <String>[];
    statusCode = 0;
    leagueEntryDto = StatusData(status: 0, value: Tft_LeagueEntryDto.blank());
    matchesData = Tft_MatchesData.blank();
  }

  Tft_RequestData.blank(){
    maxRequestMatches = 0;
    requestedMatches = 0;
    userData = StatusData(value: Tft_UserDto.blank());
    matchIds = <String>[];
    statusCode = 0;
    leagueEntryDto = StatusData(status: 0, value: Tft_LeagueEntryDto.blank());
    matchesData = Tft_MatchesData.blank();
  }

  Future<int> getData(String name_, int matchNums_) async {
    requestedMatches = 0;
    maxRequestMatches = matchNums_;
    userData = StatusData(value: Tft_UserDto.blank());

    // #. 유저 정보 가져오기
    await Tft_DataGetter.getUserDtoByName(name_).then((value) {
      userData = value;
    });
    if (userData.status != 200) {
      Debug.log("Tft_RequestData : Connect Error :  Tft_UserDto : ${userData.status}");
      statusCode = userData.status!;
      return userData.status!;
    }

    // #. 유저 리그 정보 가져오기
    await Tft_DataGetter.getLeagueEntryDto(userData.value!.id).then((value){
      leagueEntryDto = value;
    });
    if(leagueEntryDto.status != 200){
      Debug.log("Tft_RequestData : Connect Error :  Tft_UserDto : ${leagueEntryDto.status}");
      statusCode = leagueEntryDto.status!;
      return leagueEntryDto.status!;
    }

    // #. match id 리스트 가져오기
    await Tft_DataGetter.getMatchesId(userData.value!.puuid, matchNums_).then((
        value) {
      matchIds = value;
    });

    // #. match 정보 가져오기
    maxRequestMatches = matchIds.length;
    matchesData = await Tft_MatchesData.getData(userData.value!.puuid, matchNums_);
    requestedMatches = matchesData.allMatches.length;
    statusCode = userData.status!;
    return 200;
  }
}



class Tft_MatchesData
{
  late List<StatusData<Tft_MatchDto>> allMatches;
  late List<StatusData<Tft_MatchDto>> normalMatchDatas;
  late List<StatusData<Tft_MatchDto>> rankMatchDatas;
  late List<StatusData<Tft_MatchDto>> turboMatchDatas;
  late List<StatusData<Tft_MatchDto>> doubleMatchDatas;

  Tft_MatchesData({
    required this.allMatches,
    required this.normalMatchDatas,
    required this.rankMatchDatas,
    required this.turboMatchDatas,
    required this.doubleMatchDatas,
  });

  Tft_MatchesData.blank(){
    allMatches = <StatusData<Tft_MatchDto>>[];
    normalMatchDatas = <StatusData<Tft_MatchDto>>[];
    rankMatchDatas = <StatusData<Tft_MatchDto>>[];
    turboMatchDatas = <StatusData<Tft_MatchDto>>[];
    doubleMatchDatas = <StatusData<Tft_MatchDto>>[];
  }

  static Future<Tft_MatchesData> getData(String puuid_ ,int num_)async{
    List<StatusData<Tft_MatchDto>> _allMatches = <StatusData<Tft_MatchDto>>[];
    List<StatusData<Tft_MatchDto>> _normalMatchDatas = <StatusData<Tft_MatchDto>>[];
    List<StatusData<Tft_MatchDto>> _rankMatchDatas = <StatusData<Tft_MatchDto>>[];
    List<StatusData<Tft_MatchDto>> _turboMatchDatas = <StatusData<Tft_MatchDto>>[];
    List<StatusData<Tft_MatchDto>> _doubleMatchDatas = <StatusData<Tft_MatchDto>>[];

    _allMatches = await Tft_DataGetter.getMatchDtos(puuid_, num_);

    _allMatches.forEach((element) {
      if(element.status == 200){
        switch(element.value!.matchinfoDto.queueId){
          case 1090:
            _normalMatchDatas.add(element);
            break ;

          case 1100:
            _rankMatchDatas.add(element);
            break ;

          case 1130:
            _turboMatchDatas.add(element);
            break ;
          case 1150:
            _doubleMatchDatas.add(element);
            break ;

          default :
            break ;
        }
      }
    });

    return Tft_MatchesData(
        allMatches: _allMatches, 
        normalMatchDatas: _normalMatchDatas,
        rankMatchDatas: _rankMatchDatas, 
        turboMatchDatas: _turboMatchDatas,
        doubleMatchDatas: _doubleMatchDatas
    );
  }

}