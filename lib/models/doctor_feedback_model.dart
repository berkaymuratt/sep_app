class DoctorFeedbackModel {
  String content;
  String date;

  DoctorFeedbackModel({
    required this.content,
    required this.date,
  });

  factory DoctorFeedbackModel.fromJSON(Map<String, dynamic> json) =>
      DoctorFeedbackModel(
        content: json['content'],
        date: json['date'],
      );

  Map<String, dynamic> toJSON() => {
        "content": content,
        "date": date,
      };
}
