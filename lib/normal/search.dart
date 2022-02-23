
class Search
{

  static List<String> findWithList(List<String> dataBase_, String content_){
    List<String> result = <String>[];
    if(content_ == "")
      return result;
    dataBase_.forEach((element) {
      if(element.contains(content_))
        result.add(element);
    });
    return result;
  }

  static List<T> findWithMap<T>(Map<String , T> dataBase_ , String content_){
    List<T> result = <T>[];
    if(content_ == "")
      return result;
    dataBase_.forEach((key, value) {
      if(key.contains(content_))
        result.add(value);
    });

    return result;
  }

}