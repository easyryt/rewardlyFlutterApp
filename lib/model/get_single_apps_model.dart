class GetSingleAppsModel {
  bool? status;
  FileterdCamp? fileterdCamp;

  GetSingleAppsModel({this.status, this.fileterdCamp});

  GetSingleAppsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    fileterdCamp = json['fileterdCamp'] != null
        ? FileterdCamp.fromJson(json['fileterdCamp'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (fileterdCamp != null) {
      data['fileterdCamp'] = fileterdCamp!.toJson();
    }
    return data;
  }
}

class FileterdCamp {
  String? sId;
  String? name;
  String? packageName;
  String? type;
  AppLogo? appLogo;
  String? status;

  FileterdCamp(
      {this.sId,
      this.name,
      this.packageName,
      this.type,
      this.appLogo,
      this.status});

  FileterdCamp.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    packageName = json['packageName'];
    type = json['type'];
    appLogo =
        json['appLogo'] != null ? AppLogo.fromJson(json['appLogo']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['packageName'] = packageName;
    data['type'] = type;
    if (appLogo != null) {
      data['appLogo'] = appLogo!.toJson();
    }
    data['status'] = status;
    return data;
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
