import 'package:sep_app/models/users/patient_model.dart';

abstract class PatientsDbServiceBase {
  Future<PatientModel> getPatient(String patientId);
  Future<List<PatientModel>> getPatientsByDoctorId(String doctorId);
  Future<bool> updatePatient(String patientId, PatientModel updatedVersion);
}