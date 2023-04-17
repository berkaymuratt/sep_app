import 'package:get_it/get_it.dart';
import 'package:sep_app/jwt_manager.dart';
import 'package:sep_app/repositores/db/appointments_repository.dart';
import 'package:sep_app/repositores/db/doctors_repository.dart';
import 'package:sep_app/repositores/db/patients_repository.dart';
import 'package:sep_app/repositores/db/reports_repository.dart';
import 'package:sep_app/services/db_service/appointments_db_service/appointment_db_service.dart';
import 'package:sep_app/services/db_service/doctors_db_service/doctors_db_service.dart';
import 'package:sep_app/services/db_service/patients_db_service/patients_db_service.dart';
import 'package:sep_app/services/db_service/reports_db_service/reports_db_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => JwtManager());

  locator.registerLazySingleton(() => PatientsDbService());
  locator.registerLazySingleton(() => DoctorsDbService());
  locator.registerLazySingleton(() => ReportsDbService());
  locator.registerLazySingleton(() => AppointmentDbService());

  locator.registerLazySingleton(() => PatientsRepository());
  locator.registerLazySingleton(() => DoctorsRepository());
  locator.registerLazySingleton(() => ReportsRepository());
  locator.registerLazySingleton(() => AppointmentsRepository());
}
