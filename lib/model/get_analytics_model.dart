class GetAnalyticsModel {
  bool? status;
  Earnings? earnings;
  Activity? activity;

  GetAnalyticsModel({this.status, this.earnings, this.activity});

  GetAnalyticsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    earnings =
        json['earnings'] != null ? Earnings.fromJson(json['earnings']) : null;
    activity =
        json['activity'] != null ? Activity.fromJson(json['activity']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (earnings != null) {
      data['earnings'] = earnings!.toJson();
    }
    if (activity != null) {
      data['activity'] = activity!.toJson();
    }
    return data;
  }
}

class Earnings {
  int? selfWallet;
  int? referralWallet;
  int? totalEarnings;
  List? referralBreakdown;

  Earnings(
      {this.selfWallet,
      this.referralWallet,
      this.totalEarnings,
      this.referralBreakdown});

  Earnings.fromJson(Map<String, dynamic> json) {
    selfWallet = json['selfWallet'];
    referralWallet = json['referralWallet'];
    totalEarnings = json['totalEarnings'];
    if (json['referralBreakdown'] != null) {
      referralBreakdown = [];
      json['referralBreakdown'].forEach((v) {
        referralBreakdown!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['selfWallet'] = selfWallet;
    data['referralWallet'] = referralWallet;
    data['totalEarnings'] = totalEarnings;
    if (referralBreakdown != null) {
      data['referralBreakdown'] =
          referralBreakdown!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activity {
  Cpi? cpi;
  Cpi? review;

  Activity({this.cpi, this.review});

  Activity.fromJson(Map<String, dynamic> json) {
    cpi = json['cpi'] != null ? Cpi.fromJson(json['cpi']) : null;
    review = json['review'] != null ? Cpi.fromJson(json['review']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cpi != null) {
      data['cpi'] = cpi!.toJson();
    }
    if (review != null) {
      data['review'] = review!.toJson();
    }
    return data;
  }
}

class Cpi {
  int? approved;
  int? rejected;
  int? submitted;
  int? pending;

  Cpi({this.approved, this.rejected, this.submitted, this.pending});

  Cpi.fromJson(Map<String, dynamic> json) {
    approved = json['approved'];
    rejected = json['rejected'];
    submitted = json['submitted'];
    pending = json['pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['approved'] = approved;
    data['rejected'] = rejected;
    data['submitted'] = submitted;
    data['pending'] = pending;
    return data;
  }
}
