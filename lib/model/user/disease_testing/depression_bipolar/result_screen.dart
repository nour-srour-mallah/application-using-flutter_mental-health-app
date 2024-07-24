import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

import '../../../../resources/color-manager.dart';

import '../../../../resources/route.dart';
import '../../../../widgets/result_illness_dont_have.dart';

class ResultDeprission extends StatelessWidget {
  ResultDeprission({super.key});
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    final depressionResult = box.read('depressionBipolar');
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryPanicAttack,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Depression Results
                if (depressionResult != null)
                  if (depressionResult == 'normal')
                    DontHaveIllnesses(
                      heightScreen: heightScreen,
                      name: 'Depression and Bipolar',
                    )
                  else
                    _buildDepressionResultScreen(
                        context, heightScreen, depressionResult),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDepressionResultScreen(
      BuildContext context, double heightScreen, String depressionResult) {
    String depressionMessage;
    switch (depressionResult) {
      case 'Bipolar Type-1':
        depressionMessage = "You suffer from Type 1 Bipolar";
        break;
      case 'Bipolar Type-2':
        depressionMessage = "You suffer from Type 2 Bipolar";
        break;
      case 'Depression':
        depressionMessage = "You suffer from depression";
        break;
      default:
        depressionMessage = "please try test";
    }

    return Center(
      child: Column(
        children: [
          Text(
            depressionMessage,
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
          SizedBox(height: heightScreen * 0.08),
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
          SizedBox(height: heightScreen*0.07,),
        ],
      ),
    );
  }
}
