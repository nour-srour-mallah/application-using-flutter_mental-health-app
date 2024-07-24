import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../resources/color-manager.dart';
import 'home_music_controller.dart';
import 'quran_player.dart';

class ShowAllQuran extends StatelessWidget {
  const ShowAllQuran({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeMusicController homeController = Get.put(HomeMusicController());
    final player = AudioPlayer();

    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryPanicAttack,
        appBar: AppBar(
          title: Text(
            "all",
            style: TextStyle(fontSize: 20, fontFamily: "Pacifico"),
          ),
          backgroundColor: ColorManager.appBarPanicAttack,
          centerTitle: true,
        ),
        body: Obx(
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
                padding: const EdgeInsets.all(8.0),
                itemCount: homeController.surahList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      String surahName = homeController.surahList[index];
                      String? audioUrl = await homeController.getQuranUrl(surahName);
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
                          SnackBar(content: Text('Failed to load audio URL')),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: ColorManager.elementPanicAttack,
                        image: DecorationImage(
                          image: AssetImage("assets/images/qq.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: heightScreen * 0.25,
                            width: widthScreen * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 105, left: 45,bottom: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color.fromARGB(201, 255, 255, 255),
                                ),
                                child: Center(
                                  child: Text(
                                    homeController.surahList[index],
                                    style: TextStyle(fontSize: widthScreen * 0.06, fontWeight: FontWeight.bold),
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
    );
  }
}
