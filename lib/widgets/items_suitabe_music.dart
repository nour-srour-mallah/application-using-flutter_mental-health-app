import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/user/music/music_modle.dart';
import '../model/user/music/show_music/show_all_music_controller.dart';
import '../resources/color-manager.dart';

class SuitableMusic extends StatelessWidget {
  final GetListMusicController MusicController =
      Get.find<GetListMusicController>();
  final int index;
  final MusicModel music;
  SuitableMusic({key, required this.index, required this.music})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MusicModel music = MusicController.musics[index];
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        color: ColorManager.elementPanicAttack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: SizedBox(
                    height: size.height * 0.18,width: double.infinity,
                    child: Image.asset("assets/images/music.jpg",fit: BoxFit.cover,))),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child:
                            Text(
                              music.musicName,
                                style: TextStyle(
                                    fontSize: size.width * 0.030,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,   ),  overflow: TextOverflow.clip,
                            ),

                      ),
                      // InkWell(
                      //     onTap: () {
                      //       ////// should add to favorite
                      //       print("you press to add  favorite");
                      //     },
                      //     child: Icon(
                      //       Icons.favorite,
                      //       size: 20,
                      //       color: Color.fromARGB(255, 163, 46, 37),
                      //     )),
                    ],
                  ),
                  Row(
                    children: [Spacer(), Text("")],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
