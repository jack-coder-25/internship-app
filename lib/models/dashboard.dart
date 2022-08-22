class DashboardSummaryResponse {
  String? status;
  String? message;
  Data? data;

  DashboardSummaryResponse({this.status, this.message, this.data});

  DashboardSummaryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? walletBalance;
  Coupons? coupons;
  Referrals? referrals;

  Data({this.walletBalance, this.coupons, this.referrals});

  Data.fromJson(Map<String, dynamic> json) {
    walletBalance = json['wallet_balance'];
    coupons =
        json['coupons'] != null ? Coupons.fromJson(json['coupons']) : null;
    referrals = json['referrals'] != null
        ? Referrals.fromJson(json['referrals'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['wallet_balance'] = walletBalance;
    if (coupons != null) {
      data['coupons'] = coupons!.toJson();
    }
    if (referrals != null) {
      data['referrals'] = referrals!.toJson();
    }
    return data;
  }
}

class Coupons {
  int? total;
  String? used;
  String? pending;

  Coupons({this.total, this.used, this.pending});

  Coupons.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    used = json['used'];
    pending = json['pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['total'] = total;
    data['used'] = used;
    data['pending'] = pending;
    return data;
  }
}

class Referrals {
  List<ReferralItem>? total;
  List<ReferralItem>? paid;
  List<ReferralItem>? unpaid;

  Referrals({this.total, this.paid, this.unpaid});

  Referrals.fromJson(Map<String, dynamic> json) {
    if (json['total'] != null) {
      total = <ReferralItem>[];
      json['total'].forEach((v) {
        total!.add(ReferralItem.fromJson(v));
      });
    }
    if (json['paid'] != null) {
      paid = <ReferralItem>[];
      json['paid'].forEach((v) {
        paid!.add(ReferralItem.fromJson(v));
      });
    }

    if (json['unpaid'] != null) {
      unpaid = <ReferralItem>[];
      json['unpaid'].forEach((v) {
        unpaid!.add(ReferralItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (total != null) {
      data['total'] = total!.map((v) => v.toJson()).toList();
    }
    if (paid != null) {
      data['paid'] = paid!.map((v) => v.toJson()).toList();
    }
    if (unpaid != null) {
      data['unpaid'] = unpaid!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReferralItem {
  String? name;
  String? referralCommission;
  String? referralStatus;
  String? createdAt;

  ReferralItem({
    this.name,
    this.referralCommission,
    this.referralStatus,
    this.createdAt,
  });

  ReferralItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    referralCommission = json['referral_commission'];
    referralStatus = json['referral_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['referral_commission'] = referralCommission;
    data['referral_status'] = referralStatus;
    data['created_at'] = createdAt;
    return data;
  }
}
