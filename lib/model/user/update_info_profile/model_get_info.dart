class profile {
  String firstName;
  String lastName;
  String email;
  String birth;
  String gender;
  String clinicAddress;
  String rate;

  profile(
      {required this.firstName,
        required this.lastName,
        required this.email,
        required this.birth,
        required this.gender,
        required this.clinicAddress,
        required this.rate});

  factory profile.fromJson(Map<String, dynamic> json) => profile(
    firstName : json['first_name'],
    lastName : json['last_name'],
    email : json['email'],
    birth : json['birth'],
    gender : json['gender'],
    clinicAddress : json['clinic_address'],
    rate : json['rate'],
    //photo : json['photo'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['birth'] = birth;
    data['gender'] = gender;
    data['clinic_address'] = clinicAddress;
    data['rate'] = rate;
    return data;
  }
}
