import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../resources/color-manager.dart';

class ShowResultScreen extends StatelessWidget {
  ShowResultScreen({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final depressionResult = box.read('depression');
    final panicAttackResult = box.read('panicAttack');

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
                if (depressionResult != null)
                  if (depressionResult == 'normal')
                    _buildNormalResultScreen(context, heightScreen)
                  else
                    _buildDepressionResultScreen(
                        context, heightScreen, depressionResult),
                if (panicAttackResult != null)
                  _buildPanicAttackResultScreen(context, heightScreen),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNormalResultScreen(BuildContext context, double heightScreen) {
    return Center(
      child: Column(
        children: [
          Text(
            "You are normal",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28,
                color: ColorManager.secondPanicAttack,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: heightScreen * 0.06,
          ),
          SizedBox(
            child: Image.asset(
              "assets/images/normal.png",
              fit: BoxFit.cover,
           //   height: heightScreen * 0.33,
            ),
          ),
          SizedBox(
            height: heightScreen * 0.05,
          ),
          Text(
            "You do not have any signs of depression. Stay healthy!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 23,
                color: ColorManager.secondPanicAttack,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildDepressionResultScreen(
      BuildContext context, double heightScreen, String depressionResult) {
    String depressionMessage;
    switch (depressionResult) {
      case 'Bipolar Type-1':
        depressionMessage = "You suffer from Type 1 depression.";
        break;
      case 'Bipolar Type-2':
        depressionMessage = "You suffer from Type 2 depression.";
        break;
      case 'Depression':
        depressionMessage = "You suffer from depression.";
        break;

      default:
        depressionMessage = "You suffer from depression.";
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
          SizedBox(
            height: heightScreen * 0.06,
          ),
          SizedBox(
            child: Image.asset(
              "assets/images/help.png",
              fit: BoxFit.cover,
           //   height: heightScreen * 0.33,
            ),
          ),
          SizedBox(
            height: heightScreen * 0.05,
          ),
          Text(
            "But do not worry, we can help you with treatment for this disease. Click Choose doctor for help.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 23,
                color: ColorManager.secondPanicAttack,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: heightScreen * 0.05,
          ),


        ],
      ),
    );
  }

  Widget _buildPanicAttackResultScreen(
      BuildContext context, double heightScreen) {
    return Center(
        child: Column(
        children: [
        Text(
        "You suffer from panic attack",
        textAlign: TextAlign.center,
        style: TextStyle(
        fontSize: 28,
            color: ColorManager.secondPanicAttack,
            fontWeight: FontWeight.bold),
        ),
          SizedBox(
            height: heightScreen * 0.06,
          ),
          SizedBox(
            child: Image.asset(
              "assets/images/help.png",
              fit: BoxFit.cover,
             // height: heightScreen * 0.33,
            ),
          ),
          SizedBox(
            height: heightScreen * 0.05,
          ),
          Text(
            "But do not worry, we can help you with treatment for this disease. Click Choose doctor for help..",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 23,
                color: ColorManager.secondPanicAttack,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: heightScreen*0.07,),
        ],

        ),
    );
  }
}
