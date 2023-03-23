import 'package:sep_app/app_mode.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/report_model.dart';
import 'package:sep_app/services/db_service/reports_db_service/fake_reports_db_service.dart';
import 'package:sep_app/services/db_service/reports_db_service/reports_db_service.dart';
import 'package:sep_app/services/db_service/reports_db_service/reports_db_service_base.dart';

class ReportsRepository extends ReportsDbServiceBase {
  final _service = locator<ReportsDbService>();
  final _fakeService = locator<FakeReportsDbService>();

  final _app = locator<App>();

  @override
  Future<ReportModel> getReport(String reportId) {
    if (_app.isReleaseMode) {
      return _service.getReport(reportId);
    } else {
      return _fakeService.getReport(reportId);
    }
  }

  @override
  Future<List<ReportModel>> getReportsByDoctorId(String doctorId) {
    if (_app.isReleaseMode) {
      return _service.getReportsByDoctorId(doctorId);
    } else {
      return _fakeService.getReportsByDoctorId(doctorId);
    }
  }

  @override
  Future<List<ReportModel>> getReportsByPatientId(String patientId) {
    if (_app.isReleaseMode) {
      return _service.getReportsByPatientId(patientId);
    } else {
      return _fakeService.getReportsByPatientId(patientId);
    }
  }

  @override
  Future<bool> updateReport(String reportId, ReportModel updatedVersion) {
    if (_app.isReleaseMode) {
      return _service.updateReport(reportId, updatedVersion);
    } else {
      return _fakeService.updateReport(reportId, updatedVersion);
    }
  }
}
