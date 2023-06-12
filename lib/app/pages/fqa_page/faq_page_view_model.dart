import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sep_app/app/shared/view_models/view_model_base.dart';
import 'package:sep_app/models/faq_question_model.dart';

class FaqPageViewModel extends ViewModelBase {
  List<FaqQuestionModel> questions = [];

  Future<void> loadFaqQuestions() async {
     String jsonString = await rootBundle.loadString('assets/data/faq_questions.json');
     final Map<String, dynamic> jsonResponse = json.decode(jsonString);

     for (var questionJson in jsonResponse['questions']) {
       questions.add(FaqQuestionModel.fromJSON(questionJson));
     }

     notifyListeners();
  }
}