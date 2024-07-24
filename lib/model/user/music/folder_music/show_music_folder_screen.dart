import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/color-manager.dart';
import '../../../../widgets/music_card_show_item.dart';
import '../music_modle.dart';
import '../music_player/music_player_screen.dart';
import 'show_music_folder_control.dart';

class ShowAllMusicFolder extends StatelessWidget {
  final String folderName;
  final GetListMusicFolderController musicController;

  ShowAllMusicFolder({super.key, required this.folderName})
      : musicController =
            Get.put(GetListMusicFolderController(folderName: folderName));

  final int currentMusic = 0;
  final player = AudioPlayer();
  final bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorManager.primaryPanicAttack,
      appBar: AppBar(
        title: const Text(
          "All Music",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Pacifico",
          ),
        ),
        backgroundColor: ColorManager.appBarPanicAttack,
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: musicController.musics.length,
          itemBuilder: (context, index) {
            MusicModel music = musicController.musics[index];
            return InkWell(
              onTap: () async {
                try {
                  String musicUrl =
                      await musicController.getMusicFileUrl(music.musicUrl);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MusicPlayer(
                        index: index,
                        music: music,
                        musicUrl: musicUrl,
                        musics: musicController.musics,
                      ),
                    ),
                  );
                } catch (e) {
                  print('Error fetching music URL: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to load music')),
                  );
                }
              },
              child: ItemCardShowMusic(
                index: index,
                music: music,
                heightScreen: heightScreen,
              ),
            );
          },
        ),
      ),
    ));
  }
}
