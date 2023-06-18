import 'package:sep_app/locator.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/services/db_service/patients_db_service/patients_db_service.dart';
import 'package:sep_app/services/db_service/patients_db_service/patients_db_service_base.dart';

class PatientsRepository extends PatientsDbServiceBase {

  final PatientsDbService _service = locator<PatientsDbService>();

  @override
  Future<bool> updatePatient(String patientId, PatientModel updatedVersion) {
    return _service.updatePatient(patientId, updatedVersion);
  }

}