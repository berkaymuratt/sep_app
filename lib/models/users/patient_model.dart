import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/models/report_model.dart';
import 'package:sep_app/models/users/user_info/doctor_info_model.dart';
import 'package:sep_app/models/users/user_info/patient_info_model.dart';
import 'package:sep_app/models/users/user_model.dart';

class PatientModel extends UserModel {
  PatientInfoModel patientInfo;
  DoctorInfoModel doctorInfo;

  PatientModel({
    required super.id,
    required super.userId,
    required this.doctorInfo,
    required this.patientInfo,
    required super.reports,
    required super.appointments,
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
      patientInfo: PatientInfoModel.fromJSON(json['patient_info']),
      doctorInfo: DoctorInfoModel.fromJSON(json['doctor_info']),
      reports: reportsList,
      appointments: appointmentsList,
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
      appointmentsJSON.add(appointment.toJSON());
    }

    return {
      "id": id,
      "user_id": userId,
      "patient_info": patientInfo.toJSON(),
      "doctor_info": doctorInfo.toJSON(),
      "reports": reportsJSON,
      "appointments": appointmentsJSON,
    };
  }
}
