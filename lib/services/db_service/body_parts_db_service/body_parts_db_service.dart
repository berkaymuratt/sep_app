import 'package:dio/dio.dart';
import 'package:sep_app/jwt_manager.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/body_part_model.dart';
import 'package:sep_app/services/db_service/body_parts_db_service/body_parts_db_service_base.dart';

class BodyPartsDbService extends BodyPartsDbServiceBase {
  final Dio dio = Dio();

  @override
  Future<List<BodyPartModel>> getBodyParts() async {
    try {
      final response = await dio.get(
          'http://localhost:8080/api/body-parts',
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'jwt': locator<JwtManager>().jwtToken,
            },
          ),
      );

      List<BodyPartModel> bodyParts = [];

      var bodyPartsList = response.data['body_parts'];

      if (bodyPartsList == null) {
        return [];
      }

      for (Map<String, dynamic> bodyPartJson in bodyPartsList) {
        bodyParts.add(BodyPartModel.fromJSON(bodyPartJson));
      }
      return bodyParts;
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