// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'package:http/http.dart' as http;
//
// import '../music_modle.dart';
//
// class GetListMusicController extends GetxController {
//   final String apiUrl = "http://127.0.0.1:8000/music/get_music";
//
//   Future<void> getFileAudio() async {
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, dynamic>{"url": musicUrls}),
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//       } else {
//         throw Exception('Failed ,try again');
//       }
//     } catch (e) {
//       Get.back();
//       showDialog(
//           context: Get.context!,
//           builder: (context) {
//             return SimpleDialog(
//               title: Text('Error'),
//               contentPadding: EdgeInsets.all(20),
//               children: [Text(e.toString())],
//             );
//           });
//     }
//   }
// }
//
//
//
//
//
//
//
// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:audioplayers/audioplayers.dart';
// // import '../../../resources/color-manager.dart';
// // import '../music_modle.dart';
//
// // class MusicPlayerController {
// //   AudioPlayer player;
// //   int index;
//
// //   MusicPlayerController(this.player, this.index);
//
// //   bool isPlaying = false;
// //   Duration duration = Duration.zero;
// //   Duration position = Duration.zero;
//
// //   String formateTime(Duration duration) {
// //     String twoDigits(int n) => n.toString().padLeft(2, '0');
// //     final hours = twoDigits(duration.inHours);
// //     final minutes = twoDigits(duration.inMinutes.remainder(60));
// //     final seconds = twoDigits(duration.inSeconds.remainder(60));
// //     return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
// //   }
//
// //   Future<void> setAudio() async {
// //     try {
// //       player.setReleaseMode(ReleaseMode.loop);
// //       String url = musics[index % musics.length].path;
// //       await player.setSourceUrl(url);
// //     } catch (e) {
// //       print('Error setting audio: $e');
// //     }
// //   }
//
// //   void onInit() {
// //     setAudio();
//
// //     player.onPlayerStateChanged.listen((state) {
// //       isPlaying = state == PlayerState.playing;
// //     });
// //     player.onDurationChanged.listen((newDuration) {
// //       duration = newDuration;
// //     });
// //     player.onPositionChanged.listen((newPosition) {
// //       position = newPosition;
// //     });
// //   }
//
// //   void skipPrevious() {
// //     final newIndex = (index - 1) % musics.length;
// //     final newIndexNormalized = newIndex >= 0 ? newIndex : musics.length - 1;
// //     playNewSong(newIndexNormalized);
// //   }
//
// //   void skipNext() {
// //     final newIndex = (index + 1) % musics.length;
// //     playNewSong(newIndex);
// //   }
//
// //   void playNewSong(int newIndex) {
// //     player.stop();
// //     index = newIndex;
// //     setAudio();
// //   }
// // }
//
//
