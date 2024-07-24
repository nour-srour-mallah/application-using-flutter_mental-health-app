import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../resources/color-manager.dart';
import '../../../../widgets/answer_buttutton.dart';
import 'test_panicattack_controller.dart';

class PanicAttackTest extends StatelessWidget {
  const PanicAttackTest({super.key});

  @override
  Widget build(BuildContext context) {
    final PanicAttackController getQuesAndAns =
        Get.put(PanicAttackController());

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
                    "No questions available now,Please wait",
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
            //to make time line
            final progress = getQuesAndAns.calculateAnsweredPercentage();
            return ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: heightScreen * 0.0005,
                    ),
                    //timeline
                    LinearProgressIndicator(
                      minHeight: 10,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                          ColorManager.secondPanicAttack),
                      value: progress / 100,
                    ),
                    SizedBox(
                      height: heightScreen * 0.03,
                    ),
                    SizedBox(
                      height: heightScreen * 0.3,
                      child: Lottie.asset(
                        "assets/imageJson/question.json",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: heightScreen * 0.03,
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      height: heightScreen * 0.2,
                      width: widthScreen * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorManager.quesPanicAttack,
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: heightScreen * 0.03,
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (question.answers.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        //make row for odd number make center
                        final int firstAnswerIndex = index * 2;
                        final int secondAnswerIndex = firstAnswerIndex + 1;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AnswerButton(
                                heightScreen: heightScreen,
                                widthScreen: widthScreen,
                                answer: question.answers[firstAnswerIndex],
                                onTap: () {
                                  getQuesAndAns.selectAnswer(firstAnswerIndex);
                                },
                              ),
                              if (secondAnswerIndex < question.answers.length)
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
                    SizedBox(
                      height: heightScreen * 0.03,
                    ),
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
