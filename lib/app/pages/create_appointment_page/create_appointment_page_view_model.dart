import 'package:flutter/material.dart';
import 'package:sep_app/app/shared/view_models/view_model_base.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/models/symptom_model.dart';
import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/repositories/db/appointments_repository.dart';

class CreateAppointmentPageViewModel extends ViewModelBase {
  final AppointmentsRepository _appointmentsRepository = locator<AppointmentsRepository>();

  List<SymptomModel> selectedSymptoms = [];
  DateTime? _selectedDate;
  String patientNote = "";

  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  void addSelectedSymptom(SymptomModel symptom) {
    selectedSymptoms.add(symptom);
    notifyListeners();
  }

  void removeSelectedSymptom(SymptomModel symptom) {
    selectedSymptoms.remove(symptom);
    notifyListeners();
  }

  Future<bool> createAppointment(String patientId, String doctorId) async {
    try {
      state = ViewState.BUSY;

      AppointmentModel newAppointment = AppointmentModel.empty();
      newAppointment.patient = PatientModel.empty();
      newAppointment.doctor = DoctorModel.empty();

      newAppointment.doctor!.id = doctorId;
      newAppointment.patient!.id = patientId;
      newAppointment.date = selectedDate;
      newAppointment.symptoms = selectedSymptoms;
      newAppointment.patientNote = patientNote;

      await _appointmentsRepository.createAppointment(newAppointment);
      return true;
    } catch(e) {
      debugPrint(e.toString());
      errorMsg = e.toString();
      return false;
    } finally {
      state = ViewState.IDLE;
    }
  }
}