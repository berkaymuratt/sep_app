import 'package:flutter/cupertino.dart';

class JwtManager {
  String _jwtToken = "";

  String get jwtToken => _jwtToken;

  set jwtToken(String newToken) {
    _jwtToken = newToken;
    debugPrint("User is logged in");
  }

  void clearToken() {
    _jwtToken = "";
  }

  JwtManager() {
    // Check storage, igf token exists, log in
  }
}