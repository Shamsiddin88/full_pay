class AppConstants {
  static  RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static  RegExp passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  static  RegExp textRegExp = RegExp("[a-zA-Z]");
  static  RegExp phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  static  RegExp number = RegExp(r'(^[0-9]+$)');

  static String users = "users";
  static String cards = "cards";
  static String cardsDatabase = "cards_database";
  static String pinCode = "pin_code";
  static String biometricsEnabled = "biometrics_enabled";
}