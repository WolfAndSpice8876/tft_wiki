
import 'package:lol/database/data_library.dart';
import 'package:lol/dto/champion_dto.dart';
import 'package:lol/dto/item_dto.dart';
import 'package:lol/dto/trait_dto.dart';


class SpecificChampion
{
  ChampionDto championDto = ChampionDto.blank();
  List<TraitDto?> origins = <TraitDto>[];
  List<TraitDto?> classes  = <TraitDto>[];
  List<ItemDto?> recommendedItems = <ItemDto>[];

  SpecificChampion({
    required this.championDto,
  }){

    origins = <TraitDto>[];
    championDto.origins.forEach((element) {
      origins.add(DataLibrary.trait.allByKoreanName[element] ?? TraitDto.blank());
    });

    classes = <TraitDto>[];
    championDto.classes.forEach((element) {
      classes.add(DataLibrary.trait.allByKoreanName[element] ?? TraitDto.blank());
    });

    recommendedItems = <ItemDto>[];
    championDto.recommendedItems.forEach((element) {
      recommendedItems.add(DataLibrary.item.allByKoreanName[element] ?? ItemDto.blank());
    });
  }

  SpecificChampion.blank(){}

}

class SpecificTrait
{
  TraitDto traitDto = TraitDto.blank();
  List<ChampionDto?> members = <ChampionDto>[];

  SpecificTrait({
    required this.traitDto,
  }){
    members = <ChampionDto>[];
    traitDto.members.forEach((element) {
      members.add(DataLibrary.champion.allByKoreanName[element] ?? ChampionDto.blank());
    });
  }

  SpecificTrait.blank(){}
}

class SpecificItem
{
  ItemDto itemDto = ItemDto.blank();
  List<ItemDto?> materials = <ItemDto>[];

  SpecificItem({
    required this.itemDto,
  }){
    if(itemDto.isComplete = true){
      materials = <ItemDto>[];
      itemDto.materials.forEach((element) {
        materials.add(DataLibrary.item.allByKoreanName[element] ?? ItemDto.blank());
      });
    }
  }

  SpecificItem.blank(){}

}