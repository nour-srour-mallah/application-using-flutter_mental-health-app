import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../resources/color-manager.dart';
import '../../../../widgets/answer_buttutton.dart';
import 'depression_controler.dart';

class DepressionTest extends StatelessWidget {
  const DepressionTest({super.key});

  @override
  Widget build(BuildContext context) {
    final DepressionController getQuesAndAns = Get.put(DepressionController());

    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryPanicAttack,
        body: Obx(() {
          if (getQuesAndAns.questionsWithAnswer.isEmpty) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: heightScreen * 0.15),
                  SizedBox(
                    height: heightScreen * 0.4,
                    child: Lottie.asset(
                      "assets/imageJson/question.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: heightScreen * 0.07),
                  Text(
                    "No questions available now, Please wait",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: ColorManager.secondPanicAttack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else {
            final question = getQuesAndAns
                .questionsWithAnswer[getQuesAndAns.questionIndex.value];
            final progress = getQuesAndAns.calculateAnsweredPercentage();
            TextEditingController customAnswerController =
                TextEditingController();

            return ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: heightScreen * 0.0005),
                    LinearProgressIndicator(
                      minHeight: 10,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                          ColorManager.secondPanicAttack),
                      value: progress / 100,
                    ),
                    SizedBox(height: heightScreen * 0.03),
                    SizedBox(
                      height: heightScreen * 0.3,
                      child: Lottie.asset(
                        "assets/imageJson/question.json",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: heightScreen * 0.03),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      height: heightScreen * 0.2,
                      width: widthScreen * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorManager.quesPanicAttack,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            question.question,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: heightScreen * 0.03),
                    if (question.answers.any((answer) => answer.isEmpty))
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: customAnswerController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorManager.primaryPanicAttack,
                                hintText: "Enter your answer",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.secondPanicAttack),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.secondPanicAttack),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              cursorColor: ColorManager.secondPanicAttack,
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.secondPanicAttack,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                if (customAnswerController.text.isNotEmpty) {
                                  getQuesAndAns.selectAnswer(-1,
                                      customAnswer:
                                          customAnswerController.text);
                                  customAnswerController.clear();
                                }
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (question.answers.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        final int firstAnswerIndex = index * 2;
                        final int secondAnswerIndex = firstAnswerIndex + 1;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (question.answers[firstAnswerIndex].isNotEmpty)
                                AnswerButton(
                                  heightScreen: heightScreen,
                                  widthScreen: widthScreen,
                                  answer: question.answers[firstAnswerIndex],
                                  onTap: () {
                                    getQuesAndAns
                                        .selectAnswer(firstAnswerIndex);
                                  },
                                ),
                              if (secondAnswerIndex < question.answers.length &&
                                  question
                                      .answers[secondAnswerIndex].isNotEmpty)
                                AnswerButton(
                                  heightScreen: heightScreen,
                                  widthScreen: widthScreen,
                                  answer: question.answers[secondAnswerIndex],
                                  onTap: () {
                                    getQuesAndAns
                                        .selectAnswer(secondAnswerIndex);
                                  },
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: heightScreen * 0.03),
                  ],
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
