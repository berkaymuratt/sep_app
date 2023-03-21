import 'package:sep_app/models/users/user_info_model.dart';

class AppointmentModel {
  String id;
  UserInfoModel doctorInfo;
  UserInfoModel patientInfo;
  String date;

  AppointmentModel({
    required this.id,
    required this.doctorInfo,
    required this.patientInfo,
    required this.date,
  });

  factory AppointmentModel.fromJSON(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json['id'],
        doctorInfo: UserInfoModel.fromJSON(json['doctor_info']),
        patientInfo: UserInfoModel.fromJSON(json['patient_info']),
        date: json['date'],
      );

  Map<String, dynamic> toJSON() => {
        "id": id,
        "doctor_info": doctorInfo.toJSON(),
        "patient_info": patientInfo.toJSON(),
        "date": date,
      };
}
