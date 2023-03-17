import 'package:sep_app/models/appointment_model.dart';
import 'package:sep_app/models/report_model.dart';
import 'package:sep_app/models/user_info_model.dart';

abstract class UserModel {
  String id;
  String userId;
  UserInfoModel userInfo;
  List<ReportModel> reports;
  List<AppointmentModel> appointments;

  UserModel({
    required this.id,
    required this.userId,
    required this.userInfo,
    required this.reports,
    required this.appointments,
  });
}
