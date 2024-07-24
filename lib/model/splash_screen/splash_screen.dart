import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/color-manager.dart';
import '../sign_in/sign_in_screen.dart';

class SplahScreen extends StatelessWidget {
  const SplahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorManager.primaryBase,
            body: AnimatedSplashScreen(
              backgroundColor: ColorManager.primaryBase,
              splash: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: heightScreen * 0.15,
                  ),
                  Image.asset(
                    "assets/images/logo.png",
                    height: heightScreen * 0.4,
                  ),
                  Image.asset("assets/images/selene.png",
                      height: heightScreen * 0.07),
                  Lottie.asset(
                    "assets/imageJson/loading.json",
                    fit: BoxFit.cover,
                  )
                ],
              )),
              nextScreen: SignInScreen(),
              splashTransition: SplashTransition.fadeTransition,
              duration: 5000,
              splashIconSize: 700,
            )));
  }
}
