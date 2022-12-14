import 'package:quiver/core.dart';

class VendorDetailResponse {
  String? status;
  String? message;
  Data? data;

  VendorDetailResponse({this.status, this.message, this.data});

  VendorDetailResponse.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? groupId;
  String? name;
  String? phone;
  String? mobile;
  String? bvcnumber;
  String? bvcnumberStatus;
  String? email;
  String? password;
  String? status;
  String? type;
  String? photo;
  String? video;
  String? dob;
  String? brandName;
  String? landlineNumber;
  String? bankAccountName;
  String? bankAccountType;
  String? bankAccountNumber;
  String? bankIfsc;
  String? overview;
  String? doorNo;
  String? buildingName;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? website;
  String? mapLink;
  String? lat;
  String? lan;
  String? authSign;
  String? contactPerson;
  String? alterPhone;
  String? gst;
  String? gstExept;
  String? weblink;
  String? aadhar;
  String? pan;
  String? booking;
  String? phoneVerified;
  String? emailVerified;
  String? accountVerified;
  String? orderPos;
  String? dsaId;
  String? subscriptionId;
  String? referralCode;
  String? referredBy;
  String? referralCommission;
  String? referralStatus;
  String? referralTxnId;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;
  List<Slides>? slides;
  List<Categories>? categories;

