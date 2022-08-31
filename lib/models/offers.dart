class OfferUploadResponse {
  String? status;
  String? message;

  OfferUploadResponse({this.status, this.message});

  OfferUploadResponse.fromJson(Map<String, dynamic> json) {
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

class VendorOffersResponse {
  String? status;
  String? message;
  List<VendorOfferData>? data;

  VendorOffersResponse({this.status, this.message, this.data});

  VendorOffersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VendorOfferData>[];
      json['data'].forEach((v) {
        data!.add(VendorOfferData.fromJson(v));
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

class VendorOfferData {
  String? id;
  String? vendorType;
  String? vendorId;
  String? serviceId;
  String? planId;
  String? title;
  String? businessValue;
  String? discountValue;
  String? claimPerUser;
  String? image;
  String? description;
  String? startsOn;
  String? endsOn;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? vendorName;
  String? couponCode;
  String? couponStatus;

  VendorOfferData({
    this.id,
    this.vendorType,
    this.vendorId,
    this.serviceId,
    this.planId,
    this.title,
    this.businessValue,
    this.discountValue,
    this.claimPerUser,
    this.image,
    this.description,
    this.startsOn,
    this.endsOn,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.vendorName,
    this.couponCode,
    this.couponStatus,
  });

  VendorOfferData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorType = json['vendor_type'];
    vendorId = json['vendor_id'];
    serviceId = json['service_id'];
    planId = json['plan_id'];
    title = json['title'];
    businessValue = json['business_value'];
    discountValue = json['discount_value'];
    claimPerUser = json['claim_per_user'];
    image = json['image'];
    description = json['description'];
    startsOn = json['starts_on'];
    endsOn = json['ends_on'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vendorName = json['vendor_name'];
    couponCode = json['coupon_code'];
    couponStatus = json['coupon_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['vendor_type'] = vendorType;
    data['vendor_id'] = vendorId;
    data['service_id'] = serviceId;
    data['plan_id'] = planId;
    data['title'] = title;
    data['business_value'] = businessValue;
    data['discount_value'] = discountValue;
    data['claim_per_user'] = claimPerUser;
    data['image'] = image;
    data['description'] = description;
    data['starts_on'] = startsOn;
    data['ends_on'] = endsOn;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['vendor_name'] = vendorName;
    data['coupon_code'] = couponCode;
    data['coupon_status'] = couponStatus;
    return data;
  }
}

class GeneralOffersResponse {
  String? status;
  String? message;
  List<GeneralOfferData>? data;

  GeneralOffersResponse({this.status, this.message, this.data});

  GeneralOffersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['data'] != null) {
      data = <GeneralOfferData>[];
      json['data'].forEach((v) {
        data!.add(GeneralOfferData.fromJson(v));
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

class GeneralOfferData {
  String? id;
  String? vendorId;
  String? vendorCategoryId;
  String? vendorServiceId;
  String? title;
  String? description;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? vendorName;
  String? categoryTitle;
  String? serviceTitle;

  GeneralOfferData({
    this.id,
    this.vendorId,
    this.vendorCategoryId,
    this.vendorServiceId,
    this.title,
    this.description,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.vendorName,
    this.categoryTitle,
    this.serviceTitle,
  });

  GeneralOfferData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    vendorCategoryId = json['vendor_category_id'];
    vendorServiceId = json['vendor_service_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vendorName = json['vendor_name'];
    categoryTitle = json['category_title'];
    serviceTitle = json['service_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['vendor_category_id'] = vendorCategoryId;
    data['vendor_service_id'] = vendorServiceId;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['vendor_name'] = vendorName;
    data['category_title'] = categoryTitle;
    data['service_title'] = serviceTitle;
    return data;
  }
}

class ClaimOfferResponse {
  String? status;
  String? message;

  ClaimOfferResponse({this.status, this.message});

  ClaimOfferResponse.fromJson(Map<String, dynamic> json) {
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
