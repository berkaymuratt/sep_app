import 'package:flutter/material.dart';
import 'package:sep_app/app/shared/view_models/view_model_base.dart';
import 'package:sep_app/locator.dart';
import 'package:sep_app/models/body_part_model.dart';
import 'package:sep_app/models/symptom_model.dart';
import 'package:sep_app/repositories/db/body_parts_repository.dart';
import 'package:sep_app/repositories/db/symptoms_repository.dart';

class AddSymptomModalViewModel extends ViewModelBase {
  final SymptomsRepository _symptomsRepository = locator<SymptomsRepository>();
  final BodyPartsRepository _bodyPartsRepository =
      locator<BodyPartsRepository>();

  List<BodyPartModel>? bodyParts;
  List<SymptomModel>? symptoms;

  SymptomModel? _selectedSymptom;

  SymptomModel? get selectedSymptom => _selectedSymptom;

  set selectedSymptom(SymptomModel? selectedSymptom) {
    _selectedSymptom = selectedSymptom;
    notifyListeners();
  }

  Future<List<BodyPartModel>?> getBodyParts() async {
    try {
      state = ViewState.BUSY;
      bodyParts = await _bodyPartsRepository.getBodyParts();
      return bodyParts;
    } catch(e) {
      bodyParts = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  Future<List<SymptomModel>?> getSymptoms(String bodyPartId) async {
    try {
      state = ViewState.BUSY;
      symptoms = await _symptomsRepository.getSymptoms(bodyPartId);
      return symptoms;
    } catch(e) {
      symptoms = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  void clearSymptoms() {
    if (symptoms != null) {
      selectedSymptom = null;
      symptoms!.clear();
    }
    notifyListeners();
  }

  @override
  bool get isStateLoading =>
      bodyParts == null || super.isStateLoading;
}
