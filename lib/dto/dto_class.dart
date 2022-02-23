
import 'package:flutter/material.dart';


//Lol Data Class
class Lol_UserDTO
{
  String accountId = "null";
  int profileIconId = 0;
  int revisionDate = 0;
  String name = "null";
  String id = "null";
  String puuid = "null";
  int summonerLevel = 0;
  bool isLoaded = false;

  Lol_UserDTO(
      this.accountId,
      this.profileIconId,
      this.revisionDate,
      this.name,
      this.id,
      this.puuid,
      this.summonerLevel,
      this.isLoaded
      );

  Lol_UserDTO.vacuum()
  {
    this.accountId = "null";
    this.profileIconId = 0;
    this.revisionDate = 0;
    this.name = "null";
    this.id = "null";
    this.puuid = "null";
    this.summonerLevel = 0;
    this.isLoaded = false;
  }

}

class Lol_MatchDTO
{
  Lol_ParticipantDto myParticipantDto = Lol_ParticipantDto.blank();
  List<Lol_ParticipantDto> participants = <Lol_ParticipantDto>[];
  Lol_InfoDto info = Lol_InfoDto.blank();
  String myName = "null";
  String myPuuid = "null";
  bool isLoaded = false;

  Lol_MatchDTO.blank(){
    this.myParticipantDto = Lol_ParticipantDto.blank();
    this.participants = [];
    this.info = Lol_InfoDto.blank();
    this.myName = "null";
    this.myPuuid = "null";
    isLoaded = false;
  }

  Lol_MatchDTO.makeByPuuid(
      List<Lol_ParticipantDto> participants_,
      Lol_InfoDto infoDto_,
      String myPuuid_
  )
  {
    this.participants = participants_;
    this.myPuuid = myPuuid_;
    this.info = infoDto_;
    for(int i = 0; i< participants.length; i++){
      if(participants[i].puuid == myPuuid){
        this.myParticipantDto = participants[i];
        this.myName = participants[i].name;
        isLoaded = true;
        return;
      }
    }
    print("MatchDTO : Data Error : There is no matching puuid in the participants list");
    Lol_MatchDTO.blank();
    return;
  }

  Lol_MatchDTO.makeByName(
      List<Lol_ParticipantDto> participants_,
      Lol_InfoDto infoDto,
      String myName_
      )
  {
    this.participants = participants_;
    this.myName = myName_;
    participants.forEach((element) {
      if(element.name == myName){
        this.myParticipantDto = element;
        this.myPuuid = element.puuid;
        this.isLoaded = true;
        return;
      }
    });
    print("MatchDTO : Data Error : There is no matching name in the participants list");
    Lol_MatchDTO.blank();
    return;
  }



}

class Lol_ParticipantDto
{
  String puuid = "null";
  String name = "null";
  bool win = false;
  int kills = 0;
  int assists = 0;
  int deaths = 0;
  int champLevel = 0;
  String individualPosition = "null";
  String lane = "null";
  String role = "null";
  String teamPosition = "null";
  int championId = 0;
  String championName = "null";
  int neutralMinionsKilled = 0;
  int totalMinionsKilled = 0;
  List<int> items = [];
  int totalDamageDealtToChampions = 0;
  bool isLoaded =false;

  Lol_ParticipantDto({
    required this.puuid,
    required this.name,
    required this.win,
    required this.kills,
    required this.assists,
    required this.deaths,
    required this.champLevel,
    required this.individualPosition,
    required this.lane,
    required this.role,
    required this.teamPosition,
    required this.championId,
    required this.championName,
    required this.neutralMinionsKilled,
    required this.totalMinionsKilled,
    required this.items,
    required this.totalDamageDealtToChampions,
    required this.isLoaded
  });

  Lol_ParticipantDto.blank(){
    this.puuid = "null";
    this.name = "null";
    this.win = false;
    this.kills = 0;
    this.assists = 0;
    this.deaths = 0;
    this.champLevel = 0;
    this.individualPosition = "null";
    this.lane = "null";
    this.role = "null";
    this.teamPosition = "null";
    this.championId = 0;
    this.championName = "null";
    this.neutralMinionsKilled = 0;
    this.totalMinionsKilled = 0;
    this.items = [];
    this.totalDamageDealtToChampions = 0;
    this.isLoaded = false;
  }

}

