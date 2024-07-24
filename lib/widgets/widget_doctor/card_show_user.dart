// import 'package:flutter/material.dart';

// class ShowUser extends StatelessWidget {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String birth;
//   final String gender;

//   const ShowUser({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.birth,
//     required this.gender,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String url = "https://selene-m-h.up.railway.app/users/upload_photo/$email";
//     return Padding(
//       padding: const EdgeInsets.only(top: 4),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
//             child: Card(
//               child: ListTile(
//                 leading: CircleAvatar(
//                   radius: 40,
//                   backgroundImage: Image.network(url).image,
//                 ),
//                 title: Text(
//                   "$firstName $lastName",
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 subtitle: Text(
//                   "Email: $email",
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Color.fromARGB(255, 0, 0, 0),
//                   ),
//                 ),
//                 trailing: Icon(
//                   Icons.more_vert,
//                   size: 30,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ShowUser extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String birth;
  final String gender;

  const ShowUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birth,
    required this.gender,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = "https://selene-m-h.up.railway.app/users/upload_photo/$email";
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person,
                            size: 40); // Fallback icon if no image
                      },
                    ),
                  ),
                ),
                title: Text(
                  "$firstName $lastName",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Email: $email",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                trailing: Icon(
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
