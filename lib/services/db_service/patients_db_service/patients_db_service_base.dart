import 'package:sep_app/models/users/patient_model.dart';

abstract class PatientsDbServiceBase {
  Future<bool> updatePatient(String patientId, PatientModel updatedVersion);
}