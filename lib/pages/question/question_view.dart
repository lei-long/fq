import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'question_logic.dart'; // 导入控制器

class QuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      Get.put(QuestionLogic());
    return GetBuilder<QuestionLogic>(

      builder: (controller) {
        if (controller.isQuizCompleted) {
          return Scaffold(
            appBar: AppBar(
              title: Text('flutter基础'),
            ),
            body: Center(
              child: Text('你的成绩: ${(controller.score/sampleQuestions.length)*100}'),
            ),
          );
        }

        final question = sampleQuestions[controller.currentQuestionIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text('flutter基础'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  question.questionText,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                ...question.options.map((option) {
                  return ElevatedButton(
                    onPressed: () => controller.answerQuestion(option),
                    child: Text(option),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
