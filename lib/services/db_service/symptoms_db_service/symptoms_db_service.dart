import 'package:dio/dio.dart';
import 'package:sep_app/jwt_manager.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/symptom_model.dart';
import 'package:sep_app/services/db_service/symptoms_db_service/symptoms_db_service_base.dart';

class SymptomsDbService extends SymptomsDbServiceBase {
  final Dio dio = Dio();

  @override
  Future<List<SymptomModel>> getSymptoms(String bodyPartId) async {
    try {
      final response = await dio.get(
        'http://localhost:8080/api/symptoms',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'jwt': locator<JwtManager>().jwtToken,
          },
        ),
        queryParameters: {'body_part_id': bodyPartId}
      );

      List<SymptomModel> symptoms = [];

      var symptomsList = response.data['symptoms'];

      if (symptomsList == null) {
        return [];
      }

      for (Map<String, dynamic> symptomJson in symptomsList) {
        symptoms.add(SymptomModel.fromJSON(symptomJson));
      }
      return symptoms;
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