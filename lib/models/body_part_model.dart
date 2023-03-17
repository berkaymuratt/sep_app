class BodyPartModel {
  String id;
  String name;

  BodyPartModel({
    required this.id,
    required this.name,
  });

  factory BodyPartModel.fromJSON(Map<String, dynamic> json) => BodyPartModel(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJSON() => {
        "id": id,
        "name": name,
      };
}
