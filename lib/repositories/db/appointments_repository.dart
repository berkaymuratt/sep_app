import 'package:sep_app/locator.dart';
import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/services/db_service/appointments_db_service/appointment_db_service.dart';
import 'package:sep_app/services/db_service/appointments_db_service/appointments_db_service_base.dart';

class AppointmentsRepository extends AppointmentsDbServiceBase {

  final AppointmentDbService _service = locator<AppointmentDbService>();

  @override
  Future<AppointmentModel> getAppointment(String appointmentId) {
    return _service.getAppointment(appointmentId);
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByDoctorId(String doctorId) {
    return _service.getAppointmentsByDoctorId(doctorId);
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByPatientId(String patientId) {
    return _service.getAppointmentsByPatientId(patientId);
  }

  @override
  Future<bool> createAppointment(AppointmentModel appointment) {
    return _service.createAppointment(appointment);
  }

}