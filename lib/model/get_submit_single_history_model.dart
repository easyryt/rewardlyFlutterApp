class GetSubmitSingleHistoryModel {
  bool? status;
  String? message;
  SubmitSingleHistoryData? data;

  GetSubmitSingleHistoryModel({this.status, this.message, this.data});

  GetSubmitSingleHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? SubmitSingleHistoryData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SubmitSingleHistoryData {
  String? packageName;
  String? name;
  String? appLogo;
  String? type;
  bool? isVerified;
  String? status;
  String? proofUrl;
  String? verificationReason;

  SubmitSingleHistoryData(
      {this.packageName,
      this.name,
      this.appLogo,
      this.type,
      this.isVerified,
      this.status,
      this.proofUrl,
      this.verificationReason});

  SubmitSingleHistoryData.fromJson(Map<String, dynamic> json) {
    packageName = json['packageName'];
    name = json['name'];
    appLogo = json['appLogo'];
    type = json['type'];
    isVerified = json['isVerified'];
    status = json['status'];
    proofUrl = json['proofUrl'];
    verificationReason = json['verificationReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packageName'] = packageName;
    data['name'] = name;
    data['appLogo'] = appLogo;
    data['type'] = type;
    data['isVerified'] = isVerified;
    data['status'] = status;
    data['proofUrl'] = proofUrl;
    data['verificationReason'] = verificationReason;
    return data;
  }
}
