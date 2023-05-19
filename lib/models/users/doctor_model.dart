import 'package:sep_app/models/users/user_info/doctor_info_model.dart';

class DoctorModel {
  String id;
  String userId;
  DoctorInfoModel? doctorInfo;

  DoctorModel({
    required this.id,
    required this.userId,
    required this.doctorInfo,
  });

  factory DoctorModel.empty() => DoctorModel(
        id: "",
        userId: "",
        doctorInfo: null,
      );

  factory DoctorModel.fromJSON(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      userId: json['user_id'],
      doctorInfo: DoctorInfoModel.fromJSON(json['doctor_info']),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "user_id": userId,
      "doctor_info": doctorInfo != null ? doctorInfo!.toJSON() : null,
    };
  }
}
