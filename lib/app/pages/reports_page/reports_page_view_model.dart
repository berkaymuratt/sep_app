import 'package:flutter/material.dart';
import 'package:sep_app/app/shared/view_models/view_model_base.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/report_model.dart';
import 'package:sep_app/repositores/db/reports_repository.dart';

class ReportsPageViewModel extends ViewModelBase {
  final ReportsRepository _reportsRepository = locator<ReportsRepository>();

  List<ReportModel>? reports = [];

  Future<List<ReportModel>?> getReportsByPatientId(String patientId) async {
    try {
      state = ViewState.BUSY;
      reports = await _reportsRepository.getReportsByPatientId(patientId);
      return reports;
    } catch (e) {
      reports = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  bool get isStateLoading => super.isStateLoading || reports == null;
}