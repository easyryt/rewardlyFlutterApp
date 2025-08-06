class GetAllAppsModel {
  bool? status;
  List<AllAppsCampaigns>? campaigns;

  GetAllAppsModel({this.status, this.campaigns});

  GetAllAppsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['campaigns'] != null) {
      campaigns = <AllAppsCampaigns>[];
      json['campaigns'].forEach((v) {
        campaigns!.add(AllAppsCampaigns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (campaigns != null) {
      data['campaigns'] = campaigns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllAppsCampaigns {
  String? sId;
  String? planId;
  String? name;
  String? type;
  String? appLink;
  String? status;
  String? startDate;
  String? endDate;

  AllAppsCampaigns(
      {this.sId,
      this.planId,
      this.name,
      this.type,
      this.appLink,
      this.status,
      this.startDate,
      this.endDate});

  AllAppsCampaigns.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planId = json['planId'];
    name = json['name'];
    type = json['type'];
    appLink = json['appLink'];
    status = json['status'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['planId'] = planId;
    data['name'] = name;
    data['type'] = type;
    data['appLink'] = appLink;
    data['status'] = status;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
