import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:lol/dto/champion_dto.dart';

class ChampionDataBase {

  static List<ChampionDto> data = <ChampionDto>[];

  static Future<void> get() async{
    List<ChampionDto> result = <ChampionDto>[];
    String jsonString = await rootBundle.loadString("json_data/champion.json");
    final championData = jsonDecode(jsonString)['data'] as List<dynamic>;

    championData.forEach((element) {

      List<String> originsList = new List<String>.from(element['Origins']);
      List<String> classesList = new List<String>.from(element['Classes']);
      List<String> recommendedItemsList = new List<String>.from(element['RecommendedItems']);
      result.add(
          ChampionDto(
          name: element['Name'],
          koreanName: element['KoreanName'],
          riotName: element['RiotName'],
          rarity: element['Rarity'] ,
          origins: originsList,
          classes: classesList,
          recommendedItems: recommendedItemsList,
          skillName: element['SkillName'],
          skillDescription: element['SkillDescription']
        )
      );
    });

    data = result;
    return;
  }
}