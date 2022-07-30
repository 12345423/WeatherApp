class Endpoints {
  Endpoints._();

  // base url
static const String baseUrl = "http://192.168.0.108:8000/api/v1";
  // receiveTimeout
  static const int receiveTimeout = 20000;

  // connectTimeout
  static const int connectionTimeout = 20000;

  static const String auth = '/auth';
  static const String tempat = '/tempat';
}
