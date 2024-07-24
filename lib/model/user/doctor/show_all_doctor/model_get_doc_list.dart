class docList {
  doc? doctors;

  docList(
      {required this.doctors,
        required email,
        required firstName,
        required lastName,
        required rate,
        required address, required specialization});

  docList.fromJson(Map<String, dynamic> json) {
    doctors = (json['doctors'] != null ? doc.fromJson(json['doctors']) : null)!;
  }
// docList.fromJson(Map<String, dynamic> json) {
//   if (json['doctors'] != null) {
//         //doctors = json['doctors'].map<docList>((v)=>docList.fromJson(v)).toString() as List<Doctors>?;
//     docList(doctors: json['doctors']?.map<Doctors>((v) => docList.fromJson((v)) as List<Doctors>??[]));
//     }
//   }
}
// class doc{
// String? email;
// String? firstName;
// String? lastName;
// String? rate;
// doc({required this.email, required this.firstName, required this.lastName, required this.rate});

// factory doc.fromJson(Map<String, dynamic> json){
// // final Map<String, dynamic> data = new Map<String, dynamic>();
// // final doctors = this.doctors;
// // if (doctors != null) {
// //   data['doctors'] = doctors.map((v) => v.toJson()).toList();
// // }
// // return data;
// return doc(
// email: json['email'].toString(),
// firstName: json['first_name'].toString(),
// lastName: json['last_name'].toString(),
// rate: json['rate'].toString()
// );
// }

// }

class doc {
  String? email;
  String? firstName;
  String? lastName;
  String? rate;
  String? clinic_address;
  String? specialization;

  doc(
      {required this.email,
        required this.firstName,
        required this.lastName,
        required this.rate,
        required this.clinic_address,
        required this.specialization
      });

  factory doc.fromJson(Map<String, dynamic> json) {
    return doc(
        email: json['email'].toString(),
        firstName: json['first_name'].toString(),
        lastName: json['last_name'].toString(),
        rate: json['rate'].toString(),
        clinic_address: json['clinic_address'].toString(),
        specialization: json['specialization'].toString()
    );
  }
}
