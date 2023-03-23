import 'package:sep_app/app_mode.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/services/db_service/patients_db_service/fake_patients_db_service.dart';
import 'package:sep_app/services/db_service/patients_db_service/patients_db_service.dart';
import 'package:sep_app/services/db_service/patients_db_service/patients_db_service_base.dart';

class PatientsRepository extends PatientsDbServiceBase {

  final PatientsDbService _service = locator<PatientsDbService>();
  final FakePatientsDbService _fakeService = locator<FakePatientsDbService>();

  final App app = locator<App>();

  @override
  Future<PatientModel> getPatient(String patientId) {
    if (app.isReleaseMode) {
      return _service.getPatient(patientId);
    } else {
      return _fakeService.getPatient(patientId);
    }
  }

  @override
  Future<List<PatientModel>> getPatientsByDoctorId(String doctorId) {
    if (app.isReleaseMode) {
      return _service.getPatientsByDoctorId(doctorId);
    } else {
      return _fakeService.getPatientsByDoctorId(doctorId);
    }
  }

  @override
  Future<bool> updatePatient(String patientId, PatientModel updatedVersion) {
    if (app.isReleaseMode) {
      return _service.updatePatient(patientId, updatedVersion);
    } else {
      return _service.updatePatient(patientId, updatedVersion);
    }
  }

}