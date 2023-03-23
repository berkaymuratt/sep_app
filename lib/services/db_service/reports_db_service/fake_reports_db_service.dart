import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:sep_app/models/report_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/services/db_service/reports_db_service/reports_db_service_base.dart';


class FakeReportsDbService extends ReportsDbServiceBase {
  ReportModel? _fakeReport;

  _loadData() async {
    final String jsonString =
        await rootBundle.loadString('dump_data/patient_1.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _fakeReport = PatientModel.fromJSON(jsonMap).reports[0];
  }

  @override
  Future<ReportModel> getReport(String reportId) async {
    await _loadData();

    if (_fakeReport != null) {
      return _fakeReport!;
    } else {
      throw Exception("Report cannot found");
    }
  }

  @override
  Future<List<ReportModel>> getReportsByPatientId(String patientId)async {
    try {
      await _loadData();

      List<ReportModel> reports = [];

      for (int i = 0; i < 10; i++) {
        reports.add(ReportModel.fromJSON(_fakeReport!.toJSON()));
      }

      return reports;
    } on Exception catch (e) {
      throw Exception("Reports DB Exception: $e");
    }
  }

  @override
  Future<List<ReportModel>> getReportsByDoctorId(String doctorId)async {
    try {
      await _loadData();

      List<ReportModel> reports = [];

      for (int i = 0; i < 10; i++) {
        reports.add(ReportModel.fromJSON(_fakeReport!.toJSON()));
      }

      return reports;
    } on Exception catch (e) {
      throw Exception("Reports DB Exception: $e");
    }
  }

  @override
  Future<bool> updateReport(String reportId, ReportModel updatedVersion) async {
    return true;
  }
}
