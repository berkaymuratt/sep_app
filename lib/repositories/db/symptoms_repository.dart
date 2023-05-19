import 'package:sep_app/locator.dart';
import 'package:sep_app/models/symptom_model.dart';
import 'package:sep_app/services/db_service/symptoms_db_service/symptoms_db_service.dart';
import 'package:sep_app/services/db_service/symptoms_db_service/symptoms_db_service_base.dart';

class SymptomsRepository extends SymptomsDbServiceBase {
  final SymptomsDbService _service = locator<SymptomsDbService>();

  @override
  Future<List<SymptomModel>> getSymptoms(String bodyPartId) async {
    return _service.getSymptoms(bodyPartId);
  }
}