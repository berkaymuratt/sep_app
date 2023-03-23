import 'package:get_it/get_it.dart';
import 'package:sep_app/app_mode.dart';
import 'package:sep_app/repositores/appointments_repository.dart';
import 'package:sep_app/repositores/doctors_repository.dart';
import 'package:sep_app/repositores/patients_repository.dart';
import 'package:sep_app/repositores/reports_repository.dart';
import 'package:sep_app/services/db_service/appointments_db_service/appointment_db_service.dart';
import 'package:sep_app/services/db_service/appointments_db_service/fake_appointment_db_service.dart';
import 'package:sep_app/services/db_service/doctors_db_service/doctors_db_service.dart';
import 'package:sep_app/services/db_service/doctors_db_service/fake_doctors_db_service.dart';
import 'package:sep_app/services/db_service/patients_db_service/fake_patients_db_service.dart';
import 'package:sep_app/services/db_service/patients_db_service/patients_db_service.dart';
import 'package:sep_app/services/db_service/reports_db_service/fake_reports_db_service.dart';
import 'package:sep_app/services/db_service/reports_db_service/reports_db_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => App(mode: AppMode.DEBUG));

  locator.registerLazySingleton(() => FakePatientsDbService());
  locator.registerLazySingleton(() => PatientsDbService());

  locator.registerLazySingleton(() => FakeDoctorsDbService());
  locator.registerLazySingleton(() => DoctorsDbService());

  locator.registerLazySingleton(() => FakeReportsDbService());
  locator.registerLazySingleton(() => ReportsDbService());

  locator.registerLazySingleton(() => FakeAppointmentDbService());
  locator.registerLazySingleton(() => AppointmentDbService());

  locator.registerLazySingleton(() => PatientsRepository());
  locator.registerLazySingleton(() => DoctorsRepository());
  locator.registerLazySingleton(() => ReportsRepository());
  locator.registerLazySingleton(() => AppointmentsRepository());
}