  Data({
    this.id,
    this.groupId,
    this.name,
    this.phone,
    this.mobile,
    this.bvcnumber,
    this.bvcnumberStatus,
    this.email,
    this.password,
    this.status,
    this.type,
    this.photo,
    this.video,
    this.dob,
    this.brandName,
    this.landlineNumber,
    this.bankAccountName,
    this.bankAccountType,
    this.bankAccountNumber,
    this.bankIfsc,
    this.overview,
    this.doorNo,
    this.buildingName,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.website,
    this.mapLink,
    this.lat,
    this.lan,
    this.authSign,
    this.contactPerson,
    this.alterPhone,
    this.gst,
    this.gstExept,
    this.weblink,
    this.aadhar,
    this.pan,
    this.booking,
    this.phoneVerified,
    this.emailVerified,
    this.accountVerified,
    this.orderPos,
    this.dsaId,
    this.subscriptionId,
    this.referralCode,
    this.referredBy,
    this.referralCommission,
    this.referralStatus,
    this.referralTxnId,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.slides,
    this.categories,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    name = json['name'];
    phone = json['phone'];
    mobile = json['mobile'];
    bvcnumber = json['bvcnumber'];
    bvcnumberStatus = json['bvcnumber_status'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    type = json['type'];
    photo = json['photo'];
    video = json['video'];
    dob = json['dob'];
    brandName = json['brand_name'];
    landlineNumber = json['landline_number'];
    bankAccountName = json['bank_account_name'];
    bankAccountType = json['bank_account_type'];
    bankAccountNumber = json['bank_account_number'];
    bankIfsc = json['bank_ifsc'];
    overview = json['overview'];
    doorNo = json['door_no'];
    buildingName = json['building_name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    website = json['website'];
    mapLink = json['map_link'];
    lat = json['lat'];
    lan = json['lan'];
    authSign = json['auth_sign'];
    contactPerson = json['contact_person'];
    alterPhone = json['alter_phone'];
    gst = json['gst'];
    gstExept = json['gst_exept'];
    weblink = json['weblink'];
    aadhar = json['aadhar'];
    pan = json['pan'];
    booking = json['booking'];
    phoneVerified = json['phone_verified'];
    emailVerified = json['email_verified'];
    accountVerified = json['account_verified'];
    orderPos = json['order_pos'];
    dsaId = json['dsa_id'];
    subscriptionId = json['subscription_id'];
    referralCode = json['referral_code'];
    referredBy = json['referred_by'];
    referralCommission = json['referral_commission'];
    referralStatus = json['referral_status'];
    referralTxnId = json['referral_txn_id'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    if (json['slides'] != null) {
      slides = <Slides>[];
      json['slides'].forEach((v) {
        slides!.add(Slides.fromJson(v));
      });
    }

    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['group_id'] = groupId;
    data['name'] = name;
    data['phone'] = phone;
    data['mobile'] = mobile;
    data['bvcnumber'] = bvcnumber;
    data['bvcnumber_status'] = bvcnumberStatus;
    data['email'] = email;
    data['password'] = password;
    data['status'] = status;
    data['type'] = type;
    data['photo'] = photo;
    data['video'] = video;
    data['dob'] = dob;
    data['brand_name'] = brandName;
    data['landline_number'] = landlineNumber;
    data['bank_account_name'] = bankAccountName;
    data['bank_account_type'] = bankAccountType;
    data['bank_account_number'] = bankAccountNumber;
    data['bank_ifsc'] = bankIfsc;
    data['overview'] = overview;
    data['door_no'] = doorNo;
    data['building_name'] = buildingName;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    data['website'] = website;
    data['map_link'] = mapLink;
    data['lat'] = lat;
    data['lan'] = lan;
    data['auth_sign'] = authSign;
    data['contact_person'] = contactPerson;
    data['alter_phone'] = alterPhone;
    data['gst'] = gst;
    data['gst_exept'] = gstExept;
    data['weblink'] = weblink;
    data['aadhar'] = aadhar;
    data['pan'] = pan;
    data['booking'] = booking;
    data['phone_verified'] = phoneVerified;
    data['email_verified'] = emailVerified;
    data['account_verified'] = accountVerified;
    data['order_pos'] = orderPos;
    data['dsa_id'] = dsaId;
    data['subscription_id'] = subscriptionId;
    data['referral_code'] = referralCode;
    data['referred_by'] = referredBy;
    data['referral_commission'] = referralCommission;
    data['referral_status'] = referralStatus;
    data['referral_txn_id'] = referralTxnId;
    data['fcm_token'] = fcmToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    if (slides != null) {
      data['slides'] = slides!.map((v) => v.toJson()).toList();
    }

    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Slides {
  String? id;
  String? vendorId;
  String? image;
  String? actionUrl;
  String? orderPos;
  String? status;
  String? createdAt;
  String? updatedAt;

  Slides({
    this.id,
    this.vendorId,
    this.image,
    this.actionUrl,
    this.orderPos,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Slides.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];

    if (json['image'] is List<dynamic>) {
      image = (json['image'] as List<dynamic>)[0];
    } else {
      image = json['image'];
    }

    actionUrl = json['action_url'];
    orderPos = json['order_pos'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['image'] = image;
    data['action_url'] = actionUrl;
    data['order_pos'] = orderPos;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Categories {
  String? id;
  String? vendorId;
  String? title;
  String? image;
  String? orderPos;
  String? status;
  String? createdAt;
  String? updatedAt;

  Categories({
    this.id,
    this.vendorId,
    this.title,
    this.image,
    this.orderPos,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    title = json['title'];
    image = json['image'];
    orderPos = json['order_pos'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['title'] = title;
    data['image'] = image;
    data['order_pos'] = orderPos;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class VendorServicesResponse {
  String? status;
  String? message;
  List<CategoryData>? data;

  VendorServicesResponse({this.status, this.message, this.data});

  VendorServicesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
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

class CategoryData {
  String? id;
  String? serviceCategoryId;
  String? vendorId;
  String? categoryId;
  String? title;
  String? amount;
  String? actualAmount;
  String? bvcAmount;
  String? shortNotes;
  String? ac;
  String? description;
  String? photo;
  List<Amenities>? amenities;
  List<String>? rulesRegulations;
  String? booking;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? mapLink;
  String? bookingEnabled;
  List<CategorySlides>? slides;

  CategoryData({
    this.id,
    this.serviceCategoryId,
    this.vendorId,
    this.categoryId,
    this.title,
    this.amount,
    this.actualAmount,
    this.bvcAmount,
    this.shortNotes,
    this.ac,
    this.description,
    this.photo,
    this.amenities,
    this.rulesRegulations,
    this.booking,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.mapLink,
    this.bookingEnabled,
    this.slides,
  });

  @override
  bool operator ==(other) =>
      other is CategoryData && id == other.id && title == other.title;

  @override
  int get hashCode => hash2(id.hashCode, title.hashCode);

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceCategoryId = json['service_category_id'];
    vendorId = json['vendor_id'];
    categoryId = json['category_id'];
    title = json['title'];
    amount = json['amount'];
    actualAmount = json['actual_amount'];
    bvcAmount = json['bvc_amount'];
    shortNotes = json['short_notes'];
    ac = json['ac'];
    description = json['description'];
    photo = json['photo'];

    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(Amenities.fromJson(v));
      });
    }

    if (json['rules_regulations'] != null) {
      rulesRegulations = <String>[];
      json['rules_regulations'].forEach((v) {
        rulesRegulations!.add(v.toString());
      });
    }

    booking = json['booking'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mapLink = json['map_link'];
    bookingEnabled = json['booking_enabled'];

    if (json['slides'] != null) {
      slides = <CategorySlides>[];
      json['slides'].forEach((v) {
        slides!.add(CategorySlides.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['service_category_id'] = serviceCategoryId;
    data['vendor_id'] = vendorId;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['amount'] = amount;
    data['actual_amount'] = actualAmount;
    data['bvc_amount'] = bvcAmount;
    data['short_notes'] = shortNotes;
    data['ac'] = ac;
    data['description'] = description;
    data['photo'] = photo;

    if (amenities != null) {
      data['amenities'] = amenities!.map((v) => v.toJson()).toList();
    }

    if (rulesRegulations != null) {
      data['rules_regulations'] =
          rulesRegulations!.map((v) => v.toString()).toList();
    }

    data['booking'] = booking;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['map_link'] = mapLink;
    data['booking_enabled'] = bookingEnabled;

    if (slides != null) {
      data['slides'] = slides!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class CategorySlides {
  String? id;
  String? vendorServiceId;
  String? image;
  String? actionUrl;
  String? orderPos;
  String? status;
  String? createdAt;
  String? updatedAt;

  CategorySlides({
    this.id,
    this.vendorServiceId,
    this.image,
    this.actionUrl,
    this.orderPos,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  CategorySlides.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorServiceId = json['vendor_service_id'];
    image = json['image'];
    actionUrl = json['action_url'];
    orderPos = json['order_pos'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['vendor_service_id'] = vendorServiceId;
    data['image'] = image;
    data['action_url'] = actionUrl;
    data['order_pos'] = orderPos;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Amenities {
  String? title;
  String? icon;

  Amenities({this.title, this.icon});

  Amenities.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['icon'] = icon;
    return data;
  }
}

class VendorServiceSlotsResponse {
  String? status;
  String? message;
  List<VendorServiceSlotsData>? data;

  VendorServiceSlotsResponse({
    this.status,
    this.message,
    this.data,
  });

  VendorServiceSlotsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VendorServiceSlotsData>[];
      json['data'].forEach((v) {
        data!.add(VendorServiceSlotsData.fromJson(v));
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

class VendorServiceSlotsData {
  String? id;
  String? serviceId;
  String? startAt;
  String? endAt;
  String? title;
  String? qtyTotal;
  String? qtyBooked;
  String? qtyBlocked;
  String? qtyAvailable;
  String? status;
  String? createdAt;
  String? updatedAt;

  VendorServiceSlotsData({
    this.id,
    this.serviceId,
    this.startAt,
    this.endAt,
    this.title,
    this.qtyTotal,
    this.qtyBooked,
    this.qtyBlocked,
    this.qtyAvailable,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  VendorServiceSlotsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    title = json['title'];
    qtyTotal = json['qty_total'];
    qtyBooked = json['qty_booked'];
    qtyBlocked = json['qty_blocked'];
    qtyAvailable = json['qty_available'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['service_id'] = serviceId;
    data['start_at'] = startAt;
    data['end_at'] = endAt;
    data['title'] = title;
    data['qty_total'] = qtyTotal;
    data['qty_booked'] = qtyBooked;
    data['qty_blocked'] = qtyBlocked;
    data['qty_available'] = qtyAvailable;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class BookServiceResponse {
  String? status;
  String? message;
  BookServiceData? data;

  BookServiceResponse({this.status, this.message, this.data});

  BookServiceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? BookServiceData.fromJson(json['data']) : null;
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

class BookServiceData {
  int? bookingId;

  BookServiceData({this.bookingId});

  BookServiceData.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['booking_id'] = bookingId;
    return data;
  }
}

class StartServiceResponse {
  String? status;
  String? message;

  StartServiceResponse({this.status, this.message});

  StartServiceResponse.fromJson(Map<String, dynamic> json) {
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

class DeleteServiceSlotResponse {
  String? status;
  String? message;

  DeleteServiceSlotResponse({this.status, this.message});

  DeleteServiceSlotResponse.fromJson(Map<String, dynamic> json) {
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

class AddServiceSlotsResponse {
  String? status;
  String? message;

  AddServiceSlotsResponse({this.status, this.message});

  AddServiceSlotsResponse.fromJson(Map<String, dynamic> json) {
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
