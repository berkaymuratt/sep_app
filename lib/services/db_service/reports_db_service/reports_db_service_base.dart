import 'package:sep_app/models/report_model.dart';

abstract class ReportsDbServiceBase {
  Future<List<ReportModel>> getReportsByPatientId(String patientId);
  Future<List<ReportModel>> getReportsByDoctorId(String doctorId);
  Future<ReportModel> getReport(String reportId);
  Future<bool> updateReport(String reportId, ReportModel updatedVersion);
}
