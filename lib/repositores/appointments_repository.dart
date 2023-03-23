import 'package:sep_app/app_mode.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/services/db_service/appointments_db_service/appointment_db_service.dart';
import 'package:sep_app/services/db_service/appointments_db_service/appointments_db_service_base.dart';
import 'package:sep_app/services/db_service/appointments_db_service/fake_appointment_db_service.dart';

class AppointmentsRepository extends AppointmentsDbServiceBase {

  final AppointmentDbService _service = locator<AppointmentDbService>();
  final FakeAppointmentDbService _fakeService = locator<FakeAppointmentDbService>();

  final App _app = locator<App>();

  @override
  Future<AppointmentModel> getAppointment(String appointmentId) {
    if (_app.isReleaseMode) {
      return _service.getAppointment(appointmentId);
    } else {
      return _fakeService.getAppointment(appointmentId);
    }
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByDoctorId(String doctorId) {
    if (_app.isReleaseMode) {
      return _service.getAppointmentsByDoctorId(doctorId);
    } else {
      return _fakeService.getAppointmentsByDoctorId(doctorId);
    }
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByPatientId(String patientId) {
    if (_app.isReleaseMode) {
      return _service.getAppointmentsByPatientId(patientId);
    } else {
      return _fakeService.getAppointmentsByPatientId(patientId);
    }
  }

  @override
  Future<bool> updateAppointment(String appointmentId, AppointmentModel updatedVersion) {
    if (_app.isReleaseMode) {
      return _service.updateAppointment(appointmentId, updatedVersion);
    } else {
      return _service.updateAppointment(appointmentId, updatedVersion);
    }
  }

}