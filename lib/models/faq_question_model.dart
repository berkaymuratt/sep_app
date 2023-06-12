class FaqQuestionModel {
  final String question;
  final String answer;
  bool isExpanded;

  FaqQuestionModel({required this.question, required this.answer, this.isExpanded=false});

  factory FaqQuestionModel.fromJSON(Map<String, dynamic> json) => FaqQuestionModel(
    question: json['question'],
    answer: json['answer'],
  );
}