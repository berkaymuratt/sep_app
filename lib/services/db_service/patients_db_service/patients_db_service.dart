import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/services/db_service/patients_db_service/patients_db_service_base.dart';

class PatientsDbService extends PatientsDbServiceBase {
  @override
  Future<PatientModel> getPatient(String patientId) {
    // TODO: implement getPatient
    throw UnimplementedError();
  }

  @override
  Future<List<PatientModel>> getPatientsByDoctorId(String doctorId) {
    // TODO: implement getPatients
    throw UnimplementedError();
  }

  @override
  Future<bool> updatePatient(String patientId, PatientModel updatedVersion) {
    // TODO: implement updatePatient
    throw UnimplementedError();
  }

}