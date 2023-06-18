import 'package:dio/dio.dart';
import 'package:sep_app/ApiUrl.dart';
import 'package:sep_app/jwt_manager.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/services/db_service/patients_db_service/patients_db_service_base.dart';

class PatientsDbService extends PatientsDbServiceBase {
  final Dio dio = Dio();
  String baseUrl = locator<ApiUrl>().url;

  @override
  Future<bool> updatePatient(String patientId, PatientModel updatedVersion) async {
    try {
      final response = await dio.patch(
        '$baseUrl/patients/$patientId',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'jwt': locator<JwtManager>().jwtToken,
          },
        ),
        data: updatedVersion.toJSON(),
      );

      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          locator<JwtManager>().clearToken();
        }
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception("Bir hata oluştu");
      }
    }
  }

}