import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class HomeMusicController extends GetxController {
  var surahList = <String>[].obs;
  final String apiUrlQuran =
      'https://selene-m-h.up.railway.app/sounds/quran/surahList';
  RxBool loading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await getSurahList();
  }

  Future<void> getSurahList() async {
    print("Fetch Started");

    try {
      final url = Uri.parse(apiUrlQuran);
      final response = await http.get(url).timeout(
        const Duration(seconds: 50000),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      ;

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        surahList.value = List<String>.from(json['surahList']);

        update();
        print("Fetch Completed");
        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      } else {
        print("Failed to load surah list: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      loading.value = false;
    }
  }

  Future<String?> getQuranUrl(String surahName) async {
    final String getUrlQuran =
        'https://selene-m-h.up.railway.app/sounds/quran/surah_audio/$surahName';
    try {
      final response = await http.post(
        Uri.parse(getUrlQuran),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("url post:$getUrlQuran ");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String audio = responseData['audio'];
        print("result url audio is $audio");
        GetStorage()..write(' audio is :', audio);
        return audio;
      } else {
        print('Failed to load audio URL: status code: ${response.statusCode}');
        throw Exception('Failed to load audio URL');
      }
    } catch (e) {
      print('Error occurred: $e');
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
      return null;
    } finally {
      loading.value = false;
    }
  }
}

class NameFolder {
  late String name;
  late String image;
  NameFolder({
    required this.name,
    required this.image,
  });
}

List<NameFolder> folder = [
  NameFolder(name: "depression", image: "depression"),
  NameFolder(name: "stress", image: "stress"),
  NameFolder(name: "panic attack", image: "panic attack")
];
