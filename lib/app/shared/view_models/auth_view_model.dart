import 'package:sep_app/app/shared/view_models/view_model_base.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/repositores/auth/auth_repository.dart';

class AuthViewModel extends ViewModelBase {
  final AuthRepository _authRepository = locator<AuthRepository>();

  PatientModel? patientUser;
  DoctorModel? doctorUser;

  Future<DoctorModel?> loginAsDoctor(String userId, String password) async {
    try {
      state = ViewState.BUSY;
      doctorUser = await _authRepository.loginAsDoctor(userId, password);
      return doctorUser;
    } catch (e) {
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.BUSY;
    }
  }

  Future<PatientModel?> loginAsPatient(String userId, String password) async {
    try {
      state = ViewState.BUSY;
      patientUser = await _authRepository.loginAsPatient(userId, password);
      return patientUser;
    } catch (e) {
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.BUSY;
    }
  }

  Future<bool> signOut() async {
    try {
      state = ViewState.BUSY;
      _authRepository.signOut();
      patientUser = null;
      doctorUser = null;
      return true;
    } catch (e) {
      errorMsg = e.toString();
      return false;
    } finally {
      state = ViewState.IDLE;
    }
  }
}
