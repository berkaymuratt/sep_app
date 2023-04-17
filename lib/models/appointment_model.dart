import 'package:sep_app/models/report/report_model.dart';
import 'package:sep_app/models/symptom_model.dart';
import 'package:sep_app/models/users/user_info/doctor_info_model.dart';
import 'package:sep_app/models/users/user_info/patient_info_model.dart';

class AppointmentModel {
  String id;
  DoctorInfoModel doctorInfo;
  PatientInfoModel patientInfo;
  String date;
  ReportModel? report;
  List<SymptomModel>? symptoms = [];
  String patientNote;

  AppointmentModel({
    required this.id,
    required this.doctorInfo,
    required this.patientInfo,
    required this.date,
    required this.symptoms,
    required this.patientNote,
  });

  factory AppointmentModel.fromJSON(Map<String, dynamic> json) {

    final List<SymptomModel> symptomsList = [];

    for (Map<String, dynamic> symptomJSON in json['symptoms']) {
      symptomsList.add(SymptomModel.fromJSON(symptomJSON));
    }

    return AppointmentModel(
      id: json['id'],
      doctorInfo: DoctorInfoModel.fromJSON(json['doctor_info']),
      patientInfo: PatientInfoModel.fromJSON(json['patient_info']),
      date: json['date'],
      symptoms: symptomsList,
      patientNote: json['patient_note'],
    );
  }


  Map<String, dynamic> toJSON() {

    Map<String, dynamic> json = {
      "id": id,
      "doctor_info": doctorInfo.toJSON(),
      "patient_info": patientInfo.toJSON(),
      "date": date,
      "patient_note": patientNote
    };

    if (report != null) {
      json['report'] = report!.toJSON();
    }

    if (symptoms != null) {
      List<Map<String, dynamic>> symptomsJson = [];

      for (SymptomModel symptom in symptoms!) {
        symptomsJson.add(symptom.toJSON());
      }

      json['symptoms'] = symptomsJson;
    }

    return json;
  }
}
