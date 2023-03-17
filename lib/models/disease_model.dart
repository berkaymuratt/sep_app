import 'package:sep_app/models/symptom_model.dart';

class DiseaseModel {
  String id;
  List<SymptomModel> symptoms;
  String name;
  String details;

  DiseaseModel({
    required this.id,
    required this.symptoms,
    required this.name,
    required this.details,
  });

  factory DiseaseModel.fromJSON(Map<String, dynamic> json) {
    List<SymptomModel> symptomsList = [];

    for (Map<String, dynamic> symptomJSON in json['symptoms']) {
      symptomsList.add(SymptomModel.fromJSON(symptomJSON));
    }

    return DiseaseModel(
      id: json['id'],
      symptoms: symptomsList,
      name: json['name'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJSON() {
    List<Map<String, dynamic>> symptomsList = [];

    for (SymptomModel symptom in symptoms) {
      symptomsList.add(symptom.toJSON());
    }

    return {
      "id": id,
      "symptoms": symptomsList,
      "name": name,
      "details": details,
    };
  }
}
