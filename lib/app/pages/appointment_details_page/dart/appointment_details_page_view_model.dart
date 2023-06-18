import 'package:flutter/material.dart';
import 'package:sep_app/app/shared/view_models/view_model_base.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/repositories/db/appointments_repository.dart';

class AppointmentDetailsPageViewModel extends ViewModelBase {
  final AppointmentsRepository _appointmentsRepository = locator<AppointmentsRepository>();

  AppointmentModel? appointment;

  Future<AppointmentModel?> getAppointment(String appointmentId) async {
    try {
      state = ViewState.BUSY;
      appointment = await _appointmentsRepository.getAppointment(appointmentId);
      return appointment;
    } catch (e) {
      appointment = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  Future<bool> cancelAppointment(String appointmentId) async {
    try {
      state = ViewState.BUSY;
      final bool result = await _appointmentsRepository.cancelAppointment(appointmentId);
      return result;
    } catch (e) {
      appointment = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return false;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  bool get isStateLoading =>  appointment == null || super.isStateLoading;
}