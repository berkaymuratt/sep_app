import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/services/db_service/doctors_db_service/doctors_db_service_base.dart';

class FakeDoctorsDbService extends DoctorsDbServiceBase {
  DoctorModel? _fakeDoctor;

  FakeDoctorsDbService() {
    _loadData();
  }

  _loadData() async {
    final String jsonString =
        await rootBundle.loadString('dump_data/doctor_1.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _fakeDoctor = DoctorModel.fromJSON(jsonMap);
  }

  @override
  Future<DoctorModel> getDoctor(String doctorId) async {
    await _loadData();

    if (_fakeDoctor != null) {
      return _fakeDoctor!;
    } else {
      throw Exception("Doctor cannot found");
    }
  }

  @override
  Future<DoctorModel> getDoctorByPatientId(String patientId) async {
    try {
      await _loadData();

      if (_fakeDoctor != null) {
        return _fakeDoctor!;
      } else {
        throw Exception("Doctor cannout found");
      }
    } catch(e) {
      throw Exception("Doctors DB Error: $e");
    }
  }

  @override
  Future<bool> updateDoctor(String doctorId, DoctorModel updatedVersion) async {
    return true;
  }
}
