import 'package:get/get.dart';
class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });
}
List<Question> sampleQuestions = [
  Question(
    questionText: 'flutter的核心语言是?',
    options: ['java', 'python', 'dart', 'c++'],
    correctAnswer: 'dart',
  ),
  Question(
    questionText: 'flutter用来通讯的工具是?',
    options: [
      'HTTP, WebSocket,Firebase',
      'TCP, UDP, WebRTC',
      'DNS, SMTP, IMAP',
      'SMTP, IMAP, POP3'
    ],
    correctAnswer: 'HTTP, WebSocket,Firebase',
  ),
];
class QuestionLogic extends GetxController {
  int currentQuestionIndex = 0;
  int score = 0;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  void answerQuestion(String selectedOption) {
    final correctAnswer = sampleQuestions[currentQuestionIndex].correctAnswer;
    if (selectedOption == correctAnswer) {
      score++;
    }
    currentQuestionIndex++;
    update(); // 通知 GetBuilder 更新 UI
  }

  bool get isQuizCompleted => currentQuestionIndex >= sampleQuestions.length;
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
