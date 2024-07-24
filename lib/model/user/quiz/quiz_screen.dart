import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import '../../../resources/color-manager.dart';
import '../../../resources/route.dart';

import 'quiz_controller.dart';

class QuestionEXP extends StatelessWidget {
  QuestionEXP({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizController controller = Get.put(
      QuizController(),
    );

    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorManager.primaryPanicAttack,
        body: Center(child: Obx(() {
          if (controller.currentIndex.value >= questionList.length) {
            return Column(
              children: [
                if (controller.finalResult == "Panic" ||
                    controller.finalResult == "Depression" ||
                    controller.finalResult == "Bipolar")
                  Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: heightScreen * 0.17,
                      ),
                      Image.asset("assets/images/have.png"),
                      SizedBox(
                        height: heightScreen * 0.03,
                      ),
                      Text(
                        "you seem to be suffering from",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorManager.secondPanicAttack,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: heightScreen * 0.01,
                      ),
                      Text(
                        "${controller.finalResult}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: ColorManager.secondPanicAttack,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "click Continue to complete the test and verify the matter",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              color: ColorManager.secondPanicAttack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: heightScreen * 0.05,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50),
                          backgroundColor: ColorManager.secondPanicAttack,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          print(
                              "shure get storage : ${GetStorage().read('ilnesses')}");
                          if (GetStorage().read('ilnesses') == "Panic") {
                            Get.offNamed(Routes.getPaincAttackRoute());
                          } else if (GetStorage().read('ilnesses') ==
                              "Depression") {
                            Get.offNamed(Routes.getDepRoute());
                          } else {
                            Get.offNamed(Routes.getDepressionRoute());
                          }
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )),
                if (controller.finalResult == "Nothing")
                  Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: heightScreen * 0.17,
                      ),
                      Image.asset("assets/images/dont.png"),
                      SizedBox(
                        height: heightScreen * 0.03,
                      ),
                      Text(
                        "you do not suffer from any disease",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: ColorManager.secondPanicAttack,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: heightScreen * 0.03,
                      ),
                      Text(
                        "click Continue start",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: ColorManager.secondPanicAttack,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: heightScreen * 0.05,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50),
                          backgroundColor: ColorManager.secondPanicAttack,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Get.offNamed(Routes.getHomeRoute());
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ))
              ],
            );
            ///////////////////////question
          } else {
            return ListView(
              children: [
                Column(
                  children: [
                    Column(children: [
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
                          height: heightScreen * 0.2,
                          width: widthScreen * 0.95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: ColorManager.quesPanicAttack,
                          ),
                          child: Stack(children: [
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  questionList[controller.currentIndex.value]
                                      .question,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ])),
                      SizedBox(
                        height: heightScreen * 0.03,
                      ),
                    ]),
                    Column(
                      children: [
                        ////// when solution 1
                        InkWell(
                          onTap: () {
                            controller.selectAnswer(0);
                          },
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: ColorManager.ansPanicAttack),
                              height: heightScreen * 0.085,
                              width: widthScreen * 0.9,
                              clipBehavior: Clip.hardEdge,
                            ),
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        questionList[
                                                controller.currentIndex.value]
                                            .answer1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))))
                          ]),
                        ),
                        SizedBox(
                          height: heightScreen * 0.02,
                        ),
                        ////// when solution 2
                        InkWell(
                          onTap: () {
                            controller.selectAnswer(1);
                          },
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: ColorManager.ansPanicAttack),
                              height: heightScreen * 0.085,
                              width: widthScreen * 0.9,
                              clipBehavior: Clip.hardEdge,
                            ),
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        questionList[
                                                controller.currentIndex.value]
                                            .answer2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))))
                          ]),
                        ),

                        SizedBox(
                          height: heightScreen * 0.02,
                        ),
                        ////// when solution 3
                        InkWell(
                          onTap: () {
                            controller.selectAnswer(2);
                          },
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: ColorManager.ansPanicAttack),
                              height: heightScreen * 0.085,
                              width: widthScreen * 0.9,
                              clipBehavior: Clip.hardEdge,
                            ),
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        questionList[
                                                controller.currentIndex.value]
                                            .answer3,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))))
                          ]),
                        ),

                        SizedBox(
                          height: heightScreen * 0.02,
                        ),
                        ////// when solution 4
                        InkWell(
                          onTap: () {
                            controller.selectAnswer(3);
                          },
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: ColorManager.ansPanicAttack),
                              height: heightScreen * 0.085,
                              width: widthScreen * 0.9,
                              clipBehavior: Clip.hardEdge,
                            ),
                            Positioned.fill(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        questionList[
                                                controller.currentIndex.value]
                                            .answer4,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))))
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
        })));
  }
}
