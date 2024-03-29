import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:sep_app/ApiUrl.dart';
import 'package:sep_app/jwt_manager.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/services/auth_service/auth_service_base.dart';

class AuthService extends AuthServiceBase {
  final Dio dio = Dio();
  final jwtManager = locator<JwtManager>();
  String baseUrl = locator<ApiUrl>().url;

  @override
  Future<PatientModel> loginAsPatient(String userId, String password) async {
    try {
      final response =
      await dio.post('$baseUrl/auth/login-as-patient',
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
          ),
          queryParameters: {
            "user_id": userId,
            "user_password": password,
          });

      var token = response.data['sep-token'];
      jwtManager.jwtToken = token;

      return PatientModel.fromJSON(response.data['patient']);
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception("Bir hata oluştu");
      }
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

}