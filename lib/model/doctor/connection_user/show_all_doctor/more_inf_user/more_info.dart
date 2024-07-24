
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../resources/color-manager.dart';
import 'more_info_controllser.dart';
import 'package:lottie/lottie.dart';

class MoreInfo extends StatelessWidget {
  MoreInfo({super.key});

  final MoreInfoController controller = Get.put(MoreInfoController());

  @override
  Widget build(BuildContext context) {
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
        body: Obx(
              () {
            if (controller.data.isEmpty) {
              return Center(child:    Lottie.asset(
                "assets/imageJson/loading.json",
                fit: BoxFit.cover,
              ));
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorManager.textFieldBase,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Table(
                        columnWidths: {
                          0: FlexColumnWidth(3.5),
                          1: FlexColumnWidth(3),
                        },
                        border: TableBorder.all(color: Colors.grey[300]!),
                        children: controller.data.entries.map((entry) {
                          return TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  entry.key,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  entry.value.toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
