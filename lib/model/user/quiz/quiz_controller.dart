import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

class Question {
  String question;
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  Question({
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
  });
}

List<Question> questionList = [
  Question(
      question: "I felt that I was using a lot of nervous energy",
      answer1: "Did not apply to me at all",
      answer2: "Applied to me to some degree, or some of the time",
      answer3: "Applied to me to a considerable degree, or a good part of time",
      answer4: "Applied to me very much, or most of the time"),
  Question(
      question:
          "I was worried about the situations in which I might panic and make a fool of myself",
      answer1: "Did not apply to me at all",
      answer2: "Applied to me to some degree, or some of the time",
      answer3: "Applied to me to a considerable degree, or a good part of time",
      answer4: "Applied to me very much, or most of the time"),
  Question(
      question: "I felt that I had nothing to look forward to",
      answer1: "Did not apply to me at all",
      answer2: "Applied to me to some degree, or some of the time",
      answer3: "Applied to me to a considerable degree, or a good part of time",
      answer4: "Applied to me very much, or most of the time"),
  Question(
      question: "I found it difficult to relax",
      answer1: "Did not apply to me at all",
      answer2: "Applied to me to some degree, or some of the time",
      answer3: "Applied to me to a considerable degree, or a good part of time",
      answer4: "Applied to me very much, or most of the time"),
  Question(
      question: "I felt down-hearted and blue",
      answer1: "Did not apply to me at all",
      answer2: "Applied to me to some degree, or some of the time",
      answer3: "Applied to me to a considerable degree, or a good part of time",
      answer4: "Applied to me very much, or most of the time"),
  Question(
      question: "I felt I was close to panic",
      answer1: "Did not apply to me at all",
      answer2: "Applied to me to some degree, or some of the time",
      answer3: "Applied to me to a considerable degree, or a good part of time",
      answer4: "Applied to me very much, or most of the time"),
  Question(
      question: "I was unable to become enthusiastic about anything",
      answer1: "Did not apply to me at all",
      answer2: "Applied to me to some degree, or some of the time",
      answer3: "Applied to me to a considerable degree, or a good part of time",
      answer4: "Applied to me very much, or most of the time"),
  Question(
      question: "I felt scared without any good reason",
      answer1: "Did not apply to me at all",
      answer2: "Applied to me to some degree, or some of the time",
      answer3: "Applied to me to a considerable degree, or a good part of time",
      answer4: "Applied to me very much, or most of the time"),
];

////////////////////////////////////////////////////////////////////

class QuizController extends GetxController {
  var currentIndex = 0.obs;
  var a1 = 0.obs;
  var a2 = 0.obs;
  var a3 = 0.obs;
  var a4 = 0.obs;
  var a5 = 0.obs;
  var a6 = 0.obs;
  var a7 = 0.obs;
  var a8 = 0.obs;
  final box = GetStorage();
  bool isRequestSent = false;
  var finalResult = ''.obs;
  final String apiUrl = "https://selene-m-h.up.railway.app:443/ai/firstquiz";

  void nextQuestion() {
    if (currentIndex.value + 1 < questionList.length) {
      currentIndex.value++;
    }
  }

  void selectAnswer(int score) {
    switch (currentIndex.value) {
      case 0:
        a1.value = score;
        break;
      case 1:
        a2.value = score;
        break;
      case 2:
        a3.value = score;
        break;
      case 3:
        a4.value = score;
        break;
      case 4:
        a5.value = score;
        break;
      case 5:
        a6.value = score;
        break;
      case 6:
        a7.value = score;
        break;
      case 7:
        a8.value = score;
        break;
      default:
        break;
    }

    if (currentIndex.value == questionList.length - 1 && !isRequestSent) {
      sendShowResult();
    } else if (currentIndex.value == questionList.length - 1) {
      showResult();
    } else {
      nextQuestion();
    }
  }

  void sendShowResult() {
    if (!isRequestSent) {
      isRequestSent = true;
      postAnswer();
    }
  }

  Future<void> postAnswer() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': box.read('email'),
          'token': box.read('token'),
          'a1': a1.value.toString(),
          'a2': a2.value.toString(),
          'a3': a3.value.toString(),
          'a4': a4.value.toString(),
          'a5': a5.value.toString(),
          'a6': a6.value.toString(),
          'a7': a7.value.toString(),
          'a8': a8.value.toString()
        }),
      );

      print("JSON Data Sent:");
      print(jsonEncode(<String, dynamic>{
        'email': box.read('email'),
        'token': box.read('token'),
        'a1': a1.value.toString(),
        'a2': a2.value.toString(),
        'a3': a3.value.toString(),
        'a4': a4.value.toString(),
        'a5': a5.value.toString(),
        'a6': a6.value.toString(),
        'a7': a7.value.toString(),
        'a8': a8.value.toString()
      }));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final depression = responseData['Depression'];
        final Panic = responseData['Panic'];
        final Bipolar = responseData['Bipolar'];

        box.write('Depression', depression.toString());
        box.write('Panic', Panic.toString());
        box.write('Bipolar', Bipolar.toString());

        print("Depression stored is : ${box.read('Depression')}");
        print("Panic stored is : ${box.read('Panic')}");
        print("Bipolar stored is : ${box.read('Bipolar')}");

        showResult();
      } else {
        throw Exception('Failed, try again');
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
          });
    }
  }

  void showResult() {
    bool Bipolar = box.read('Bipolar') == 'true';
    bool depression = box.read('Depression') == 'true';
    bool Panic = box.read('Panic') == 'true';

    print("Depression is : $depression");
    print("Panic is : $Panic");
    print("Bipolar is : $Bipolar");

    if (Bipolar) {
      finalResult.value = "Bipolar";
    } else if (depression) {
      finalResult.value = "Depression";
    } else if (Panic) {
      finalResult.value = "Panic";
    } else {
      finalResult.value = "Nothing";
    }

    currentIndex.value++;
    box.write('ilnesses', finalResult.value);
    print("the ilnesses is : ${box.read('ilnesses')}");
  }
}
