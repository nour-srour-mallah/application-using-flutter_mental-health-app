import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resources/color-manager.dart';
import '../../resources/route.dart';
import '../../widgets/icon_sign.dart';
import '../../widgets/text_field_sign.dart';
import '../sign_in/validation-controller.dart';
import 'sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final control = Get.put(ValidateController(), permanent: true);
  final cont = Get.put(SignUpController(), permanent: true);
  final GlobalKey<FormState> SignUpFormKey = GlobalKey<FormState>();
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
                  key: SignUpFormKey,
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
                        icon: Icons.person,
                        hint: "enter your first name",
                        validator: (fname) => control.ValidateFname(fname),
                        controller: cont.fnameController,
                      ),
                      SizedBox(
                        height: heightScreen * 0.03,
                      ),
                      TextFieldSign(
                        icon: Icons.person,
                        hint: "enter your last name",
                        validator: (lname) => control.ValidateLname(lname),
                        controller: cont.lnameController,
                      ),
                      SizedBox(
                        height: heightScreen * 0.03,
                      ),
                      TextFieldSign(
                        icon: Icons.email,
                        hint: "enter your email",
                        validator: (email) => control.ValidateEmail(email),
                        controller: cont.emailController,
                      ),
                      SizedBox(
                        height: heightScreen * 0.08,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 105),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.buttonBase,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              minimumSize: Size.fromHeight(50),
                            ),
                            onPressed: () async {
                              //to validate
                              await control.onQuestions(SignUpFormKey);

                              // Check if successful
                              if (SignUpFormKey.currentState!.validate()) {
                                Get.offNamed(Routes.getSignUpTwoRoute());
                              }
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: widthScreen * 0.02,
                                ),
                                Text(
                                  "next questiones",
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(
                                  width: widthScreen * 0.025,
                                ),
                                Icon(Icons.navigate_next_outlined)
                              ],
                            )),
                      ),
                      SizedBox(
                        height: heightScreen * 0.02,
                      ),
                      SizedBox(
                        height: heightScreen * 0.20,
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
