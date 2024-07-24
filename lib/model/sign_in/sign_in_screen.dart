import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:juniorselene/model/sign_up/sign_up_controller.dart';

import '../../resources/color-manager.dart';
import '../../resources/route.dart';
//import 'package:get_storage/get_storage.dart';
import '../../widgets/icon_sign.dart';
import '../../widgets/text_field_sign.dart';
import 'my_doc.dart';
import 'sign_in_controll.dart';
import 'validation-controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final box = GetStorage();
  final controller = Get.put(ValidateController(), permanent: true);
  final GlobalKey<FormState> SignInFormKey = GlobalKey<FormState>();
  final cont = Get.put(SignInController(), permanent: true);
  final control = Get.put(ShowDocController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          //  resizeToAvoidBottomInset: false,
          backgroundColor: ColorManager.primaryBase,
          body: Column(
            children: [
              Expanded(
                child: Form(
                  key: SignInFormKey,
                  child: ListView(
                    children: [
                      IconSign(
                        heightScreen: heightScreen,
                        text: "sign in",
                      ),
                      SizedBox(
                        height: heightScreen * 0.1,
                      ),
                      TextFieldSign(
                        icon: Icons.email,
                        hint: "enter your email",
                        validator: (email) => controller.ValidateEmail(email),
                        controller: cont.emailController,
                      ),
                      SizedBox(
                        height: heightScreen * 0.04,
                      ),
                      TextFieldSign(
                        icon: Icons.lock,
                        hint: "enter your password",
                        validator: (password) =>
                            controller.ValidatePassword(password),
                        controller: cont.passwordController,
                      ),
                      SizedBox(
                        height: heightScreen * 0.08,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 120),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.buttonBase,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () async {
                            print("Email: ${cont.emailController.text}");
                            print("Password: ${cont.passwordController.text}");

                            if (SignInFormKey.currentState!.validate()) {
                              bool isSuccess = await cont.postDataSignIn();

                              if (isSuccess != null && isSuccess) {
                                if (GetStorage().read('type') == "patient") {
                                  await cont.postKnowIllnesses();
                                  print(
                                      "Have illness (before check): ${GetStorage().read('have_illness')}");

                                  bool haveIllness =
                                      GetStorage().read('have_illness') ==
                                          "true";
                                  print(
                                      "Have illness (after check): $haveIllness");

                                  if (haveIllness) {
                                    print("Navigating to home Route");
                                    Get.offNamed(Routes.getHomeRoute());
                                  } else if (GetStorage().read('currentDoc') ==
                                      "") {
                                    print("Navigating to select doctor Route");
                                    Get.offNamed(
                                        Routes.getShowAllDoctorRoute());
                                  } else {
                                    print("Navigating to quiz Route");
                                    Get.offNamed(Routes.getQuizRoute());
                                  }
                                } else if (GetStorage().read('type') ==
                                    "doctor") {
                                  Get.offNamed(Routes.getHomeDoctorRoute());
                                } else {
                                  Get.snackbar(
                                    "Error",
                                    "Unexpected user type.",
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white,
                                    backgroundColor:
                                        Color.fromARGB(255, 190, 83, 83),
                                  );
                                }
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Login failed. Please try again.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white,
                                  backgroundColor:
                                      Color.fromARGB(255, 190, 83, 83),
                                );
                              }
                            } else {
                              Get.snackbar(
                                "Error",
                                "Login Validation failed. Please try again.",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                backgroundColor:
                                    Color.fromARGB(255, 190, 83, 83),
                              );
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: heightScreen * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "don't have an account ? ",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          InkWell(
                            child: Text(
                              'sign up',
                              style: TextStyle(fontSize: 16),
                            ),
                            onTap: () {
                              Get.toNamed(Routes.getSignUpRoute());
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: heightScreen * 0.02,
                      ),
                      SizedBox(
                        height: heightScreen * 0.22,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: SizedBox(
                                width: widthScreen,
                                child: Image.asset(
                                  "assets/images/3.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: SizedBox(
                                width: widthScreen,
                                child: Image.asset(
                                  "assets/images/4.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
