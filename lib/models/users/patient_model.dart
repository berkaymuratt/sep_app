import 'package:sep_app/models/users/user_info/patient_info_model.dart';

class PatientModel {
  String id;
  String doctorId;
  String userId;
  PatientInfoModel? patientInfo;

  PatientModel({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.patientInfo,
  });

  factory PatientModel.empty() => PatientModel(
        id: "",
        userId: "",
        doctorId: "",
        patientInfo: null,
      );

  factory PatientModel.fromJSON(Map<String, dynamic> json) {
    return PatientModel(
        id: json['id'],
        doctorId: json['doctor_id'],
        userId: json['user_id'],
        patientInfo: PatientInfoModel.fromJSON(json['patient_info']));
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "doctor_id": doctorId,
      "user_id": userId,
      "patient_info": patientInfo != null ? patientInfo!.toJSON() : null,
    };
  }
}
