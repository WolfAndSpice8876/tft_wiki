import 'dart:convert';
import 'package:http/http.dart';
import 'package:lol/dto/dto_class.dart';
import '../normal/debug.dart';


class RiotApiUrl
{

  static final String profileVer = "12.4.1";
  static final String apiKey = "api key here"; //api key here

  static String lolUserByName(String name_) {
    return "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/${name_}?api_key=$apiKey";
  }

  static String profileImage(int id_) {
    return "http://ddragon.leagueoflegends.com/cdn/${profileVer}/img/profileicon/${id_}.png";
  }

  static String lolMatchId(String puuid_ , int num_){
    return "https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/${puuid_}/ids?start=0&count=$num_&api_key=${apiKey}";
  }

  static String lolMatchDto(String matchId_){
    return "https://asia.api.riotgames.com/lol/match/v5/matches/${matchId_}?api_key=${apiKey}";
  }

  static String tftUserByName(String name_){
    return "https://kr.api.riotgames.com/tft/summoner/v1/summoners/by-name/${name_}?api_key=${apiKey}";
  }

  static String tftMatches(String puuid_ , int num_){
    return "https://asia.api.riotgames.com/tft/match/v1/matches/by-puuid/${puuid_}/ids?count=${num_}&api_key=${apiKey}";
  }

  static String tftMatchDto(String matchId_){
    return "https://asia.api.riotgames.com/tft/match/v1/matches/${matchId_}?api_key=${apiKey}";
  }

  static String tftLeagueEntryDto(String summonerId){
    return "https://kr.api.riotgames.com/tft/league/v1/entries/by-summoner/${summonerId}?api_key=${apiKey}";
  }

}

class RiotResponse
{
  static const timeout = 10;

  static Future<Response> _getData(String url_)async{
    Response response = Response("",600);
    try{
      return await get(Uri.parse(url_)).timeout(Duration(seconds: timeout));
    }catch(e){
      Debug.log(e.toString());
      return response;
    }
  }


  static Future<Response> getTftUserDataByName(String name_) async {
    Debug.log("RiotResponse : getTftUserDataByName : ${RiotApiUrl.tftUserByName(name_)}");
    return _getData(RiotApiUrl.tftUserByName(name_));
    //return await get(Uri.parse(RiotApiUrl.tftUserByName(name_)));
  }

  static Future<Response> getTftMatchesIds(String puuid_ , int num_)async{
    Debug.log("RiotResponse : getTftMatchesIds : ${RiotApiUrl.tftMatches(puuid_, num_)}");
    return _getData(RiotApiUrl.tftMatches(puuid_, num_));
    //return await get(Uri.parse(RiotApiUrl.tftMatches(puuid_, num_)));
  }

  static Future<Response> getTftMatchDto(String matchId_)async{
    Debug.log("RiotResponse : getTftMatchDto : ${RiotApiUrl.tftMatchDto(matchId_)}");
    return _getData(RiotApiUrl.tftMatchDto(matchId_));
    //return await get(Uri.parse(RiotApiUrl.tftMatchDto(matchId_)));
  }

  static Future<Response> getTftLeagueEntryDTO(String summonerId_)async{
    Debug.log("RiotResponse : getTftLeagueEntryDTO : ${RiotApiUrl.tftLeagueEntryDto(summonerId_)}");
    return _getData(RiotApiUrl.tftLeagueEntryDto(summonerId_));
    //return await get(Uri.parse(RiotApiUrl.tftLeagueEntryDto(summonerId_)));
  }

}

class RiotConvert
{
  final _userNum = 8;

  static Tft_UserDto userDto(var responseBody_){
    var jsonDecoded = jsonDecode(responseBody_);
    return Tft_UserDto(
        puuid: jsonDecoded['puuid'],
        name: jsonDecoded['name'],
        id: jsonDecoded['id'],
        userLevel: jsonDecoded['summonerLevel'],
        profileIconId: jsonDecoded['profileIconId'],
        isLoaded: true
    );
  }

  static List<String> matchIds(var responseBody_){
    var jsonDecoded = jsonDecode(responseBody_);
    return List<String>.from(jsonDecode(jsonDecoded));
  }

  static Tft_MatchDto match(var responseBody_ , String myPuuid_){
    List<Tft_ParticipantDto> pDtos = <Tft_ParticipantDto>[];

    var jsonDecoded = jsonDecode(responseBody_)['info'];
    var jsonPart = jsonDecoded['participants'];

    //#. for 시작
    for (int i = 0; i < 8; i++) {
      var jsonTraits = jsonPart[i]['traits'] as List<dynamic>;
      var jsonUnits = jsonPart[i]['units'] as List<dynamic>;
      List<Tft_TraitInfoDto> traits = <Tft_TraitInfoDto>[];
      List<Tft_UnitInfoDto> units = <Tft_UnitInfoDto>[];

      //#. traits list
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


      //#. units list
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

      //#. 참가자 정보
      Tft_ParticipantDto tmp = Tft_ParticipantDto(
          puuid: jsonPart[i]['puuid'],
          level: jsonPart[i]['level'],
          placement: jsonPart[i]['placement'],
          traits: traits,
          units: units,
          isLoaded: true
      );
      pDtos.add(tmp);
    } // for 끝


    //#. 반환
    return Tft_MatchDto.makeByPuuid(
        Tft_MatchInfoDto(
            gameDataTime: jsonDecoded['game_datetime'],
            gameLength: jsonDecoded['game_length'],
            gameType: jsonDecoded['tft_game_type'],
            queueId: jsonDecoded['queue_id'],
            isLoaded: true
        ),
        pDtos,
        myPuuid_
    );

  }

  static Tft_LeagueEntryDto leagueEntry(var responseBody_){
    Tft_LeagueEntryDto tft_leagueEntryDto = Tft_LeagueEntryDto.blank();
    Tft_TurboLeagueEntryDto tft_turboLeagueEntryDto = Tft_TurboLeagueEntryDto.blank();

    var jsonDecoded = jsonDecode(responseBody_);
    var jsonDatas = jsonDecoded as List<dynamic>;

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

    return tft_leagueEntryDto;
  }

}

class RiotWords
{
  static String getGameTypeName(int queueId_){
    switch(queueId_){
      case 1090:
        return "일반";
      case 1100:
        return "랭크";
      case 1130:
        return "초고속";
      case 1150:
        return "더블 업";
      default :
        return "Unknown";
    }
  }

  static String getSynergyTier(int style_){
    switch(style_){
      case 1 :
        return "bronze";
      case 2 :
        return "silver";
      case 3 :
        return "gold";
      case 4 :
        return "chromatic";
      default :
        return "null";
    }
  }
}