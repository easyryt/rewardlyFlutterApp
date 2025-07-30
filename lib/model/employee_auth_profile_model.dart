class EmployeeAuthProfileModel {
  bool? status;
  EmployeeAuthProfileData? data;

  EmployeeAuthProfileModel({this.status, this.data});

  EmployeeAuthProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? EmployeeAuthProfileData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EmployeeAuthProfileData {
  String? sId;
  String? name;
  String? phone;
  String? email;
  bool? isEmailVerified;
  int? wallet;
  List? referrals;

  EmployeeAuthProfileData(
      {this.sId,
      this.name,
      this.phone,
      this.email,
      this.isEmailVerified,
      this.wallet,
      this.referrals});

  EmployeeAuthProfileData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isEmailVerified = json['isEmailVerified'];
    wallet = json['wallet'];
    if (json['referrals'] != null) {
      referrals = [];
      json['referrals'].forEach((v) {
        referrals!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['isEmailVerified'] = isEmailVerified;
    data['wallet'] = wallet;
    if (referrals != null) {
      data['referrals'] = referrals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
