import 'package:sep_app/app_mode.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/services/db_service/doctors_db_service/doctors_db_service.dart';
import 'package:sep_app/services/db_service/doctors_db_service/doctors_db_service_base.dart';
import 'package:sep_app/services/db_service/doctors_db_service/fake_doctors_db_service.dart';

class DoctorsRepository extends DoctorsDbServiceBase {

  final DoctorsDbServiceBase _service = locator<DoctorsDbService>();
  final FakeDoctorsDbService _fakeService = locator<FakeDoctorsDbService>();

  final App app = locator<App>();

  @override
  Future<DoctorModel> getDoctor(String doctorId) {
    if (app.isReleaseMode) {
      return _service.getDoctor(doctorId);
    } else {
      return _fakeService.getDoctor(doctorId);
    }
  }

  @override
  Future<DoctorModel> getDoctorByPatientId(String patientId) {
    if (app.isReleaseMode) {
      return _service.getDoctorByPatientId(patientId);
    } else {
      return _fakeService.getDoctorByPatientId(patientId);
    }
  }

  @override
  Future<bool> updateDoctor(String doctorId, DoctorModel updatedVersion) {
    if (app.isReleaseMode) {
      return _service.updateDoctor(doctorId, updatedVersion);
    } else {
      return _fakeService.updateDoctor(doctorId, updatedVersion);
    }
  }

}