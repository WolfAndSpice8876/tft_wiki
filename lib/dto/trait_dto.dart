

enum TraitType
{
  origin,
  classes,

}

class TraitDto
{
  String riotName = "";
  String koreanName= "";
  TraitType type = TraitType.origin;
  late String image;
  List<String> members = [""];
  String description = "";

  TraitDto({
    required this.riotName,
    required this.koreanName,
    required this.type,
    required this.members,
    required this.description,
  }){
    image = "assets/synergy/Set6_Academy.png";
  }

  TraitDto.blank(){
    image = "assets/synergy/Set6_Academy.png";
  }
}