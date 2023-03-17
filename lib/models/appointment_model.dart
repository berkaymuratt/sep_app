import 'package:sep_app/models/users/doctor_model.dart';
import 'package:sep_app/models/users/patient_model.dart';

class AppointmentModel {
  String id;
  DoctorModel doctor;
  PatientModel patient;
  String date;

  AppointmentModel({
    required this.id,
    required this.doctor,
    required this.patient,
    required this.date,
  });

  factory AppointmentModel.fromJSON(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json['id'],
        doctor: DoctorModel.fromJSON(json['doctor']),
        patient: PatientModel.fromJSON(json['patient']),
        date: json['date'],
      );

  Map<String, dynamic> toJSON() => {
        "id": id,
        "doctor": doctor.toJSON(),
        "patient": patient.toJSON(),
        "date": date,
      };
}
