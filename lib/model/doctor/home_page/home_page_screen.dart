import 'package:flutter/material.dart';
import 'navigation_drawer.dart';
import 'package:get/get.dart';

import '../../../resources/color-manager.dart';
import '../../../resources/route.dart';
import '../../../widgets/widget_doctor/container-home-wedgit.dart';
import 'package:get_storage/get_storage.dart';

class HomeDoctorScreen extends StatelessWidget {
  HomeDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url =
        "https://selene-m-h.up.railway.app/users/upload_photo/${GetStorage().read('email')}";
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryBase,
        drawer: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: Drawer(
            child: Material(
              color: ColorManager.buttonBase,
              child: ListView(
                children: <Widget>[
                  HeaderDrawer(
                    img: Image.network(url).toString(),
                    name: GetStorage().read('first_name'),
                    email: GetStorage().read('email'),
                  ),
                  SizedBox(
                    height: heightScreen * 0.02,
                  ),
                  MenuItem(
                    text: 'Edit my profile',
                    icon: Icons.person,
                    onClicked: () {
                      Get.toNamed(Routes.getUpdateProfileRoute());
                    },
                  ),
                  SizedBox(
                    height: heightScreen * 0.01,
                  ),
                  MenuItem(
                    text: 'Log out',
                    icon: Icons.logout,
                    onClicked: () {
                      final box = GetStorage();
                      box.erase();
                      Get.offAllNamed(Routes.getSignInRoute());
                    },
                  ),
                  SizedBox(
                    height: heightScreen * 0.02,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: const Divider(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: heightScreen * 0.01,
                  ),
                  MenuItem(
                    text: 'About application',
                    icon: Icons.info_outline,
                    onClicked: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            "Home Page",
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Pacifico",
            ),
          ),
          backgroundColor: ColorManager.appBarBase,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                child: ContainerHomeDocWedgit(
                  heightScreen: heightScreen,
                  widthScreen: widthScreen,
                  img: "chat",
                  text1: "Contact Patients To",
                  text2: "Provide Assistance",
                ),
                onTap: () {
                  Get.toNamed(Routes.geAllUserRoute());
                },
              ),
              SizedBox(
                height: heightScreen * 0.01,
              ),
              InkWell(
                child: ContainerHomeDocWedgit(
                  heightScreen: heightScreen,
                  widthScreen: widthScreen,
                  img: "task",
                  text1: "Provide Mission To",
                  text2: "Improve The condition Of Patients",
                ),
                onTap: () {
                  Get.toNamed(Routes.geAddTaskRoute());
                },
              ),
              SizedBox(
                height: heightScreen * 0.01,
              ),
              InkWell(
                child: ContainerHomeDocWedgit(
                  heightScreen: heightScreen,
                  widthScreen: widthScreen,
                  img: "listen",
                  text1: "Generate Music To",
                  text2: "Make A Patient Feel Better",
                ),
                onTap: () {
                  Get.toNamed(Routes.getGenerateMusicRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
