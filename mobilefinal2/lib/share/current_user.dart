class CurrentUser {
  static var USERID;
  static var NAME;
  static var AGE;
  static var PASSWORD;

  static String whoCurrent() {
    return "current -> userid: ${USERID}, name: ${NAME},age: ${AGE}, password: ${PASSWORD}";
  }
}