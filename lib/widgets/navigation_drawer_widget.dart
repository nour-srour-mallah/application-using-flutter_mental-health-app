import 'package:flutter/material.dart';
import '../../resources/color-manager.dart';
import 'package:get_storage/get_storage.dart';
import '../services/endpoints_api.dart';
class MenuItem extends StatelessWidget {
 final String text;
  final IconData icon;
  final VoidCallback? onClicked;
  MenuItem(
      {super.key,
      required this.text,
      required this.icon,
      required this.onClicked});
  final hoverColor = Colors.white70;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        hoverColor: hoverColor,
        onTap: onClicked);
  }
}

class HeaderDrawer extends StatelessWidget {
  final box = GetStorage();
  final url = apiEndpoints.baseUrl + apiEndpoints.authEndpoints.getPhoto+"/${GetStorage().read('email')}";

  final String img;
  final String name;
  final String email;

  HeaderDrawer(
      {super.key, required this.img, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return SizedBox(
      height: heightScreen * 0.2,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.appBarPanicAttack,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 40,
              backgroundImage: Image.network(url).image,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 68),
                child: Column(
                  children: [
                    Text(
                      name ,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(email ,
                        style: const TextStyle(color: Colors.white))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
