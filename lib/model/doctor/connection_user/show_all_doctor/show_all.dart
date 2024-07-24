import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../resources/route.dart';
import '../../../../resources/color-manager.dart';
import '../../../../widgets/widget_doctor/card_show_user.dart';
import '../../../user/chat/model_chat.dart';
import 'show_all_controller.dart';
import 'package:get_storage/get_storage.dart';

class ShowUserConn extends StatelessWidget {
   ShowUserConn({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    final box = GetStorage();

    final control = Get.put(ShowUserController(), permanent: true);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryBase,
        appBar: AppBar(
          title: const Text(
            "All User",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Pacifico",
            ),
          ),
          backgroundColor: ColorManager.appBarBase,
          centerTitle: true,
        ),
        body: Obx(
          () {
            if (control.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (control.hasError.value) {
              return Center(
                child: Text("Error occurred while fetching data"),
              );
            } else {
              final userList = control.userList;
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final user = userList[index];
                  return InkWell(
                    onTap: () {
                      AuthController.logout();
                      box.write('DocName',
                          '${user['first_name']} ${user['last_name']}');
                      box.write('currentDoc', '${user['email']}');
                      box.write('UserBirth', '${user['birth']}');
                      box.write('UserGender', '${user['gender']}');

                      Get.toNamed(Routes.getChatRoute());
                      // Handle onTap
                    },
                    child: ShowUser(
                      firstName: user['first_name'],
                      lastName: user['last_name'],
                      email: user['email'],
                      birth: user['birth'],
                      gender: user['gender'],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
