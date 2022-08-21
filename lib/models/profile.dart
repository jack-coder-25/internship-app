class ProfileResponse {
  String? status;
  String? message;
  Data? data;

  ProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? importId;
  String? groupId;
  String? name;
  String? phone;
  String? email;
  String? status;
  String? dob;
  String? closeContactPhone;
  String? occupation;
  String? fatherName;
  String? motherName;
  String? maritalStatus;
  String? weddingDate;
  String? spouseName;
  String? spouseDob;
  String? childrens;
  String? childrens18yrs;
  String? officeDoorNo;
  String? officeBuildingName;
  String? officeAddress;
  String? officeCity;
  String? officeState;
  String? officePincode;
  String? doorNo;
  String? buildingName;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? idProof1;
  String? idProof2;
  String? photo;
  String? phoneVerified;
  String? emailVerified;
  String? accountVerified;
  String? dsaId;
  String? subscriptionId;
  String? referralCode;
  String? referredBy;
  String? referralCommission;
  String? referralStatus;
  String? referralTxnId;
  String? fcmToken;
  String? permissions;
  String? createdAt;
  String? updatedAt;
  String? walletBalance;
  String? referralCount;
  Subscription? subscription;

  Data({
    this.id,
    this.importId,
    this.groupId,
    this.name,
    this.phone,
    this.email,
    this.status,
    this.dob,
    this.closeContactPhone,
    this.occupation,
    this.fatherName,
    this.motherName,
    this.maritalStatus,
    this.weddingDate,
    this.spouseName,
    this.spouseDob,
    this.childrens,
    this.childrens18yrs,
    this.officeDoorNo,
    this.officeBuildingName,
    this.officeAddress,
    this.officeCity,
    this.officeState,
    this.officePincode,
    this.doorNo,
    this.buildingName,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.idProof1,
    this.idProof2,
    this.photo,
    this.phoneVerified,
    this.emailVerified,
    this.accountVerified,
    this.dsaId,
    this.subscriptionId,
    this.referralCode,
    this.referredBy,
    this.referralCommission,
    this.referralStatus,
    this.referralTxnId,
    this.fcmToken,
    this.permissions,
    this.createdAt,
    this.updatedAt,
    this.walletBalance,
    this.referralCount,
    this.subscription,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    importId = json['import_id'];
    groupId = json['group_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    dob = json['dob'];
    closeContactPhone = json['close_contact_phone'];
    occupation = json['occupation'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    maritalStatus = json['marital_status'];
    weddingDate = json['wedding_date'];
    spouseName = json['spouse_name'];
    spouseDob = json['spouse_dob'];
    childrens = json['childrens'];
    childrens18yrs = json['childrens_18yrs'];
    officeDoorNo = json['office_door_no'];
    officeBuildingName = json['office_building_name'];
    officeAddress = json['office_address'];
    officeCity = json['office_city'];
    officeState = json['office_state'];
    officePincode = json['office_pincode'];
    doorNo = json['door_no'];
    buildingName = json['building_name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    idProof1 = json['id_proof1'];
    idProof2 = json['id_proof2'];
    photo = json['photo'];
    phoneVerified = json['phone_verified'];
    emailVerified = json['email_verified'];
    accountVerified = json['account_verified'];
    dsaId = json['dsa_id'];
    subscriptionId = json['subscription_id'];
    referralCode = json['referral_code'];
    referredBy = json['referred_by'];
    referralCommission = json['referral_commission'];
    referralStatus = json['referral_status'];
    referralTxnId = json['referral_txn_id'];
    fcmToken = json['fcm_token'];
    permissions = json['permissions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    walletBalance = json['wallet_balance'];
    referralCount = json['referral_count'];
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['import_id'] = importId;
    data['group_id'] = groupId;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['status'] = status;
    data['dob'] = dob;
    data['close_contact_phone'] = closeContactPhone;
    data['occupation'] = occupation;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['marital_status'] = maritalStatus;
    data['wedding_date'] = weddingDate;
    data['spouse_name'] = spouseName;
    data['spouse_dob'] = spouseDob;
    data['childrens'] = childrens;
    data['childrens_18yrs'] = childrens18yrs;
    data['office_door_no'] = officeDoorNo;
    data['office_building_name'] = officeBuildingName;
    data['office_address'] = officeAddress;
    data['office_city'] = officeCity;
    data['office_state'] = officeState;
    data['office_pincode'] = officePincode;
    data['door_no'] = doorNo;
    data['building_name'] = buildingName;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    data['id_proof1'] = idProof1;
    data['id_proof2'] = idProof2;
    data['photo'] = photo;
    data['phone_verified'] = phoneVerified;
    data['email_verified'] = emailVerified;
    data['account_verified'] = accountVerified;
    data['dsa_id'] = dsaId;
    data['subscription_id'] = subscriptionId;
    data['referral_code'] = referralCode;
    data['referred_by'] = referredBy;
    data['referral_commission'] = referralCommission;
    data['referral_status'] = referralStatus;
    data['referral_txn_id'] = referralTxnId;
    data['fcm_token'] = fcmToken;
    data['permissions'] = permissions;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['wallet_balance'] = walletBalance;
    data['referral_count'] = referralCount;

    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }

    return data;
  }
}

class Subscription {
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

  Subscription({
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

  Subscription.fromJson(json) {
    id = json['id'];
    couponId = json['coupon_id'];
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
}

class BusinessProfileResponse {
  String? status;
  String? message;
  BusinessProfileData? data;

  BusinessProfileResponse({this.status, this.message, this.data});

  BusinessProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? BusinessProfileData.fromJson(json['data']) : null;
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

class BusinessProfileData {
  String? id;
  String? groupId;
  String? name;
  String? phone;
  String? mobile;
  String? bvcnumber;
  String? bvcnumberStatus;
  String? email;
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
  String? permissions;
  String? createdAt;
  String? updatedAt;
  String? walletBalance;
  String? referralCount;
  List<Subscription>? subscription;

  BusinessProfileData({
    this.id,
    this.groupId,
    this.name,
    this.phone,
    this.mobile,
    this.bvcnumber,
    this.bvcnumberStatus,
    this.email,
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
    this.permissions,
    this.createdAt,
    this.updatedAt,
    this.walletBalance,
    this.referralCount,
    this.subscription,
  });

  BusinessProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    name = json['name'];
    phone = json['phone'];
    mobile = json['mobile'];
    bvcnumber = json['bvcnumber'];
    bvcnumberStatus = json['bvcnumber_status'];
    email = json['email'];
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
    permissions = json['permissions'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    walletBalance = json['wallet_balance'];
    referralCount = json['referral_count'];
    if (json['subscription'] != null) {
      subscription = <Subscription>[];
      json['subscription'].forEach((v) {
        subscription!.add(Subscription.fromJson(v));
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
    data['permissions'] = permissions;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['wallet_balance'] = walletBalance;
    data['referral_count'] = referralCount;
    if (subscription != null) {
      data['subscription'] = subscription!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
