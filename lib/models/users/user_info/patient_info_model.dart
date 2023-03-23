import 'package:sep_app/models/users/user_info/user_info_model.dart';

class PatientInfoModel extends UserInfoModel {

  String doctorId;
  int age;
  int height;
  double weight;

  PatientInfoModel({
  required this.doctorId,
    required super.name,
    required super.surname,
    required super.telephone,
    required super.address,
    required this.age,
    required this.height,
    required this.weight,
  });

  factory PatientInfoModel.fromJSON(Map<String, dynamic> json) =>
      PatientInfoModel(
        doctorId: json['doctor_id'],
        name: json['name'],
        surname: json['surname'],
        telephone: json['telephone'],
        address: json['address'],
        age: json['age'],
        height: json['height'],
        weight: json['weight'],
      );

  @override
  Map<String, dynamic> toJSON() {
    var json = super.toJSON();

    json['doctor_id'] = doctorId;
    json['age'] = age;
    json['height'] = height;
    json['weight'] = weight;

    return json;
  }
}
