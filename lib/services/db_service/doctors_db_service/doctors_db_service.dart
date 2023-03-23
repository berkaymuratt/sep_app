import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/services/db_service/doctors_db_service/doctors_db_service_base.dart';

class DoctorsDbService extends DoctorsDbServiceBase {
  @override
  Future<DoctorModel> getDoctor(String doctorId) {
    // TODO: implement getDoctor
    throw UnimplementedError();
  }

  @override
  Future<DoctorModel> getDoctorByPatientId(String patientId) {
    // TODO: implement getDoctorByPatientId
    throw UnimplementedError();
  }

  @override
  Future<bool> updateDoctor(String doctorId, DoctorModel updatedVersion) {
    // TODO: implement updateDoctor
    throw UnimplementedError();
  }

}