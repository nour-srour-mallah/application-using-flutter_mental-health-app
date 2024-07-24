class Network1 {
  NetworkUser? networkUser;

  Network1({required this.networkUser});

  Network1.fromJson(Map<String, dynamic> json) {
    networkUser = (json['network'] != null ? NetworkUser.fromJson(json['network']) : null)!;
  }
}

class NetworkUser {
  String? fName;
  String? lName;
  String? email;
  String? specialization;
  String? clinic_address;
  String? rate;

  NetworkUser(
      {
        required this.fName,
        required this.lName,
        required this.email,
        required this.specialization,
        required this.clinic_address,
        required this.rate
      }
      );

  NetworkUser.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    email = json['email'];
    specialization = json['specialization'];
    clinic_address = json['clinic_address'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['email'] = email;
    data['specialization'] = specialization;
    data['clinic_address'] = clinic_address;
    data['rate'] = rate;
    return data;
  }
}


