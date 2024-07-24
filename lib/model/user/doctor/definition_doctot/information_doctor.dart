import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get_storage/get_storage.dart';

import '../../../../services/endpoints_api.dart';
import 'package:flutter/material.dart';

import '../../../../resources/color-manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../resources/route.dart';
import '../../../../widgets/doctor_person_information.dart';
import '../../../../widgets/section_info_doctor.dart';
import 'information_doctor_controller.dart';

class DoctorInformation extends StatefulWidget {
  const DoctorInformation({super.key});
  @override
  State<DoctorInformation> createState() => _DoctorInformationState();
}

class _DoctorInformationState extends State<DoctorInformation> {
  final box = GetStorage();
  final url = apiEndpoints.baseUrl +
      apiEndpoints.authEndpoints.getPhoto +
      "/${GetStorage().read('currentDoc')}";
  final controller = Get.put(RatingController());

  //to make review doctor
  Widget _buildBody(RatingController controller) {
    final stars = List<Widget>.generate(5, (index) {
      return GetBuilder<RatingController>(
        builder: (controller) => GestureDetector(
          child: controller.buildRatingStar(index),
          onTap: () {
            controller.updateAndStoreRating(index + 1);
          },
        ),
      );
    });

    return SizedBox(
      height: 100, // Set a fixed height here as an example
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: stars,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.secondPanicAttack,
                    fixedSize: const Size.fromWidth(100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    controller.updateAndStoreRating(0);
                  },
                  child: const Text(
                    'clear',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.secondPanicAttack,
                    fixedSize: const Size.fromWidth(100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    print(controller.currentRating);
                    controller.postRate();
                  },
                  child: const Text(
                    'save',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

///////////

  File? file;
  Uint8List? bytes;

  String fName = '';
  String lName = '';
  String email = '';
  String rate = '';
  String photo = '';
  Future<void> fetchData() async {
    try {
      var headers = {
        'content-type': "application/json",
        'accept': "application/json",
        //'Authorization':"Bearer $token"
      };

      var apiEndpoints;
      final url = apiEndpoints.baseUrl +
          apiEndpoints.authEndpoints.getPhoto +
          "/${GetStorage().read('currentDoc')}";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);

        setState(() {
          fName = json['first_name'];
          lName = json['last_name'];
          email = json['email'];
          rate = json['rate'];
          photo = json['photo'];
        });
      } else {
        print("error fetching data");
      }
    } catch (e) {
      print("error $e");
    }
  }

  // Future upload() async {
  //   if(file == null) return;
  //   String base64 = imageToBase64(file as Image);
  // }
  @override
  void initState() {
    super.initState();
    fetchData();
    (() async {
      http.Response response = await http.get(
        apiEndpoints.baseUrl + apiEndpoints.authEndpoints.getPhoto as Uri,
      );
      // if (mounted) {
      //   setState(() {
      //     String base64 = base64Encode(response.bodyBytes);
      //     bytes = base64Decode(base64);
      bytes = response.bodyBytes;
      //   });
      // }
    })();
  }

  String imageToBase64(Image image) {
    final ByteData byteData = image as ByteData;
    Uint8List byteList = Uint8List.fromList(image as List<int>);
    final Uint8List uint8List = byteData.buffer.asUint8List();

    return base64Encode(uint8List);
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryPanicAttack,
        appBar: AppBar(
          elevation: 0.32,
          title: const Text(
            "Doctor Information",
            style: TextStyle(
              fontSize: 23,
              fontFamily: "Pacifico",
            ),
          ),
          backgroundColor: ColorManager.appBarPanicAttack,
          centerTitle: true,
        ),
        body: Container(
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: heightScreen * 0.2,
                    decoration: BoxDecoration(
                      color: ColorManager.appBarPanicAttack,
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
                        backgroundColor: ColorManager.appBarPanicAttack,
                        radius: 70,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorManager.primaryPanicAttack,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 8,
                                blurRadius: 1,
                                color: ColorManager.primaryPanicAttack,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: url != null
                                ? Image.network(
                                    url,
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  )
                                : const Text("no photo"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: heightScreen * 0.01,
              ),
              Center(
                  child: Text(
                "$fName $lName",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: ColorManager.secondPanicAttack),
              )),
              SizedBox(
                height: heightScreen * 0.05,
              ),
              InkWell(
                child: SectionInfoDoctor(
                  icon: Icon(Icons.person),
                  text: "personal information",
                  icon2: Icon(Icons.navigate_next),
                ),
                onTap: () {
                  Get.bottomSheet(
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: ColorManager.primaryPanicAttack,
                          //to make shade
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.secondPanicAttack,
                              spreadRadius: 10,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        height: heightScreen * 0.4,
                        //here personal information doctor
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PersonInformation(
                              question: "doctor name : ",
                              information: GetStorage().read("DocName"),
                            ),
                            SizedBox(
                              height: heightScreen * 0.05,
                            ),
                            PersonInformation(
                              question: "doctor email : ",
                              information: GetStorage().read("currentDoc"),
                            ),
                            SizedBox(
                              height: heightScreen * 0.05,
                            ),
                            PersonInformation(
                              question: "rate : ",
                              information: GetStorage().read("DocRate"),
                            ),
                          ],
                        ),
                      ),

                      //features get bottomSheet
                      elevation: 30,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: ColorManager.secondPanicAttack, width: 1),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ));
                },
              ),
              SizedBox(
                height: heightScreen * 0.03,
              ),
              //////address doctor
              InkWell(
                child: SectionInfoDoctor(
                  icon: Icon(Icons.location_on),
                  text: "working address",
                  icon2: Icon(Icons.navigate_next),
                ),
                onTap: () {
                  Get.bottomSheet(
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: ColorManager.primaryPanicAttack,
                          //to make shade
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.secondPanicAttack,
                              spreadRadius: 10,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        height: heightScreen * 0.3,
                        //here address doctor
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 6),
                                  child: Text(
                                    "address",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: ColorManager.secondPanicAttack,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: widthScreen * 0.005,
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  GetStorage().read("DocAddress"),
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: ColorManager.secondPanicAttack,
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      //features get bottomSheet
                      elevation: 30,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: ColorManager.secondPanicAttack, width: 1),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ));
                },
              ),
              SizedBox(
                height: heightScreen * 0.03,
              ),

              /// here review doctor
              InkWell(
                child: SectionInfoDoctor(
                  icon: Icon(Icons.star),
                  text: "review doctor",
                  icon2: Icon(Icons.navigate_next),
                ),
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: ColorManager.primaryPanicAttack,
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.secondPanicAttack,
                            spreadRadius: 10,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      height: heightScreen * 0.3,
                      child: _buildBody(controller),
                    ),
                    elevation: 30,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: ColorManager.secondPanicAttack,
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 120),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.secondPanicAttack,
                    fixedSize: const Size.fromWidth(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: Size(widthScreen * 0.5, heightScreen * 0.06),
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.getChatRoute());
                  },
                  child: const Text(
                    'doctor conversation',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
