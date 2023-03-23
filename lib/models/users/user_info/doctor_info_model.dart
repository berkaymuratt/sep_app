import 'package:sep_app/models/users/user_info/user_info_model.dart';

class DoctorInfoModel extends UserInfoModel {
  DoctorInfoModel({
    required super.name,
    required super.surname,
    required super.telephone,
    required super.address,
  });

  factory DoctorInfoModel.fromJSON(Map<String, dynamic> json) =>
      DoctorInfoModel(
        name: json['name'],
        surname: json['surname'],
        telephone: json['telephone'],
        address: json['address'],
      );
}
