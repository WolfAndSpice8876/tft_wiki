
import 'package:lol/database/champion_data.dart';
import 'package:lol/database/item_data.dart';
import 'package:lol/database/trait_data.dart';
import 'package:lol/dto/champion_dto.dart';
import 'package:lol/dto/item_dto.dart';
import 'package:lol/dto/trait_dto.dart';

class DataLibrary
{
  static ChampionLibrary champion = ChampionLibrary.blank();
  static TraitLibrary trait = TraitLibrary.blank();
  static ItemLibrary item = ItemLibrary.blank();

  static Future<void> make() async{
    await ChampionDataBase.get();
    await TraitDataBase.get();
    await ItemDataBase.get();
    champion = await ChampionLibrary.get();
    trait = await TraitLibrary.get();
    item = await ItemLibrary.get();

    return;
  }
}

class ChampionLibrary
{

  //#. 변수

  late Map<String , ChampionDto> allByKoreanName; //전체 이름
  late List<List<ChampionDto>> byCost;


  //#. 생성자
  ChampionLibrary({
    required this.allByKoreanName,
    required this.byCost,
  });

  ChampionLibrary.blank(){
    allByKoreanName = {};
    byCost = <List<ChampionDto>>[];
  }


  //#. 함수
  ChampionDto findByName(String name_){
    return allByKoreanName[name_] ?? ChampionDto.blank();
  }


  //#. get
  static Future<ChampionLibrary> get() async{

    Map<String , ChampionDto> allByKoreanName_ = {};
    List<List<ChampionDto>> byCost_ = <List<ChampionDto>>[];

    for(int i = 0; i<5; i++){
      byCost_.add(<ChampionDto>[]);
    }

    ChampionDataBase.data.forEach((element) {
      allByKoreanName_[element.koreanName] = element;
      byCost_[element.rarity].add(element);
    });

    return ChampionLibrary(
      allByKoreanName : allByKoreanName_,
      byCost: byCost_,
    );
  }

}

class TraitLibrary
{

//#. 변수

  late Map<String , TraitDto> allByKoreanName;
  late Map<String , TraitDto> originsByKoreanName;
  late Map<String , TraitDto> classesByKoreanName;


  //#. 생성자
  TraitLibrary({
    required this.allByKoreanName,
    required this.originsByKoreanName,
    required this.classesByKoreanName,
  });

  TraitLibrary.blank(){
    allByKoreanName = {};
    originsByKoreanName = {};
    classesByKoreanName = {};
  }


  //#. 함수
  TraitDto findByName(String name_){
    return  allByKoreanName[name_] ?? TraitDto.blank();
  }

  TraitDto find(Map<String ,TraitDto> map_ , String str_){
    return map_[str_] ?? TraitDto.blank();
  }



  //#. get
  static Future<TraitLibrary> get() async{

    Map<String , TraitDto> allByKoreanName_ = {};
    Map<String , TraitDto> originsByKoreanName_ = {};
    Map<String , TraitDto> classesByKoreanName_ = {};

    TraitDataBase.data.forEach((element) {
      allByKoreanName_[element.koreanName] = element;
      if(element.type == TraitType.origin)
        originsByKoreanName_[element.koreanName] = element;
      if(element.type == TraitType.classes)
        classesByKoreanName_[element.koreanName] = element;

    });

    return TraitLibrary(
      allByKoreanName: allByKoreanName_,
      originsByKoreanName: originsByKoreanName_,
      classesByKoreanName: classesByKoreanName_,
    );
  }

}

class ItemLibrary
{
//#. 변수

  late Map<String , ItemDto> allByKoreanName;



  //#. 생성자
  ItemLibrary({
    required this.allByKoreanName,
  });

  ItemLibrary.blank(){
    allByKoreanName = {};
  }


  ItemDto findByName(String name_){
    return(allByKoreanName[name_] ?? ItemDto.blank());
  }


  //#. get
  static Future<ItemLibrary> get() async{

    Map<String , ItemDto> allByKoreanName_ = {};

    ItemDataBase.data.forEach((element) {
      allByKoreanName_[element.koreanName] = element;
    });

    return ItemLibrary(allByKoreanName: allByKoreanName_);
  }
}