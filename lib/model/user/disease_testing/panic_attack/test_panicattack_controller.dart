import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../resources/route.dart';
import '../models/panic_attack_model.dart';

class PanicAttackController extends GetxController {
  final String apiUrlQuestion =
      "https://selene-m-h.up.railway.app/ai/q_panic_disorder";
  final box = GetStorage();

  var questionsWithAnswer = <ModelPanicAttack>[].obs;
  var questionIndex = 0.obs;
  var selectedAnswers = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getQuestion();
  }

  Future<void> getQuestion() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrlQuestion),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': box.read('email'),
          'token': box.read('token'),
        }),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("questions is: ${responseData['q']}");
        if (responseData['q'] != null) {
          questionsWithAnswer.value = List<ModelPanicAttack>.from(
            responseData['q']
                .map((questionJson) => ModelPanicAttack.fromJson(questionJson)),
          );
        } else {
          questionsWithAnswer.clear();
        }
      } else if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final exp = responseData['state'];
        showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(exp)],
            );
          },
        );
      } else {
        throw Exception('failed, try again');
      }
    } catch (e) {
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [Text(e.toString())],
          );
        },
      );
    }
  }

  void selectAnswer(int index) {
    final currentQuestion = questionsWithAnswer[questionIndex.value];
    selectedAnswers[currentQuestion.title] = currentQuestion.answers[index];

    print("Selected answers: $selectedAnswers");

    if (questionIndex.value < questionsWithAnswer.length - 1) {
      questionIndex.value++;
    } else {
      postAnswers();
    }
  }

  final String apiUrlAnswer =
      "https://selene-m-h.up.railway.app/ai/panic_pisorder";
  Future<void> postAnswers() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrlAnswer),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': box.read('email'),
          'token': box.read('token'),
          ...selectedAnswers,
        }),
      );

      print("JSON Data Sent:");
      print(jsonEncode(<String, dynamic>{
        'email': box.read('email'),
        'token': box.read('token'),
        ...selectedAnswers,
      }));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final result = responseData['Iris_Panic'];
        box.write('panicAttack', result);
        print("res is $result");
        Get.offNamed(Routes.getShowResultPanicRoute());
      } else if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final exp = responseData['state'];
        showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(exp)],
            );
          },
        );
      } else {
        throw Exception('failed, try again');
      }
    } catch (e) {
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: Text('Error'),
            contentPadding: EdgeInsets.all(20),
            children: [Text(e.toString())],
          );
        },
      );
    }
  }

  double calculateAnsweredPercentage() {
    final totalQuestions = questionsWithAnswer.length;
    final answeredQuestions = selectedAnswers.length;
    return (answeredQuestions / totalQuestions) * 100;
  }
}
