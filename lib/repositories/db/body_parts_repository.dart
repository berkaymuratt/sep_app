import 'package:sep_app/locator.dart';
import 'package:sep_app/models/body_part_model.dart';
import 'package:sep_app/services/db_service/body_parts_db_service/body_parts_db_service.dart';
import 'package:sep_app/services/db_service/body_parts_db_service/body_parts_db_service_base.dart';

class BodyPartsRepository extends BodyPartsDbServiceBase {
  final BodyPartsDbService _service = locator<BodyPartsDbService>();

  @override
  Future<List<BodyPartModel>> getBodyParts() async {
    return _service.getBodyParts();
  }
}