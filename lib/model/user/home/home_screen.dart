import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../resources/color-manager.dart';
import '../../../resources/route.dart';

import '../../../widgets/bottom-navigation-bar.dart';
import '../../../widgets/container-home-wedgit.dart';
import '../../../widgets/navigation_drawer_widget.dart';

import 'home_screen_control.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final controller = Get.put(HomeControll(), permanent: true);
  @override
  Widget build(BuildContext context) {
    String url =
        "https://selene-m-h.up.railway.app/users/upload_photo/${GetStorage().read('email')}";

    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryPanicAttack,
        appBar: AppBar(
          title: const Text(
            "Home Page",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Shrikhand",
            ),
          ),
          backgroundColor: ColorManager.appBarPanicAttack,
          centerTitle: true,
        ),
        drawer: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: Drawer(
            child: Material(
              color: ColorManager.secondPanicAttack,
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
                    onClicked: () => controller.SelectedItem(context, 0),
                  ),
                  SizedBox(
                    height: heightScreen * 0.01,
                  ),
                  MenuItem(
                    text: 'Retest for the disease',
                    icon: Icons.restart_alt,
                    onClicked: () => controller.SelectedItem(context, 1),
                  ),
                  SizedBox(
                    height: heightScreen * 0.01,
                  ),
                  MenuItem(
                    text: 'Log out',
                    icon: Icons.logout,
                    onClicked: () => controller.SelectedItem(context, 2),
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
                    onClicked: () => controller.SelectedItem(context, 3),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.getShowAllDoctorRoute());
                },
                child: ContainerHomeWedgit(
                  heightScreen: heightScreen,
                  widthScreen: widthScreen,
                  img: "connectdoctor",
                  text1: "Change Doctor",
                  text2: " ",
                ),
              ),
              SizedBox(
                height: heightScreen * 0.01,
              ),

              // Music
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.getMusicHomeRoute());
                },
                child: ContainerHomeWedgit(
                  heightScreen: heightScreen,
                  widthScreen: widthScreen,
                  img: "listenmusic",
                  text1: "Listen Music",
                  text2: "TO Take Care Of Your Mind",
                ),
              ),
              SizedBox(
                height: heightScreen * 0.01,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.getToDoRoute());
                },
                child: ContainerHomeWedgit(
                  heightScreen: heightScreen,
                  widthScreen: widthScreen,
                  img: "dolist",
                  text1: "Do Challenges",
                  text2: "Complete the required tasks",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
