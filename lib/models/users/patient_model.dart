import 'package:sep_app/models/users/user_info/patient_info_model.dart';

class PatientModel {
  String id;
  String userId;
  PatientInfoModel patientInfo;

  PatientModel({
    required this.id,
    required this.userId,
    required this.patientInfo,
  });

  factory PatientModel.fromJSON(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      userId: json['user_id'],
      patientInfo: json["patient_info"]
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "user_id": userId,
      "patient_info": patientInfo.toJSON(),
    };
  }
}
