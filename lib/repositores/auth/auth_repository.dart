import 'package:sep_app/app_mode.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/services/auth_service/auth_service.dart';
import 'package:sep_app/services/auth_service/auth_service_base.dart';
import 'package:sep_app/services/auth_service/fake_auth_service.dart';

class AuthRepository extends AuthServiceBase {

  final AuthService _service = locator<AuthService>();
  final FakeAuthService _fakeService = locator<FakeAuthService>();

  final App _app = locator<App>();

  @override
  Future<DoctorModel> loginAsDoctor(String userId, String password) {
    if (_app.isReleaseMode) {
      return _service.loginAsDoctor(userId, password);
    } else {
      return _fakeService.loginAsDoctor(userId, password);
    }
  }

  @override
  Future<PatientModel> loginAsPatient(String userId, String password) {
    if (_app.isReleaseMode) {
      return _service.loginAsPatient(userId, password);
    } else {
      return _fakeService.loginAsPatient(userId, password);
    }
  }

  @override
  Future<void> signOut() {
    if (_app.isReleaseMode) {
      return _service.signOut();
    } else {
      return _fakeService.signOut();
    }
  }

}