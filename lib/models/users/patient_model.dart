import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/models/report_model.dart';
import 'package:sep_app/models/user_info_model.dart';
import 'package:sep_app/models/users/user_model.dart';

class PatientModel extends UserModel {
  UserInfoModel doctorInfo;

  PatientModel({
    required super.id,
    required super.userId,
    required super.userInfo,
    required super.reports,
    required super.appointments,
    required this.doctorInfo,
  });

  factory PatientModel.fromJSON(Map<String, dynamic> json) {
    // Convert json reports to reports
    List<ReportModel> reportsList = [];

    for (Map<String, dynamic> reportJSON in json['reports']) {
      reportsList.add(ReportModel.fromJSON(reportJSON));
    }

    // Convert json appointments to appointments
    List<AppointmentModel> appointmentsList = [];

    for (Map<String, dynamic> appointmentJSON in json['appointments']) {
      appointmentsList.add(AppointmentModel.fromJSON(appointmentJSON));
    }

    return PatientModel(
      id: json['id'],
      userId: json['user_id'],
      userInfo: UserInfoModel.fromJSON(json['user_info']),
      reports: reportsList,
      appointments: appointmentsList,
      doctorInfo: UserInfoModel.fromJSON(json['doctor_info']),
    );
  }

  Map<String, dynamic> toJSON() {
    // Convert reports list to json list
    List<Map<String, dynamic>> reportsJSON = [];

    for (ReportModel report in reports) {
      reportsJSON.add(report.toJSON());
    }

    // Convert appointment list to json list
    List<Map<String, dynamic>> appointmentsJSON = [];

    for (AppointmentModel appointment in appointments) {
      reportsJSON.add(appointment.toJSON());
    }

    return {
      "id": id,
      "user_id": userId,
      "user_info": userInfo.toJSON(),
      "doctor_info": doctorInfo.toJSON(),
      "reports": reportsJSON,
      "appointments": appointmentsJSON,
    };
  }
}
