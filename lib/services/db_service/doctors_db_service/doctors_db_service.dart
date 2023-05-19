import 'package:dio/dio.dart';
import 'package:sep_app/jwt_manager.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/services/db_service/doctors_db_service/doctors_db_service_base.dart';

class DoctorsDbService extends DoctorsDbServiceBase {
  final Dio dio = Dio();

  @override
  Future<DoctorModel> getDoctor(String doctorId) async {
    try {
      final response = await dio.get(
        'http://localhost:8080/api/doctors/$doctorId',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'jwt': locator<JwtManager>().jwtToken,
          },
        ),
      );
      return DoctorModel.fromJSON(response.data);
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

  @override
  Future<DoctorModel> getDoctorByPatientId(String patientId) {
    // TODO: implement getDoctorByPatientId
    throw UnimplementedError();
  }

  @override
  Future<bool> updateDoctor(String doctorId, DoctorModel updatedVersion) {
    // TODO: implement updateDoctor
    throw UnimplementedError();
  }

  @override
  Future<List<DateTime>> getBusyTimes(String doctorId, DateTime newDate) async {
    try {
      final response = await dio.get(
        'http://localhost:8080/api/doctors/$doctorId/busy-times',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'jwt': locator<JwtManager>().jwtToken,
          },
        ),
        queryParameters: {
          "date": "${newDate.toIso8601String()}Z",
        },
      );

      List<DateTime> busyTimes = [];

      var busyTimesList = response.data['busy_times'];

      if (busyTimesList == null) {
        return [];
      }

      for (String time in busyTimesList) {
        busyTimes.add(DateTime.parse(time));
      }

      return busyTimes;
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