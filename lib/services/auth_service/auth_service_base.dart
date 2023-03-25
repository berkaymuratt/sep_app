import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/models/users/patient_model.dart';

abstract class AuthServiceBase {
  Future<PatientModel> loginAsPatient(String userId, String password);
  Future<DoctorModel> loginAsDoctor(String userId, String password);
  Future<void> signOut();
}