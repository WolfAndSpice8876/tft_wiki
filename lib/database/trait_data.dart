import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:lol/dto/trait_dto.dart';

class TraitDataBase {

  static List<TraitDto> data = <TraitDto>[];

  static Future<void> get() async {
    List<TraitDto> result = <TraitDto>[];
    String jsonString = await rootBundle.loadString("json_data/trait.json");
    final traitData = jsonDecode(jsonString)['data'] as List<dynamic>;

    traitData.forEach((element) {
      List<String> memberList = new List<String>.from(element['Members']);
      TraitType type = element['Type'] == 0 ?  TraitType.origin : TraitType.classes;

      result.add(TraitDto(
          riotName: element['RiotName'],
          koreanName: element['KoreanName'],
          type: type,
          members: memberList,
          description: element['Description']
      ));
    });

    data = result;
    return;
  }
}

