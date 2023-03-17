import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/models/report_model.dart';
import 'package:sep_app/models/user_info_model.dart';
import 'package:sep_app/models/users/user_model.dart';

class DoctorModel extends UserModel {
  List<PatientModel> patients;

  DoctorModel({
    required super.id,
    required super.userId,
    required super.userInfo,
    required super.reports,
    required super.appointments,
    required this.patients,
  });

  factory DoctorModel.fromJSON(Map<String, dynamic> json) {
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

    // Convert json patients to patients
    List<PatientModel> patientsList = [];

    for (Map<String, dynamic> patientJSON in json['patients']) {
      patientsList.add(PatientModel.fromJSON(patientJSON));
    }

    return DoctorModel(
      id: json['id'],
      userId: json['user_id'],
      userInfo: UserInfoModel.fromJSON(json['user_info']),
      reports: reportsList,
      appointments: appointmentsList,
      patients: patientsList,
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

    // Convert patients list to json list
    List<Map<String, dynamic>> patientsJSON = [];

    for (PatientModel patient in patients) {
      patientsJSON.add(patient.toJSON());
    }

    return {
      "id": id,
      "user_id": userId,
      "user_info": userInfo.toJSON(),
      "reports": reportsJSON,
      "appointments": appointmentsJSON,
      "patients": patientsJSON,
    };
  }
}
