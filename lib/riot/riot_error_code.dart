class RiotError {
  static String getErrorText(int code_) {
    switch (code_) {
      case 0:
        return "이름이 올바르지 않습니다";
      case 403 :
        return "Riot Api와 연결 할 수 없습니다(403)";
      case 404 :
        return "유저를 찾을 수 없습니다";
      case 405:
        return "405 Method not allowed";
      case 415:
        return "415 Unsupported media type";
      case 429 :
        return "요청 한도 초과";
      case 500 :
        return "500 Internal server error";
      case 502 :
        return "502 Bad gateway";
      case 503 :
        return "Riot Api와 연결 할 수 없습니다";
      case 504 :
        return "504 Gateway timeout";
      case 600:
        return "인터넷 연결이 불안정 합니다";
      default :
        return "오류";
    }
  }
}