class SubscriptionsResponse {
  String? status;
  String? message;
  List<Data>? data;

  SubscriptionsResponse({this.status, this.message, this.data});

  SubscriptionsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  List<String>? couponId;
  String? additionalCouponId;
  String? title;
  String? amount;
  String? actualAmount;
  String? dsaAmount;
  String? referralAmount;
  String? amc;
  String? dsaAmcAmount;
  String? validityDays;
  String? cardBg;
  String? image;
  String? description;
  String? amcImage;
  String? amcDescription;
  String? status;
  String? orderPos;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.couponId,
    this.additionalCouponId,
    this.title,
    this.amount,
    this.actualAmount,
    this.dsaAmount,
    this.referralAmount,
    this.amc,
    this.dsaAmcAmount,
    this.validityDays,
    this.cardBg,
    this.image,
    this.description,
    this.amcImage,
    this.amcDescription,
    this.status,
    this.orderPos,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    couponId = json['coupon_id']?.cast<String>() ?? [];
    additionalCouponId = json['additional_coupon_id'];
    title = json['title'];
    amount = json['amount'];
    actualAmount = json['actual_amount'];
    dsaAmount = json['dsa_amount'];
    referralAmount = json['referral_amount'];
    amc = json['amc'];
    dsaAmcAmount = json['dsa_amc_amount'];
    validityDays = json['validity_days'];
    cardBg = json['card_bg'];
    image = json['image'];
    description = json['description'];
    amcImage = json['amc_image'];
    amcDescription = json['amc_description'];
    status = json['status'];
    orderPos = json['order_pos'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['coupon_id'] = couponId;
    data['additional_coupon_id'] = additionalCouponId;
    data['title'] = title;
    data['amount'] = amount;
    data['actual_amount'] = actualAmount;
    data['dsa_amount'] = dsaAmount;
    data['referral_amount'] = referralAmount;
    data['amc'] = amc;
    data['dsa_amc_amount'] = dsaAmcAmount;
    data['validity_days'] = validityDays;
    data['card_bg'] = cardBg;
    data['image'] = image;
    data['description'] = description;
    data['amc_image'] = amcImage;
    data['amc_description'] = amcDescription;
    data['status'] = status;
    data['order_pos'] = orderPos;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SubscribeResponse {
  String? status;
  String? message;

  SubscribeResponse({this.status, this.message});

  SubscribeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
