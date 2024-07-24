class ModelDepressionBipolar {
  final String title;
  final List<String> answers;
  final String question;

  ModelDepressionBipolar({
    required this.title,
    required this.answers,
    required this.question,
  });

  factory ModelDepressionBipolar.fromJson(Map<String, dynamic> json) {
    final questionTitle = json.keys.first;
    final questionData = json[questionTitle];
    return ModelDepressionBipolar(
      title: questionTitle,
      question: questionData[0],
      answers: List<String>.from(questionData[1]),
    );
  }
}
