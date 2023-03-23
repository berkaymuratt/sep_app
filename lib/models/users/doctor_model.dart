import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/models/report_model.dart';
import 'package:sep_app/models/users/user_info/doctor_info_model.dart';
import 'package:sep_app/models/users/user_info/patient_info_model.dart';
import 'package:sep_app/models/users/user_model.dart';

class DoctorModel extends UserModel {

  DoctorInfoModel doctorInfo;
  List<PatientInfoModel> patientsInfo;

  DoctorModel({
    required super.id,
    required super.userId,
    required this.doctorInfo,
    required this.patientsInfo,
    required super.reports,
    required super.appointments,
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
    List<PatientInfoModel> patientsInfoList = [];

    for (Map<String, dynamic> patientJSON in json['patients_info']) {
      patientsInfoList.add(PatientInfoModel.fromJSON(patientJSON));
    }

    return DoctorModel(
      id: json['id'],
      userId: json['user_id'],
      doctorInfo: DoctorInfoModel.fromJSON(json['doctor_info']),
      patientsInfo: patientsInfoList,
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

    // Convert patients list to json list
    List<Map<String, dynamic>> patientsInfoJSON = [];

    for (PatientInfoModel patientInfo in patientsInfo) {
      patientsInfoJSON.add(patientInfo.toJSON());
    }

    return {
      "id": id,
      "user_id": userId,
      "doctor_info": doctorInfo.toJSON(),
      "patients_info": patientsInfoJSON,
      "reports": reportsJSON,
      "appointments": appointmentsJSON,
    };
  }
}
