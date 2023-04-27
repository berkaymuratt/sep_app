import 'package:sep_app/models/users/user_info/user_info_model.dart';

class PatientInfoModel extends UserInfoModel {

  String gender;
  int age;
  int height;
  double weight;

  PatientInfoModel({
    required super.name,
    required super.surname,
    required super.telephone,
    required super.address,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
  });

  factory PatientInfoModel.fromJSON(Map<String, dynamic> json) =>
      PatientInfoModel(
        name: json['name'],
        surname: json['surname'],
        gender: json['gender'],
        telephone: json['telephone'],
        address: json['address'],
        age: json['age'],
        height: json['height'],
        weight: json['weight'].toDouble(),
      );

  @override
  Map<String, dynamic> toJSON() {
    var json = super.toJSON();

    json['gender'] = gender;
    json['age'] = age;
    json['height'] = height;
    json['weight'] = weight;

    return json;
  }
}
