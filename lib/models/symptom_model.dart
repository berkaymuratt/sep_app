import 'package:sep_app/models/body_part_model.dart';

class SymptomModel {
  String id;
  String name;
  BodyPartModel bodyPart;
  int level;

  SymptomModel({
    required this.id,
    required this.name,
    required this.bodyPart,
    required this.level,
  });

  factory SymptomModel.fromJSON(Map<String, dynamic> json) => SymptomModel(
        id: json['id'],
        name: json['name'],
        bodyPart: BodyPartModel.fromJSON(json['body_part']),
        level: json['level'],
      );

  Map<String, dynamic> toJSON() => {
        "id": id,
        "name": name,
        "body_part": bodyPart.toJSON(),
        "level": level,
      };
}
