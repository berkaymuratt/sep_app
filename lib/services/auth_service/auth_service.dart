import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/services/auth_service/auth_service_base.dart';

class AuthService extends AuthServiceBase {
  @override
  Future<DoctorModel> loginAsDoctor(String userId, String password) {
    // TODO: implement loginAsDoctor
    throw UnimplementedError();
  }

  @override
  Future<PatientModel> loginAsPatient(String userId, String password) {
    // TODO: implement loginAsPatient
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

}