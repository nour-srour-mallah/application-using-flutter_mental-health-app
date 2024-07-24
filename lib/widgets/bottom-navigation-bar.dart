import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:get/get.dart';
import '../resources/color-manager.dart';
import '../resources/route.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: ColorManager.secondPanicAttack,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: GNav(
          backgroundColor: ColorManager.secondPanicAttack,
          color: ColorManager.white,
          activeColor: ColorManager.buttonBase,
          tabBackgroundColor: ColorManager.primaryPanicAttack,
          padding: EdgeInsets.all(16),
          gap: 8,
          tabs: [
            GButton(
              gap: 8,
              icon: Icons.music_note,
              text: 'music',
            ),
            GButton(
              gap: 8,
              icon: Icons.forum,
              text: 'chat',
            ),
            GButton(
              gap: 8,
              icon: Icons.task,
              text: 'to do',
            ),
            GButton(
              gap: 8,
              icon: Icons.home,
              text: 'home',
            ),
          ],
          onTabChange: (index) {
            switch (index) {
              case 0:
                Get.toNamed(Routes.getMusicHomeRoute());
                break;
              case 1:
                Get.toNamed(Routes.getChatRoute());
                break;
              case 2:
                Get.toNamed(Routes.getToDoRoute());
                break;
              case 3:
                Get.toNamed(Routes.getHomeRoute());
                break;
            }
          },
        ),
      ),
    );
  }
}
