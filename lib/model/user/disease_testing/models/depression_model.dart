class ModelDepression {
  final String title;
  final List<String> answers;
  final String question;

  ModelDepression({
    required this.title,
    required this.answers,
    required this.question,
  });

  factory ModelDepression.fromJson(Map<String, dynamic> json) {
    final questionTitle = json.keys.first;
    final questionData = json[questionTitle];
    return ModelDepression(
      title: questionTitle,
      question: questionData[0],
      answers: List<String>.from(questionData[1]),
    );
  }
}
