import 'package:sep_app/models/disease_model.dart';
import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/models/symptom_model.dart';

class ReportModel {
  String id;
  PatientModel patient;
  DoctorModel doctor;
  List<SymptomModel> symptoms;
  String patientNote;
  String doctorFeedback;
  List<DiseaseModel> possibleDiseases;
  DateTime createdAt;

  ReportModel({
    required this.id,
    required this.patient,
    required this.doctor,
    required this.symptoms,
    required this.patientNote,
    required this.doctorFeedback,
    required this.possibleDiseases,
    required this.createdAt,
  });

  factory ReportModel.fromJSON(Map<String, dynamic> json) {
    List<SymptomModel> symptomsList = [];

    for (var symptomJSON in json['symptoms']) {
      symptomsList.add(SymptomModel.fromJSON(symptomJSON));
    }

    List<DiseaseModel> diseasesList = [];

    for (var diseaseJSON in json['possible_diseases']) {
      diseasesList.add(DiseaseModel.fromJSON(diseaseJSON));
    }

    return ReportModel(
      id: json['id'],
      patient: PatientModel.fromJSON(json['patient']),
      doctor: DoctorModel.fromJSON(json['doctor']),
      symptoms: symptomsList,
      patientNote: json['patient_note'],
      doctorFeedback: json['doctor_feedback'],
      possibleDiseases: diseasesList,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJSON() {
    List<Map<String, dynamic>> symptomsJSON = [];

    for (var symptom in symptoms) {
      symptomsJSON.add(symptom.toJSON());
    }

    List<Map<String, dynamic>> diseasesJSON = [];

    for (var disease in possibleDiseases) {
      diseasesJSON.add(disease.toJSON());
    }

    return {
      "id": id,
      "patient": patient.toJSON(),
      "doctor": doctor.toJSON(),
      "symptoms": symptomsJSON,
      "patient_note": patientNote,
      "doctor_feedback": doctorFeedback,
      "possible_diseases": diseasesJSON,
      "created_at": createdAt.toIso8601String(),
    };
  }
}
