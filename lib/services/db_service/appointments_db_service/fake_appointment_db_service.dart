import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/services/db_service/appointments_db_service/appointments_db_service_base.dart';

class FakeAppointmentDbService extends AppointmentsDbServiceBase {

  AppointmentModel? _fakeAppointment;

  _loadData() async {
    final String jsonString =
    await rootBundle.loadString('dump_data/patient_1.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _fakeAppointment = PatientModel.fromJSON(jsonMap).appointments[0];
  }

  @override
  Future<AppointmentModel> getAppointment(String appointmentId) async {
    await _loadData();

    if (_fakeAppointment != null) {
      return _fakeAppointment!;
    } else {
      throw Exception("Appointment cannot found");
    }
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByDoctorId(String doctorId) async {
    try {
      await _loadData();

      List<AppointmentModel> appointmentsList = [];

      if (_fakeAppointment != null) {
        for (int i=0; i<10; i++) {
          appointmentsList.add(AppointmentModel.fromJSON(_fakeAppointment!.toJSON()));
        }
      }

      return appointmentsList;

    } catch(e) {
      throw Exception("Appointments DB Exception: $e");
    }
  }

  @override
  Future<List<AppointmentModel>> getAppointmentsByPatientId(String patientId) async {
    try {
      await _loadData();

      List<AppointmentModel> appointmentsList = [];

      if (_fakeAppointment != null) {
        for (int i=0; i<10; i++) {
          appointmentsList.add(AppointmentModel.fromJSON(_fakeAppointment!.toJSON()));
        }
      }

      return appointmentsList;

    } catch(e) {
      throw Exception("Appointments DB Exception: $e");
    }
  }

  @override
  Future<bool> updateAppointment(String appointmentId, AppointmentModel updatedVersion) async {
    return true;
  }

}