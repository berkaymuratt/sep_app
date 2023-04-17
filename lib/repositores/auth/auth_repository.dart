import 'package:sep_app/locator.dart';
import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/services/auth_service/auth_service.dart';
import 'package:sep_app/services/auth_service/auth_service_base.dart';

class AuthRepository extends AuthServiceBase {

  final AuthService _service = locator<AuthService>();

  @override
  Future<DoctorModel> loginAsDoctor(String userId, String password) {
    return _service.loginAsDoctor(userId, password);
  }

  @override
  Future<PatientModel> loginAsPatient(String userId, String password) {
    return _service.loginAsPatient(userId, password);
  }

  @override
  Future<void> signOut() {
    return _service.signOut();
  }

}