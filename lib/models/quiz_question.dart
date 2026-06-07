class QuizQuestion {
  final String prompt;
  final String correctAnswer;
  final List<String> options;
  final String explanation;

  const QuizQuestion({
    required this.prompt,
    required this.correctAnswer,
    required this.options,
    required this.explanation,
  });
}
