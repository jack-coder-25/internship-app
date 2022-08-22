class VendorSearchResponse {
  String? status;
  String? message;
  List<Data>? data;

  VendorSearchResponse({this.status, this.message, this.data});

  VendorSearchResponse.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
