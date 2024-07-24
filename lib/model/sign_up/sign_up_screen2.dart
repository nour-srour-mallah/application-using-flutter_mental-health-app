import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../resources/color-manager.dart';
import '../../resources/route.dart';

import '../../widgets/icon_sign.dart';
import '../../widgets/radio_button_gender.dart';
import '../../widgets/text_field_sign.dart';
import '../sign_in/validation-controller.dart';
import 'sign_up_controller.dart';

class SignUpScreenTwo extends StatelessWidget {
  SignUpScreenTwo({
    super.key,
  });
  final controll = Get.put(ValidateController(), permanent: true);
  final cont = Get.put(SignUpController(), permanent: true);

  final GlobalKey<FormState> SignUpFormKey2 = GlobalKey<FormState>();
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
          backgroundColor: ColorManager.primaryBase,
          // resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Expanded(
                child: Form(
                  key: SignUpFormKey2,
                  child: ListView(
                    children: [
                      IconSign(
                        heightScreen: heightScreen,
                        text: "sign up",
                      ),
                      SizedBox(
                        height: heightScreen * 0.05,
                      ),
                      TextFieldSign(
                        icon: Icons.flag_circle,
                        hint: "enter your country",
                        validator: (country) =>
                            controll.ValidateCountry(country),
                        controller: cont.countryController,
                      ),
                      SizedBox(
                        height: heightScreen * 0.02,
                      ),
                      TextFieldBirth(),
                      SizedBox(
                        height: heightScreen * 0.03,
                      ),
                      TextFieldSign(
                        icon: Icons.lock,
                        hint: "enter your password",
                        validator: (password) =>
                            controll.ValidatePassword(password),
                        controller: cont.passwordController,
                      ),
                      SizedBox(
                        height: heightScreen * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RadioButtonGender(
                            value: "m",
                            title: "Male",
                          ),
                          RadioButtonGender(
                            value: "f",
                            title: "Female",
                          )
                        ],
                      ),
                      SizedBox(
                        height: heightScreen * 0.03,
                      ),
                      SizedBox(
                        height: heightScreen * 0.03,
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
                            //   cont.postDataSignUp();
                            //to validate
                            await controll.onSignUp(SignUpFormKey2);

                            // Check if successful move sign in
                            if (SignUpFormKey2.currentState!.validate()) {
                              cont.postDataSignUp();
                              Get.defaultDialog(
                                titlePadding: EdgeInsets.all(10),
                                backgroundColor: ColorManager.elementBase,
                                title: 'active the account',
                                content: const Text(
                                    'check your emails to active the account'),
                                contentPadding: EdgeInsets.all(10),
                                textConfirm: 'ok',
                                confirmTextColor: Colors.white,
                                buttonColor: ColorManager.buttonBase,
                                onConfirm: () {
                                  Get.offNamed(Routes.getSignInRoute());
                                },
                              );
                            }
                          },
                          child: Text(
                            'sign up',
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
                            "Already have an account ? ",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          InkWell(
                            child: Text(
                              'sign in',
                              style: TextStyle(fontSize: 16),
                            ),
                            onTap: () {
                              Get.toNamed(Routes.getSignInRoute());
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: heightScreen * 0.15,
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
