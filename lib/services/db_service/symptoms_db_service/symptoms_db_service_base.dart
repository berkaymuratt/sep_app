import 'package:sep_app/models/symptom_model.dart';

abstract class SymptomsDbServiceBase {
  Future<List<SymptomModel>> getSymptoms(String bodyPartId);
}