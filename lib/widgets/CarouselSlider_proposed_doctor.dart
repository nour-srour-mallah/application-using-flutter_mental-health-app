import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/color-manager.dart';
import '../resources/route.dart';

class CarouselSliderProposedDoctor extends StatelessWidget {
  const CarouselSliderProposedDoctor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: heightScreen * 0.3,
            child: CarouselSlider.builder(
              itemCount: 5,
              options: CarouselOptions(
                height: heightScreen * 0.5,
                aspectRatio: 16 / 10,
                viewportFraction: 0.5,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              itemBuilder: (context, index, realIndex) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    color: ColorManager.elementPanicAttack,
                  ),
                  width: widthScreen * 0.5,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child: SizedBox(
                          height: heightScreen * 0.22,
                          width: double.infinity,
                          child: Image.asset(
                            "assets/images/doctor.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: heightScreen * 0.01,
                      ),
                      Text(
                        "Dr. name doctor",
                        style: TextStyle(
                          fontFamily: "Assistant",
                          fontWeight: FontWeight.w600,
                          fontSize: widthScreen * 0.037,
                        ),
                      ),
                      SizedBox(
                        height: heightScreen * 0.002,
                      ),
                      Text(
                        "more information",
                        style: TextStyle(
                          fontFamily: "Assistant",
                          fontWeight: FontWeight.w100,
                          fontSize: widthScreen * 0.02,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        onTap: () {
          Get.toNamed(Routes.getInfoDoctorRoute());
        });
  }
}
