import 'dart:io';

class ApiUrl {
  late String url;

  ApiUrl() {
    if (!Platform.isAndroid) {
      url = "http://localhost:8080/api";
    } else {
      url = "http://10.0.2.2:8080/api";
    }
  }
}