class Lol_InfoDto
{
  int gameCreation = 0;
  int gameDuration = 0;
  String gameMode = "null";
  bool isLoaded = false;

  Lol_InfoDto({
    required this.gameCreation,
    required this.gameDuration,
    required this.gameMode,
    required this.isLoaded
  });

  Lol_InfoDto.blank(){
    this.gameCreation = 0;
    this.gameDuration = 0;
    this.gameMode = "null";
    this.isLoaded = false;
  }


}


// Tft Data Class

class Tft_UnitInfoDto
{
  String character_id = "null";
  String name = "null";
  //String chosen = "null";
  int rarity = 0;
  int tier = 0;
  List<int> items = [];
  bool isLoaded = false;

  Tft_UnitInfoDto({
    required this.character_id,
    required this.name,
    //required this.chosen,
    required this.rarity,
    required this.tier,
    required this.items,
    required this.isLoaded,
  });

  Tft_UnitInfoDto.blank(){
    this.character_id = "null";
    this.name = "null";
    //this.chosen = "null";
    this.rarity = 0;
    this.tier = 0;
    this.items = [];
    this.isLoaded = false;
  }
}

class Tft_TraitInfoDto
{
  String name = "null";
  int numUnits = 0;
  int style = 0;
  int tierCurrent = 0;
  int tierTotal = 0;
  bool isLoaded = false;

  Tft_TraitInfoDto({
    required this.name,
    required this.numUnits,
    required this.style,
    required this.tierCurrent,
    required this.tierTotal,
    required this.isLoaded,
  });

  Tft_TraitInfoDto.blank(){
    name = "null";
    numUnits = 0;
    style = 0;
    tierCurrent = 0;
    tierTotal = 0;
    isLoaded = false;
  }
}

class Tft_ParticipantDto
{
  String puuid = "null";
  int level = 0;
  int placement = 0;
  List<Tft_TraitInfoDto> traits = <Tft_TraitInfoDto>[];
  List<Tft_UnitInfoDto> units = <Tft_UnitInfoDto>[];
  bool isLoaded = false;

  Tft_ParticipantDto({
    required this.puuid,
    required this.level,
    required this.placement,
    required this.traits,
    required this.units,
    required this.isLoaded,
  });

  Tft_ParticipantDto.blank(){
    this.puuid = "null";
    this.level = 0;
    this.placement = 0;
    this.traits = <Tft_TraitInfoDto>[];
    this.units = <Tft_UnitInfoDto>[];
    this.isLoaded = false;
  }
}

class Tft_MatchInfoDto
{
  int gameDataTime = 0;
  double gameLength = 0;
  String gameType = "null";
  int queueId = 0;
  bool isLoaded = false;

  Tft_MatchInfoDto({
    required this.gameDataTime,
    required this.gameLength,
    required this.gameType,
    required this.queueId,
    required this.isLoaded
  });

  Tft_MatchInfoDto.blank(){
    this.gameDataTime = 0;
    this.gameLength = 0;
    this.gameType = "null";
    this.queueId = 0;
    this.isLoaded = false;
  }

}

class Tft_UserDto
{
  String puuid = "null";
  String name = "null";
  String id = "null";
  int userLevel = 0;
  int profileIconId = 0;
  bool isLoaded = false;

  Tft_UserDto({
    required this.puuid,
    required this.name,
    required this.id,
    required this.userLevel,
    required this.profileIconId,
    required this.isLoaded,
  });

  Tft_UserDto.blank(){
    this.profileIconId = 0;
    this.name = "null";
    this.id = "null";
    this.puuid = "null";
    this.userLevel = 0;
    this.isLoaded = false;
  }
}

class Tft_MatchDto
{
  Tft_MatchInfoDto matchinfoDto = Tft_MatchInfoDto.blank();
  String myPuuid = "null";
  Tft_ParticipantDto myParticipantDto = Tft_ParticipantDto.blank();
  List<Tft_ParticipantDto> participantDtos = <Tft_ParticipantDto>[];
  bool? isLoaded = false;

