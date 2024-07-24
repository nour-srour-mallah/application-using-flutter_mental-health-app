import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../../services/endpoints_api.dart';
import '../music_modle.dart';

class GetListMusicFolderController extends GetxController {
  final String folderName;
  final String apiUrl =
      apiMusic.baseUrlMusic + apiMusic.authEndpoints.getMusicGenerate;
  List<dynamic> musicNames = [];
  List<dynamic> musicUrls = [];
  RxList<MusicModel> musics = <MusicModel>[].obs;
  final box = GetStorage();

  GetListMusicFolderController({required this.folderName});

  @override
  void onInit() {
    super.onInit();
    getListMusic();
  }

  Future<void> getListMusic() async {
    try {
      print("Start get music with doctor");
      final response = await http.post(
        Uri.parse(
            "https://selene-m-h.up.railway.app:443/sounds/music/get_folder_list"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "folder_name": folderName,
        }),
      );
print("show list folder");
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        final responseData = jsonDecode(response.body);

        musicNames = responseData['music_names'];
        musicUrls = responseData['music_urls'];
        musics.assignAll(
          List.generate(
            musicNames.length,
            (index) => MusicModel(
              musicName: musicNames[index],
              musicUrl: musicUrls[index],
            ),
          ),
        );
        box.write('musicName', musicNames);
        box.write('musicUrl', musicUrls);
      } else {
        throw Exception('Failed to load music list');
      }
    } catch (e) {
      print("Error: $e");
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

  Future<String> getMusicFileUrl(String url) async {
    try {
      final response = await http.post(
        Uri.parse("https://selene-m-h.up.railway.app/sounds/music/get_music"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{"url": url}),
      );

      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final filePath =
            '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.flac';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        print("Music file saved at: $filePath");
        return filePath;
      } else {
        throw Exception('Failed to fetch music file');
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}
