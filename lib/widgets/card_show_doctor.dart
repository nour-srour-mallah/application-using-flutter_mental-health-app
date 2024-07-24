import 'package:flutter/material.dart';
import '../model/user/doctor/show_all_doctor/model_get_doc_list.dart';
import '../resources/color-manager.dart';

class ShowDoctor extends StatelessWidget {
  final doc doctor;

  const ShowDoctor({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url =
        "https://selene-m-h.up.railway.app/users/upload_photo/${doctor.email}";
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
            child: Card(
              color: ColorManager.elementPanicAttack,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(url),
                  onBackgroundImageError: (exception, stackTrace) {
                    print('Error loading image: $exception');
                  },
                  child: Icon(Icons.person, size: 40),
                ),
                title: Text(
                  "${doctor.firstName!} ${doctor.lastName!}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Ensure the text is left-aligned
                  children: [
                    Text(
                      "Rating: ${doctor.rate!}",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Text(
                      "Specialization: ${doctor.specialization!}",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.more_vert,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
