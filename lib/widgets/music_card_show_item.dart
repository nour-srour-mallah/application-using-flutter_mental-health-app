import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/user/music/music_modle.dart';
import '../model/user/music/music_player/music_player_screen.dart';
import '../model/user/music/show_music/show_all_music_controller.dart';
import '../resources/color-manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCardShowMusic extends StatelessWidget {
  final GetListMusicController musicController = Get.find<GetListMusicController>();
  final int index;
  final MusicModel music;
  final double heightScreen;

  ItemCardShowMusic({
    Key? key,
    required this.heightScreen,
    required this.index,
    required this.music,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
            child: SizedBox(
              height: heightScreen * 0.1,
              child: Card(
                color: ColorManager.elementPanicAttack,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    leading: SizedBox(
                      height: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: Image.asset("assets/images/music.jpg",
                          fit: BoxFit.cover,

                          height: heightScreen * 0.1,
                        ),
                      ),
                    ),
                    title: Text(
                      music.musicName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),     overflow: TextOverflow.clip,
                    ),
                    trailing: Icon(
                      Icons.queue_music,
                      size: 35,
                    ),
                    onTap: () async {
                      try {
                        String musicUrl = await musicController.getMusicFileUrl(music.musicUrl);
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../model/user/music/music_modle.dart';
// import '../model/user/music/show_music/show_all_music_controller.dart';
// import '../resources/color-manager.dart';
//
// class ItemCardShowMusic extends StatelessWidget {
//   final GetListMusicController MusicController =
//       Get.find<GetListMusicController>();
//   final int index;
//   final MusicModel music;
//
//   final double heightScreen;
//
//   ItemCardShowMusic({
//     Key? key,
//     required this.heightScreen,
//     required this.index,
//     required this.music,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     MusicModel music = MusicController.musics[index];
//     return Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
//             child: SizedBox(
//               height: heightScreen * 0.1,
//               child: Card(
//                 color: ColorManager.elementPanicAttack,
//                 child: ListTile(
//                   leading: SizedBox(
//                     height: double.infinity,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                         child: Image(
//                           image: NetworkImage(
//                               "https://www.udiscovermusic.com/wp-content/uploads/2020/12/relaxingMusic_Facebookimage.jpg"),
//                           fit: BoxFit.cover,
//                           height: heightScreen * 0.1,
//                         )),
//                   ),
//                   title: Text(
//                     music.musicName,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//
//                   trailing: Icon(
//                     Icons.trending_flat,
//                     size: 35,
//                   ),
//                   // onTap: () {
//                   //   Get.toNamed(Routes.getPlayerMusicRoute());
//                   // },
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
