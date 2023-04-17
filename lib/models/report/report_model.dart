import 'package:sep_app/models/disease_model.dart';
import 'package:sep_app/models/report/doctor_feedback_model.dart';
import 'package:sep_app/models/users/user_info/doctor_info_model.dart';
import 'package:sep_app/models/users/user_info/patient_info_model.dart';
import 'package:sep_app/models/symptom_model.dart';

class ReportModel {
  String id;
  String patientId;
  String doctorId;
  PatientInfoModel patientInfo;
  DoctorInfoModel doctorInfo;
  List<SymptomModel> symptoms;
  String patientNote;
  DoctorFeedbackModel doctorFeedback;
  List<DiseaseModel> possibleDiseases;

  ReportModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.patientInfo,
    required this.doctorInfo,
    required this.symptoms,
    required this.patientNote,
    required this.doctorFeedback,
    required this.possibleDiseases,
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
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      patientInfo: PatientInfoModel.fromJSON(json['patient_info']),
      doctorInfo: DoctorInfoModel.fromJSON(json['doctor_info']),
      symptoms: symptomsList,
      patientNote: json['patient_note'],
      doctorFeedback: DoctorFeedbackModel.fromJSON(json['doctor_feedback']),
      possibleDiseases: diseasesList,
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
      "patient_id": patientId,
      "doctor_id": doctorId,
      "patient_info": patientInfo.toJSON(),
      "doctor_info": doctorInfo.toJSON(),
      "symptoms": symptomsJSON,
      "patient_note": patientNote,
      "doctor_feedback": doctorFeedback.toJSON(),
      "possible_diseases": diseasesJSON,
    };
  }
}
