// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../../../resources/color-manager.dart';
// import 'test_depression_controller.dart';
//
// class DepressionTest extends StatelessWidget {
//   const DepressionTest({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final DepressionController getQuesAndAns = Get.put(DepressionController());
//
//     double heightScreen = MediaQuery.of(context).size.height;
//     double widthScreen = MediaQuery.of(context).size.width;
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: ColorManager.primaryPanicAttack,
//         body: Obx(() {
//           if (getQuesAndAns.questionsWithAnswer.isEmpty) {
//             return Center(
//               child: Column(
//                 children: [
//                   SizedBox(height: heightScreen * 0.15),
//                   SizedBox(
//                     height: heightScreen * 0.4,
//                     child: Lottie.asset(
//                       "assets/imageJson/question.json",
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   SizedBox(height: heightScreen * 0.07),
//                   Text(
//                     "No questions available",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 25,
//                       color: ColorManager.secondPanicAttack,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             final question = getQuesAndAns
//                 .questionsWithAnswer[getQuesAndAns.questionIndex.value];
//             //to make time line
//             final progress = getQuesAndAns.calculateAnsweredPercentage();
//             return ListView(
//               children: [
//                 Column(
//                   children: [        SizedBox(
//                     height: heightScreen * 0.0005,
//                   ),
//                     //timeline
//                     LinearProgressIndicator(
//                       minHeight: 10,
//                       backgroundColor: Colors.grey[300],
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                           ColorManager.secondPanicAttack),
//                       value: progress / 100,
//                     ),
//                     SizedBox(
//                       height: heightScreen * 0.01,
//                     ),
//                     SizedBox(
//                       height: heightScreen * 0.3,
//                       child: Lottie.asset(
//                         "assets/imageJson/question.json",
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Container(
//                       clipBehavior: Clip.hardEdge,
//                       height: heightScreen * 0.2,
//                       width: widthScreen * 0.95,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         color: ColorManager.quesPanicAttack,
//                       ),
//                       child: Stack(
//                         children: [
//                           Center(
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 20),
//                               child: Text(
//                                 question.question,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: heightScreen * 0.03,
//                     ),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: question.answers.length,
//                       itemBuilder: (context, answerIndex) {
//                         return InkWell(
//                           onTap: () {
//                             getQuesAndAns.selectAnswer(answerIndex);
//
//                           },
//                           child: Stack(
//                             children: [
//                               Center(
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 8),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(30),
//                                       color: ColorManager.ansPanicAttack,
//                                     ),
//                                     height: heightScreen * 0.08,
//                                     width: widthScreen * 0.9,
//                                     clipBehavior: Clip.hardEdge,
//                                   ),
//                                 ),
//                               ),
//                               Positioned.fill(
//                                 child: Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     question.answers[answerIndex],
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                     SizedBox(
//                       height: heightScreen * 0.03,
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           }
//         }),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../resources/color-manager.dart';
import 'test_depression_controller.dart';

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
                    "No questions available",
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
                      height: heightScreen * 0.01,
                    ),
                    SizedBox(
                      height: heightScreen * 0.3,
                      child: Lottie.asset(
                        "assets/imageJson/question.json",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      height: heightScreen * 0.15,
                      width: widthScreen * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorManager.quesPanicAttack,
                      ),
                      child: Stack(
                        children: [
                          Center(
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
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: heightScreen * 0.03,
                    ),
                    // Display answers in rows of two
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (question.answers.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        // For odd number of answers, the last row will have only one answer
                        final int firstAnswerIndex = index * 2;
                        final int secondAnswerIndex = firstAnswerIndex + 1;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildAnswerButton(
                                  heightScreen, widthScreen, question.answers[firstAnswerIndex], () {
                                getQuesAndAns.selectAnswer(firstAnswerIndex);
                              }),
                              if (secondAnswerIndex < question.answers.length)
                                _buildAnswerButton(
                                    heightScreen, widthScreen, question.answers[secondAnswerIndex], () {
                                  getQuesAndAns.selectAnswer(secondAnswerIndex);
                                }),
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

  Widget _buildAnswerButton(double heightScreen, double widthScreen, String answer, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: ColorManager.ansPanicAttack,
        ),
        height: heightScreen * 0.08,
        width: widthScreen * 0.42,
        clipBehavior: Clip.hardEdge,
        child: Center(
          child: Text(
            answer,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
