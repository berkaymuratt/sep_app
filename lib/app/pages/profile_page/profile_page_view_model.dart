import 'package:flutter/material.dart';
import 'package:sep_app/app/shared/view_models/view_model_base.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/repositories/db/patients_repository.dart';

class ProfilePageViewModel extends ViewModelBase {

  final PatientsRepository _patientsRepository = locator<PatientsRepository>();

  Future<bool> updatePatient(PatientModel updatedPatient) async {
    try {
      state = ViewState.BUSY;
      final bool result = await _patientsRepository.updatePatient(updatedPatient.id, updatedPatient);
      return result;
    } catch(e) {
      debugPrint(e.toString());
      errorMsg = e.toString();
      return false;
    } finally {
      state = ViewState.IDLE;
    }
  }
}