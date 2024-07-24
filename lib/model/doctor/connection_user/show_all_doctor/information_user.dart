import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../resources/color-manager.dart';
import '../../../../resources/route.dart';
import '../../../../services/endpoints_api.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final box = GetStorage();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String get imageUrl {
    final docId = GetStorage().read('currentDoc');
    return apiEndpoints.baseUrl + apiEndpoints.authEndpoints.getPhoto + "/$docId";
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryBase,
        appBar: AppBar(
          elevation: 0.32,
          title: const Text(
            "Patient Information",
            style: TextStyle(
              fontSize: 23,
              fontFamily: "Pacifico",
            ),
          ),
          backgroundColor: ColorManager.appBarBase,
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: heightScreen * 0.2,
                  decoration: BoxDecoration(
                    color: ColorManager.appBarBase,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: CircleAvatar(
                      backgroundColor: ColorManager.appBarBase,
                      radius: 70,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: ColorManager.primaryBase,
                        child: ClipOval(
                          child: _image != null
                              ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            width: 130,
                            height: 130,
                          )
                              : Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: 130,
                            height: 130,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heightScreen * 0.01),
            Center(
              child: Text(
                GetStorage().read('DocName') ?? 'Doctor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: ColorManager.buttonBase,
                ),
              ),
            ),
            SizedBox(height: heightScreen * 0.05),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                border: TableBorder.all(color: Colors.grey[300]!),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          "Patient Name: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          GetStorage().read("DocName") ?? 'N/A',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          "Patient Email: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          GetStorage().read("currentDoc") ?? 'N/A',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          "Patient Gender: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          GetStorage().read("UserGender") == 'f' ? "Female" : "Male",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          "Patient Birthday: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Text(
                          GetStorage().read("UserBirth") ?? 'N/A',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: heightScreen*0.07,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.buttonBase,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(widthScreen * 0.5, heightScreen * 0.06),
                ),
                onPressed: () {
                  Get.toNamed(Routes.getMoreInfoRoute());
                },
                child: const Text(
                  'Medical Information',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.buttonBase,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(widthScreen * 0.5, heightScreen * 0.06),
                ),
                onPressed: () {
                  Get.toNamed(Routes.getChatRoute());
                },
                child: const Text(
                  'Patient Conversation',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

