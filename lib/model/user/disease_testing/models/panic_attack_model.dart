class ModelPanicAttack {
  final String title;
  final List<String> answers;
  final String question;

  ModelPanicAttack({
    required this.title,
    required this.answers,
    required this.question,
  });

  factory ModelPanicAttack.fromJson(Map<String, dynamic> json) {
    final questionTitle = json.keys.first;
    final questionData = json[questionTitle];
    return ModelPanicAttack(
      title: questionTitle,
      question: questionData[0],
      answers: List<String>.from(questionData[1]),
    );
  }
}
