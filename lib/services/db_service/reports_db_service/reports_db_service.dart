import 'package:sep_app/models/report_model.dart';
import 'package:sep_app/services/db_service/reports_db_service/reports_db_service_base.dart';

class ReportsDbService extends ReportsDbServiceBase {
  @override
  Future<ReportModel> getReport(String reportId) {
    // TODO: implement getReport
    throw UnimplementedError();
  }

  @override
  Future<List<ReportModel>> getReportsByDoctorId(String doctorId) {
    // TODO: implement getReportsByDoctorId
    throw UnimplementedError();
  }

  @override
  Future<List<ReportModel>> getReportsByPatientId(String patientId) {
    // TODO: implement getReportsByPatientId
    throw UnimplementedError();
  }

  @override
  Future<bool> updateReport(String reportId, ReportModel updatedVersion) {
    // TODO: implement updateReport
    throw UnimplementedError();
  }
}
