import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:sep_app/jwt_manager.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/services/auth_service/auth_service_base.dart';

class FakeAuthService extends AuthServiceBase {

  final JwtManager _jwtManager = locator<JwtManager>();

  @override
  Future<DoctorModel> loginAsDoctor(String userId, String password) async {
    const String fakeToken = "Jdh23n52nm3532nbewkfjbk235";
    _jwtManager.jwtToken = fakeToken;

    final String jsonString =
    await rootBundle.loadString('dump_data/doctor_1.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final fakeDoctor = DoctorModel.fromJSON(jsonMap);

    return fakeDoctor;
  }

  @override
  Future<PatientModel> loginAsPatient(String userId, String password) async {
    const String fakeToken = "Jdh23n45nnflk3n4klndomf";
    _jwtManager.jwtToken = fakeToken;

    final String jsonString =
    await rootBundle.loadString('dump_data/patient_1.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    final fakeDoctor = PatientModel.fromJSON(jsonMap);

    return fakeDoctor;
  }

  @override
  Future<void> signOut() async {
    _jwtManager.clearToken();
  }

}