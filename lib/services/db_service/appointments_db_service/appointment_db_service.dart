import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/services/db_service/appointments_db_service/appointments_db_service_base.dart';

class AppointmentDbService extends AppointmentsDbServiceBase {
  @override
  Future<AppointmentModel> getAppointment(String appointmentId) {
    // TODO: implement getAppointment
    throw UnimplementedError();
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByDoctorId(String doctorId) {
    // TODO: implement getAppointmentsByDoctorId
    throw UnimplementedError();
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByPatientId(String patientId) {
    // TODO: implement getAppointmentsByPatientId
    throw UnimplementedError();
  }

  @override
  Future<bool> updateAppointment(String appointmentId, AppointmentModel updatedVersion) {
    // TODO: implement updateAppointment
    throw UnimplementedError();
  }

}