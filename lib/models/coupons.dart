class AdditionalCouponResponse {
  String? status;
  String? message;
  List<Data>? data;

  AdditionalCouponResponse({this.status, this.message, this.data});

  AdditionalCouponResponse.fromJson(Map<String, dynamic> json) {
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
  String? type;
  String? isVendorCoupon;
  String? vendorId;
  String? serviceId;
  String? title;
  String? vendorType;
  String? categoryId;
  String? description;
  String? image;
  String? code;
  String? amount;
  String? bvcPercentage;
  String? vendorAmount;
  String? additionalAmount;
  String? status;
  String? startsOn;
  String? endsOn;
  String? createdAt;
  String? updateAt;
  String? categoryName;
  String? name;

  Data({
    this.id,
    this.type,
    this.isVendorCoupon,
    this.vendorId,
    this.serviceId,
    this.title,
    this.vendorType,
    this.categoryId,
    this.description,
    this.image,
    this.code,
    this.amount,
    this.bvcPercentage,
    this.vendorAmount,
    this.additionalAmount,
    this.status,
    this.startsOn,
    this.endsOn,
    this.createdAt,
    this.updateAt,
    this.categoryName,
    this.name,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    isVendorCoupon = json['is_vendor_coupon'];
    vendorId = json['vendor_id'];
    serviceId = json['service_id'];
    title = json['title'];
    vendorType = json['vendor_type'];
    categoryId = json['category_id'];
    description = json['description'];
    image = json['image'];
    code = json['code'];
    amount = json['amount'];
    bvcPercentage = json['bvc_percentage'];
    vendorAmount = json['vendor_amount'];
    additionalAmount = json['additional_amount'];
    status = json['status'];
    startsOn = json['starts_on'];
    endsOn = json['ends_on'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    categoryName = json['category_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type'] = type;
    data['is_vendor_coupon'] = isVendorCoupon;
    data['vendor_id'] = vendorId;
    data['service_id'] = serviceId;
    data['title'] = title;
    data['vendor_type'] = vendorType;
    data['category_id'] = categoryId;
    data['description'] = description;
    data['image'] = image;
    data['code'] = code;
    data['amount'] = amount;
    data['bvc_percentage'] = bvcPercentage;
    data['vendor_amount'] = vendorAmount;
    data['additional_amount'] = additionalAmount;
    data['status'] = status;
    data['starts_on'] = startsOn;
    data['ends_on'] = endsOn;
    data['created_at'] = createdAt;
    data['update_at'] = updateAt;
    data['category_name'] = categoryName;
    data['name'] = name;
    return data;
  }
}

class BuyCouponResponse {
  String? status;
  String? message;

  BuyCouponResponse({this.status, this.message});

  BuyCouponResponse.fromJson(Map<String, dynamic> json) {
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

class AvailableCouponsResponse {
  String? status;
  String? message;
  List<AvailableCouponsData>? data;

  AvailableCouponsResponse({this.status, this.message, this.data});

  AvailableCouponsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AvailableCouponsData>[];
      json['data'].forEach((v) {
        data!.add(AvailableCouponsData.fromJson(v));
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

class AvailableCouponsData {
  String? id;
  String? userId;
  String? offerId;
  String? code;
  String? status;
  String? generatedBy;
  String? redeemedAt;
  String? createdAt;
  String? updatedAt;
  String? vendorId;
  String? title;
  String? image;
  String? description;
  String? startsOn;
  String? endsOn;
  String? vendorName;
  String? categoryId;
  String? serviceName;

  AvailableCouponsData({
    this.id,
    this.userId,
    this.offerId,
    this.code,
    this.status,
    this.generatedBy,
    this.redeemedAt,
    this.createdAt,
    this.updatedAt,
    this.vendorId,
    this.title,
    this.image,
    this.description,
    this.startsOn,
    this.endsOn,
    this.vendorName,
    this.categoryId,
    this.serviceName,
  });

  AvailableCouponsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    offerId = json['offer_id'];
    code = json['code'];
    status = json['status'];
    generatedBy = json['generated_by'];
    redeemedAt = json['redeemed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vendorId = json['vendor_id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    startsOn = json['starts_on'];
    endsOn = json['ends_on'];
    vendorName = json['vendor_name'];
    categoryId = json['category_id'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['offer_id'] = offerId;
    data['code'] = code;
    data['status'] = status;
    data['generated_by'] = generatedBy;
    data['redeemed_at'] = redeemedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['vendor_id'] = vendorId;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    data['starts_on'] = startsOn;
    data['ends_on'] = endsOn;
    data['vendor_name'] = vendorName;
    data['category_id'] = categoryId;
    data['service_name'] = serviceName;
    return data;
  }
}

class RedeemCouponsResponse {
  String? status;
  String? message;

  RedeemCouponsResponse({this.status, this.message});

  RedeemCouponsResponse.fromJson(Map<String, dynamic> json) {
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

class RedeemedCouponsResponse {
  String? status;
  String? message;
  List<RedeemedCouponsData>? data;

  RedeemedCouponsResponse({this.status, this.message, this.data});

  RedeemedCouponsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RedeemedCouponsData>[];
      json['data'].forEach((v) {
        data!.add(RedeemedCouponsData.fromJson(v));
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

class RedeemedCouponsData {
  String? id;
  String? userId;
  String? offerId;
  String? code;
  String? status;
  String? generatedBy;
  String? redeemedAt;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? image;
  String? description;
  String? startsOn;
  String? endsOn;
  String? vendorName;

  RedeemedCouponsData({
    this.id,
    this.userId,
    this.offerId,
    this.code,
    this.status,
    this.generatedBy,
    this.redeemedAt,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.image,
    this.description,
    this.startsOn,
    this.endsOn,
    this.vendorName,
  });

  RedeemedCouponsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    offerId = json['offer_id'];
    code = json['code'];
    status = json['status'];
    generatedBy = json['generated_by'];
    redeemedAt = json['redeemed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    startsOn = json['starts_on'];
    endsOn = json['ends_on'];
    vendorName = json['vendor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['offer_id'] = offerId;
    data['code'] = code;
    data['status'] = status;
    data['generated_by'] = generatedBy;
    data['redeemed_at'] = redeemedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    data['starts_on'] = startsOn;
    data['ends_on'] = endsOn;
    data['vendor_name'] = vendorName;
    return data;
  }
}
