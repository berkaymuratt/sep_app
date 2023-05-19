import 'package:dio/dio.dart';
import 'package:sep_app/ApiUrl.dart';
import 'package:sep_app/jwt_manager.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/services/db_service/appointments_db_service/appointments_db_service_base.dart';

class AppointmentDbService extends AppointmentsDbServiceBase {

  Dio dio = Dio();
  String baseUrl = locator<ApiUrl>().url;

  @override
  Future<AppointmentModel> getAppointment(String appointmentId) async {
    try {
      final response = await dio.get(
          '$baseUrl/appointments/$appointmentId',
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'jwt': locator<JwtManager>().jwtToken,
            },
          ),
      );

      return AppointmentModel.fromJSON(response.data);
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
  Future<List<AppointmentModel>> getAppointmentsByDoctorId(String doctorId) {
    // TODO: implement getAppointmentsByDoctorId
    throw UnimplementedError();
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByPatientId(String patientId) async {
    try {
      final response = await dio.get(
        '$baseUrl/appointments',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'jwt': locator<JwtManager>().jwtToken,
          },
        ),
        queryParameters: {
          "patient_id": patientId,
        }
      );

      List<AppointmentModel> appointments = [];

      var appointmentsList = response.data['appointments'];

      if (appointmentsList == null) {
        return [];
      }

      for (Map<String, dynamic> appointmentJson in appointmentsList) {
        appointments.add(AppointmentModel.fromJSON(appointmentJson));
      }

      return appointments;
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
  Future<bool> createAppointment(AppointmentModel appointment) async {
    try {
      final response = await dio.post(
        '$baseUrl/appointments/',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'jwt': locator<JwtManager>().jwtToken,
          },
        ),
        data: appointment.toJSON(),
      );

     return response.statusCode == 201;
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