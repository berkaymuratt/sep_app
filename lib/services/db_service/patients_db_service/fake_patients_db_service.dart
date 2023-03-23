import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/services/db_service/patients_db_service/patients_db_service_base.dart';

class FakePatientsDbService extends PatientsDbServiceBase {
  PatientModel? _fakePatient;

  _loadData() async {
    final String jsonString =
        await rootBundle.loadString('dump_data/patient_1.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _fakePatient = PatientModel.fromJSON(jsonMap);
  }

  @override
  Future<PatientModel> getPatient(String patientId) async {
    await _loadData();

    if (_fakePatient != null) {
      return _fakePatient!;
    } else {
      throw Exception("Patient cannot found");
    }
  }

  @override
  Future<List<PatientModel>> getPatientsByDoctorId(String doctorId) async {
    try {
      await _loadData();

      List<PatientModel> patients = [];

      for (int i = 0; i < 10; i++) {
        patients.add(PatientModel.fromJSON(_fakePatient!.toJSON()));
      }

      return patients;
    } catch (e) {
      throw Exception("Patients DB Error: $e");
    }
  }

  @override
  Future<bool> updatePatient(
      String patientId, PatientModel updatedVersion) async {
    return true;
  }
}
