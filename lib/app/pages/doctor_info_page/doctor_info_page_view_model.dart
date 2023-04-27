import 'package:flutter/cupertino.dart';
import 'package:sep_app/app/shared/view_models/view_model_base.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/repositores/db/doctors_repository.dart';

class DoctorInfoPageViewModel extends ViewModelBase {
  final DoctorsRepository _doctorsRepository = locator<DoctorsRepository>();

  DoctorModel? doctor;

  Future<DoctorModel?> getDoctor(String doctorId) async {
    try {
      state = ViewState.BUSY;
      doctor = await _doctorsRepository.getDoctor(doctorId);
      return doctor;
    } catch(e) {
      doctor = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  bool get isStateLoading => doctor == null || super.isStateLoading;
}