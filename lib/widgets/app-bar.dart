import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../resources/route.dart';
import '../resources/color-manager.dart';

class AppBarMusic extends StatefulWidget {
  const AppBarMusic({
    super.key,
    required this.heightScreen,
  });

  final double heightScreen;

  @override
  State<AppBarMusic> createState() => _AppBarMusicState();
}

class _AppBarMusicState extends State<AppBarMusic> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.heightScreen * 0.25,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          color: ColorManager.secondPanicAttack,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 150, left: 15),
              child: InkWell(
                child: CircleAvatar(
                  backgroundColor: ColorManager.primaryPanicAttack,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: ColorManager.secondPanicAttack,
                  ),
                ),
                onTap: () {
                  Get.offNamed(Routes.getHomeRoute());
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: SizedBox(
                  height: widget.heightScreen * 0.20,
                  child: Image.asset(
                    "assets/images/music.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
