class NetworkConstant {
  static const String BASE_URL =
      'http://192.168.0.82:15000/gemvaxlinkAPI-0.0.1-BUILD-SNAPSHOT/';

  // static const String BASE_URL = 'https://esign.gemvaxlink.com/';
  static const int TIMEOUT = 10000;

  static const int SUCCESS = 0;
  static const int ERROR_COMMON = 1;
  static const int ERROR_LOGIN = 3;
  static const int ERROR_UNKNOWN = 99;
  static const int ERROR_NOT_REGISTERED_USER = 100;
  static const int ERROR_PASSWORD_MISMATCH = 101;
  static const int ERROR_INVALID_DATA = 110;
  static const int ERROR_EMPTY_SIGN = 111;
  static const int ERROR_HEADER = 300;
  static const int ERROR_FILE_UPLOAD = 400;
  static const int ERROR_FILE_DOWNLOAD = 401;
  static const int ERROR_DATABASE = 501;
  static const int ERROR_ACCESS = 8000;
  static const int SERVER_MAINTENANCE = 9000;
}
