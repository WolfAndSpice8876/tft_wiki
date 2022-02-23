
class ItemDto
{
  String koreanName = "";
  int index = 0;
  late String image;
  List<String> materials = []; //없는 경우 0 으로
  bool isComplete = false;
  String description = "";

  ItemDto({
    required this.koreanName,
    required this.index,
    required this.materials,
    required this.isComplete,
    required this.description,
  }){
    image = "assets/items/01.png";
  }

  ItemDto.blank(){
    image = "assets/items/01.png";
  }
}