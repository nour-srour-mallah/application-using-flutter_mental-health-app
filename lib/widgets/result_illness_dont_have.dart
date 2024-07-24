import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../resources/color-manager.dart';
import '../resources/route.dart';

class DontHaveIllnesses extends StatelessWidget {
  double heightScreen;
  final String name;
  DontHaveIllnesses(
      {super.key, required this.heightScreen, required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "You are not suffering from $name",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28,
                color: ColorManager.secondPanicAttack,
                fontWeight: FontWeight.bold),
          ),
          // SizedBox(height: heightScreen * 0.01,),
          Image.asset(
            "assets/images/normal.png",
            fit: BoxFit.cover,
            // height: heightScreen * 0.33,
          ),
          //   SizedBox(height: heightScreen * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              "You do not have any signs of $name. Stay healthy!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: ColorManager.secondPanicAttack,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: heightScreen * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              "If you need, click Choose doctor to get advice from a doctor.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: ColorManager.secondPanicAttack,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: heightScreen * 0.04),
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
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
