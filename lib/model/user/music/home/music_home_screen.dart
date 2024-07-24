import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../resources/color-manager.dart';
import '../../../../resources/route.dart';
import '../../../../widgets/app-bar.dart';
import '../../../../widgets/items_suitabe_music.dart';
import '../../../../widgets/section_header.dart';
import '../folder_music/show_music_folder_screen.dart';
import '../music_modle.dart';
import '../music_player/music_player_screen.dart';
import '../show_music/show_all_music_controller.dart';
import 'home_music_controller.dart';
import 'quran_player.dart';
import 'package:lottie/lottie.dart';

class MusicHomeScreen extends StatelessWidget {
  MusicHomeScreen({Key? key}) : super(key: key);

  final GetListMusicController musicController =
      Get.put(GetListMusicController());
  final HomeMusicController homeController = Get.put(HomeMusicController());
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryPanicAttack,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBarMusic(heightScreen: heightScreen),
              SizedBox(height: heightScreen * 0.01),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.getQuranRoute());
                },
                child: const SectionHeader(title: "listen quran"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: heightScreen * 0.2,
                  child: Obx(
                    () {
                      if (homeController.loading.value) {
                        return Center(
                          child: Lottie.asset(
                            "assets/imageJson/loading.json",
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeController.surahList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                String surahName =
                                    homeController.surahList[index];
                                String? audioUrl =
                                    await homeController.getQuranUrl(surahName);
                                if (audioUrl != null && audioUrl.isNotEmpty) {
                                  print("URL is : $audioUrl");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuranPlayer(
                                        surahName: surahName,
                                        audioUrl: audioUrl,
                                      ),
                                    ),
                                  );
                                } else {
                                  print('Audio URL is null or empty');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Failed to load audio URL')),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: ColorManager.elementPanicAttack,
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/qq.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: widthScreen * 0.5,
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: heightScreen * 0.18,
                                      width: widthScreen * 0.45,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 100, left: 28),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color.fromARGB(
                                                201, 255, 255, 255),
                                          ),
                                          child: Center(
                                            child: Text(
                                              homeController.surahList[index],
                                              style: TextStyle(
                                                fontSize: widthScreen * 0.035,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              ////////////////////////////////////////////////////////////////////////
              //folder
              SizedBox(height: heightScreen * 0.03),
              GestureDetector(
                child: SectionHeader(title: "folder music"),
                onTap: () {
                  // Get.to(() => ShowAllMusicFolder(folderName: folderName));
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: heightScreen * 0.28,
                  child: CarouselSlider.builder(
                    itemCount: folder.length,
                    options: CarouselOptions(
                      height: heightScreen * 0.5,
                      aspectRatio: 16 / 10,
                      viewportFraction: 0.5,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    itemBuilder: (context, index, realIndex) {
                      final folderItem = folder[index];
                      final imageName = folderItem.name == "panic attack" ? "panic" : folderItem.image;

                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ShowAllMusicFolder(folderName: folderItem.name));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            color: ColorManager.elementPanicAttack,
                          ),
                          width: widthScreen * 0.5,
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: SizedBox(
                                  height: heightScreen * 0.22,
                                  width: double.infinity,
                                  child: Image.asset(
                                    "assets/images/$imageName.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: heightScreen * 0.018),
                              Text(
                                folderItem.name,
                                style: TextStyle(
                                  fontFamily: "Assistant",
                                  fontWeight: FontWeight.w600,
                                  fontSize: widthScreen * 0.037,
                                ),
                              ),
                              SizedBox(height: heightScreen * 0.002),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              //////////////////////////////////////////////////////suitable
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.getShowAllMusicRoute());
                },
                child: SectionHeader(title: "suitable music"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: musicController.musics.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      MusicModel music = musicController.musics[index];
                      return GestureDetector(
                        onTap: () async {
                          try {
                            String musicUrl = await musicController
                                .getMusicFileUrl(music.musicUrl);
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
                        child: SuitableMusic(
                          music: music,
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: heightScreen * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
