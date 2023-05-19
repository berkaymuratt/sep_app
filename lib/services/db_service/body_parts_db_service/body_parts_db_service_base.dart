import 'package:sep_app/models/body_part_model.dart';

abstract class BodyPartsDbServiceBase {
  Future<List<BodyPartModel>> getBodyParts();
}