class GetSubmitHistoryModel {
  bool? status;
  List<SubmitHistoryData>? data;
  int? page;
  int? limit;
  int? total;
  int? totalPages;

  GetSubmitHistoryModel(
      {this.status,
      this.data,
      this.page,
      this.limit,
      this.total,
      this.totalPages});

  GetSubmitHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SubmitHistoryData>[];
      json['data'].forEach((v) {
        data!.add(new SubmitHistoryData.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    data['totalPages'] = totalPages;
    return data;
  }
}

class SubmitHistoryData {
  String? sId;
  String? appLogo;
  String? name;
  String? packageName;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;

  SubmitHistoryData(
      {this.sId,
      this.appLogo,
      this.name,
      this.packageName,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt});

  SubmitHistoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    appLogo = json['appLogo'];
    name = json['name'];
    packageName = json['packageName'];
    type = json['type'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['appLogo'] = appLogo;
    data['packageName'] = packageName;
    data['name'] = name;
    data['type'] = type;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