  Tft_MatchDto.blank(){
    this.matchinfoDto =Tft_MatchInfoDto.blank();
    this.myPuuid ="null";
    this.myParticipantDto = Tft_ParticipantDto.blank();
    this.participantDtos = <Tft_ParticipantDto>[];
    this.isLoaded = false;
  }

  Tft_MatchDto.makeByPuuid(
      Tft_MatchInfoDto infoDto_,
      List<Tft_ParticipantDto> participantDtos_,
      String myPuuid_
  )
  {
    this.matchinfoDto = infoDto_;
    this.participantDtos = participantDtos_;
    this.myPuuid = myPuuid_;
    for(int i = 0; i< participantDtos_.length; i++){
      if(participantDtos_[i].puuid == myPuuid){
        this.myParticipantDto = participantDtos_[i];
        isLoaded = true;
        return;
      }
    }
    print("Tft_MatchDto : Data Error : There is no matching puuid in the participants list");
    Tft_MatchDto.blank();
    return;
  }

  static List<Tft_MatchDto> makeList(int n){
    List<Tft_MatchDto> tmp = <Tft_MatchDto>[];
    for(int i = 0; i< n; i++)
      tmp.add(Tft_MatchDto.blank());
    return tmp;
  }
}

class Tft_LeagueEntryDto
{
  String leagueId = "null";
  String summonerId = "null";
  String summonerName = "null";
  String queueType = "null";
  String tier = "null";
  String rank = "null";
  int leaguePoints = 0; //초고속 모드 포함 x
  //String? turboTier;
  //int? turboRating;
  int wins = 0;
  int losses = 0;
  bool isLoaded = false;
  //Tft_MiniSeriesDTO? miniSeries; // 초고속 모드 포함 x

  Tft_LeagueEntryDto({
    required this.leagueId,
    required this.summonerId,
    required this.summonerName,
    required this.queueType,
    required this.tier,
    required this.rank,
    //@required this.turboTier,
    //@required this.turboRating,
    required this.leaguePoints,
    required this.wins,
    required this.losses,
    required this.isLoaded
    //@required this.miniSeries,
  });

  Tft_LeagueEntryDto.blank(){
    this.leagueId = "null";
    this.summonerId = "null";
    this.summonerName = "null";
    this.queueType = "null";
    this.tier = "null";
    this.rank = "null";
    //this.turboTier = "null";
    //this.turboRating = 0;
    this.leaguePoints = 0;
    this.wins = 0;
    this.losses = 0;
    this.isLoaded = false;
    //this.miniSeries = Tft_MiniSeriesDTO.blank();
  }


}

class Tft_TurboLeagueEntryDto
{
  String queueType = "null";
  String ratedTier = "null";
  int ratedRating = 0;
  String summonerId = "null";
  String summonerName = "null";
  int wins = 0;
  int losses = 0;
  bool isLoaded = false;

  Tft_TurboLeagueEntryDto({
    required queueType,
    required ratedTier,
    required ratedRating,
    required summonerId,
    required summonerName,
    required wins,
    required losses,
    required isLoaded,
  });

  Tft_TurboLeagueEntryDto.blank();

  Tft_TurboLeagueEntryDto.None(){

  }
}

class Tft_MiniSeriesDTO
{
  String progress = "null";
  int target = 0;
  int wins = 0;
  int losses = 0;

  Tft_MiniSeriesDTO({
    required this.progress,
    required this.target,
    required this.wins,
    required this.losses,
  });

  Tft_MiniSeriesDTO.blank(){
    this.progress = "null";
    this.target = 0;
    this.wins = 0;
    this.losses = 0;
  }
}

// Data Container

class StatusData<T>
{
  // 400	Bad request
  // 401	Unauthorized
  // 403	Forbidden
  // 404	Data not found
  // 405	Method not allowed
  // 415	Unsupported media type
  // 429	Rate limit exceeded
  // 500	Internal server error
  // 502	Bad gateway
  // 503	Service unavailable
  // 504	Gateway timeout

  int? status = 0;
  T? value;


  StatusData({
    @required this.status,
    @required this.value
  });
}


