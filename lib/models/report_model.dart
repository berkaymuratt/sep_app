import 'package:sep_app/models/disease_model.dart';
import 'package:sep_app/models/doctor_feedback_model.dart';
import 'package:sep_app/models/users/user_info_model.dart';
import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/models/users/patient_model.dart';
import 'package:sep_app/models/symptom_model.dart';

class ReportModel {
  String id;
  UserInfoModel patientInfo;
  UserInfoModel doctorInfo;
  List<SymptomModel> symptoms;
  DoctorFeedbackModel doctorFeedback;
  List<DiseaseModel> possibleDiseases;

  ReportModel({
    required this.id,
    required this.patientInfo,
    required this.doctorInfo,
    required this.symptoms,
    required this.doctorFeedback,
    required this.possibleDiseases,
  });

  factory ReportModel.fromJSON(Map<String, dynamic> json) {
    List<SymptomModel> symptomsList = [];

    for (var symptomJSON in json['symptoms']) {
      symptomsList.add(SymptomModel.fromJSON(symptomJSON));
    }

    List<DiseaseModel> diseasesList = [];

    for (var diseaseJSON in json['diseases']) {
      diseasesList.add(DiseaseModel.fromJSON(diseaseJSON));
    }

    return ReportModel(
      id: json['id'],
      patientInfo: UserInfoModel.fromJSON(json['patient_info']),
      doctorInfo: UserInfoModel.fromJSON(json['doctor_info']),
      symptoms: symptomsList,
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
      "patient_info": patientInfo.toJSON(),
      "doctor_info": doctorInfo.toJSON(),
      "symptoms": symptomsJSON,
      "doctor_feedback": doctorFeedback.toJSON(),
      "possible_diseases": diseasesJSON,
    };
  }
}
