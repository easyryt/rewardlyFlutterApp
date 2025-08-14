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
  String? packageName;
  String? type;
  AppLogo? appLogo;
  bool? isLocked;
  String? status;
  String? startDate;
  String? endDate;

  AllAppsCampaigns(
      {this.sId,
      this.planId,
      this.name,
      this.packageName,
      this.type,
      this.isLocked,
      this.appLogo,
      this.status,
      this.startDate,
      this.endDate});

  AllAppsCampaigns.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planId = json['planId'];
    name = json['name'];
    packageName = json['packageName'];
    type = json['type'];
    appLogo =
        json['appLogo'] != null ? AppLogo.fromJson(json['appLogo']) : null;
    status = json['status'];
    isLocked = json['isLocked'] ?? false;
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['planId'] = planId;
    data['name'] = name;
    data['packageName'] = packageName;
    data['type'] = type;
    if (appLogo != null) {
      data['appLogo'] = appLogo!.toJson();
    }
    data['status'] = status;
    data['isLocked'] = isLocked;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }

  AllAppsCampaigns copyWith({
    String? sId,
    String? planId,
    String? name,
    String? packageName,
    String? type,
    bool? isLocked,
    AppLogo? appLogo,
    String? status,
    String? startDate,
    String? endDate,
  }) {
    return AllAppsCampaigns(
      sId: sId ?? this.sId,
      planId: planId ?? this.planId,
      name: name ?? this.name,
      packageName: packageName ?? this.packageName,
      type: type ?? this.type,
      isLocked: isLocked ?? this.isLocked,
      appLogo: appLogo ?? this.appLogo,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

class AppLogo {
  String? filename;
  String? url;

  AppLogo({this.filename, this.url});

  AppLogo.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    data['url'] = url;
    return data;
  }
}
