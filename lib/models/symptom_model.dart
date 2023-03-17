import 'package:sep_app/models/body_part_model.dart';

class SymptomModel {
  String id;
  String name;
  BodyPartModel bodyPart;
  int painIntensity;

  SymptomModel({
    required this.id,
    required this.name,
    required this.bodyPart,
    required this.painIntensity,
  });

  factory SymptomModel.fromJSON(Map<String, dynamic> json) => SymptomModel(
        id: json['id'],
        name: json['name'],
        bodyPart: BodyPartModel.fromJSON(json['body_part']),
        painIntensity: json['pain_intensity'],
      );

  Map<String, dynamic> toJSON() => {
        "id": id,
        "name": name,
        "body_part": bodyPart.toJSON(),
        "pain_intensity": painIntensity,
      };
}
