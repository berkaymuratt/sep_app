import 'package:flutter/material.dart';
import 'package:sep_app/app/shared/view_models/view_model_base.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/repositories/db/appointments_repository.dart';

class AppointmentsPageViewModel extends ViewModelBase {
  final AppointmentsRepository _appointmentsRepository = locator<AppointmentsRepository>();

  List<AppointmentModel>? appointments;

  Future<List<AppointmentModel>?> getAppointments(String patientId) async {
    try {
      state = ViewState.BUSY;
      appointments = await _appointmentsRepository.getAppointmentsByPatientId(patientId);
      return appointments;
    } catch (e) {
      appointments = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  // TODO: implement isStateLoading
  bool get isStateLoading => appointments == null || super.isStateLoading;
}