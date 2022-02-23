class Debug{
  static bool _debugMode = false;

  static void log(String content){
    if(_debugMode == true)
      print(content);
  }

  static void logError(String content){
    if(_debugMode == true)
      print(content);
  }

  static void setDebugMode(bool value){
    _debugMode = value;
  }

  static bool getDebugMode(){
    return _debugMode;
  }
}