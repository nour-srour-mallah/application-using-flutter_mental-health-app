import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/color-manager.dart';
import '../resources/route.dart';

class HaveIllnesses extends StatelessWidget {
  double heightScreen;
  final String name;
  HaveIllnesses({super.key, required this.name, required this.heightScreen});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "You suffer from $name",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28,
                color: ColorManager.secondPanicAttack,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: heightScreen * 0.06),
          Image.asset(
            "assets/images/help.png",
            fit: BoxFit.cover,
            height: heightScreen * 0.33,
          ),
          SizedBox(height: heightScreen * 0.05),
          Text(
            "But do not worry, we can help you with treatment for this disease. Click Choose doctor for help.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 23,
                color: ColorManager.secondPanicAttack,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: heightScreen * 0.05),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, 50),
              backgroundColor: ColorManager.secondPanicAttack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Get.offNamed(Routes.getShowAllDoctorRoute());
            },
            child: Text(
              'Choose doctor',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
