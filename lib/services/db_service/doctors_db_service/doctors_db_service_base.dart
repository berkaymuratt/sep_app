import 'package:sep_app/models/users/doctor_model.dart';

abstract class DoctorsDbServiceBase {
  Future<DoctorModel> getDoctor(String doctorId);
  Future<DoctorModel> getDoctorByPatientId(String patientId);
  Future<bool> updateDoctor(String doctorId, DoctorModel updatedVersion);
}