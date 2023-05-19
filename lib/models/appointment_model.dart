import 'package:sep_app/models/symptom_model.dart';
import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/models/users/patient_model.dart';

class AppointmentModel {
  String id;
  DoctorModel? doctor;
  PatientModel? patient;
  DateTime? date;
  String reportId;
  List<SymptomModel>? symptoms = [];
  String patientNote;

  AppointmentModel({
    required this.id,
    required this.doctor,
    required this.patient,
    required this.date,
    required this.reportId,
    required this.symptoms,
    required this.patientNote,
  });

  factory AppointmentModel.empty() => AppointmentModel(
        id: "",
        doctor: null,
        patient: null,
        date: null,
        reportId: "",
        symptoms: null,
        patientNote: "",
      );

  factory AppointmentModel.fromJSON(Map<String, dynamic> json) {
    final List<SymptomModel> symptomsList = [];

    for (Map<String, dynamic> symptomJSON in json['symptoms']) {
      symptomsList.add(SymptomModel.fromJSON(symptomJSON));
    }

    return AppointmentModel(
      id: json['id'],
      doctor: DoctorModel.fromJSON(json['doctor']),
      patient: PatientModel.fromJSON(json['patient']),
      date: DateTime.parse(json['date']),
      symptoms: symptomsList,
      reportId: json['report_id'],
      patientNote: json['patient_note'],
    );
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> json = {
      "id": id,
      "doctor": doctor != null ? doctor!.toJSON() : null,
      "patient": patient != null ? patient!.toJSON() : null,
      "date": date!.toIso8601String().contains("Z")
          ? date!.toIso8601String()
          : "${date!.toIso8601String()}Z",
      "report_id": reportId,
      "patient_note": patientNote
    };

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
