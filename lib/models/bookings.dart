class MemberBookingsReponse {
  String? status;
  String? message;
  List<MemberBookingsData>? data;

  MemberBookingsReponse({
    this.status,
    this.message,
    this.data,
  });

  MemberBookingsReponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MemberBookingsData>[];
      json['data'].forEach((v) {
        data!.add(MemberBookingsData.fromJson(v));
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

class MemberBookingsData {
  String? id;
  String? userId;
  String? serviceId;
  String? slotId;
  String? qty;
  String? amount;
  String? bvcAmount;
  String? amountTotal;
  String? bvcAmountTotal;
  AdditionalServices? additionalServices;
  String? additionalAmount;
  String? additionalAmountStatus;
  String? otp;
  String? status;
  String? remarks;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? vendorName;

  MemberBookingsData({
    this.id,
    this.userId,
    this.serviceId,
    this.slotId,
    this.qty,
    this.amount,
    this.bvcAmount,
    this.amountTotal,
    this.bvcAmountTotal,
    this.additionalServices,
    this.additionalAmount,
    this.additionalAmountStatus,
    this.otp,
    this.status,
    this.remarks,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.vendorName,
  });

  MemberBookingsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    slotId = json['slot_id'];
    qty = json['qty'];
    amount = json['amount'];
    bvcAmount = json['bvc_amount'];
    amountTotal = json['amount_total'];
    bvcAmountTotal = json['bvc_amount_total'];

    additionalServices = json['additional_services'] != null
        ? AdditionalServices.fromJson(json['additional_services'])
        : null;

    additionalAmount = json['additional_amount'];
    additionalAmountStatus = json['additional_amount_status'];
    otp = json['otp'];
    status = json['status'];
    remarks = json['remarks'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    vendorName = json['vendor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['service_id'] = serviceId;
    data['slot_id'] = slotId;
    data['qty'] = qty;
    data['amount'] = amount;
    data['bvc_amount'] = bvcAmount;
    data['amount_total'] = amountTotal;
    data['bvc_amount_total'] = bvcAmountTotal;

    if (additionalServices != null) {
      data['additional_services'] = additionalServices!.toJson();
    }

    data['additional_amount'] = additionalAmount;
    data['additional_amount_status'] = additionalAmountStatus;
    data['otp'] = otp;
    data['status'] = status;
    data['remarks'] = remarks;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['title'] = title;
    data['vendor_name'] = vendorName;
    return data;
  }
}

class AdditionalServices {
  String? amountGst;
  String? amountTotal;
  String? amountSubTotal;

  AdditionalServices({this.amountGst, this.amountTotal, this.amountSubTotal});

  AdditionalServices.fromJson(Map<String, dynamic> json) {
    amountGst = json['amount_gst'];
    amountTotal = json['amount_total'];
    amountSubTotal = json['amount_sub_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['amount_gst'] = amountGst;
    data['amount_total'] = amountTotal;
    data['amount_sub_total'] = amountSubTotal;
    return data;
  }
}

class BusinessBookingsReponse {
  String? status;
  String? message;
  List<BusinessBookingsData>? data;

  BusinessBookingsReponse({this.status, this.message, this.data});

  BusinessBookingsReponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['data'] != null) {
      data = <BusinessBookingsData>[];
      json['data'].forEach((v) {
        data!.add(BusinessBookingsData.fromJson(v));
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

class BusinessBookingsData {
  String? id;
  String? userId;
  String? serviceId;
  String? slotId;
  String? qty;
  String? amount;
  String? bvcAmount;
  String? amountTotal;
  String? bvcAmountTotal;
  AdditionalServices? additionalServices;
  String? additionalAmount;
  String? additionalAmountStatus;
  String? otp;
  String? status;
  String? remarks;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? phone;
  String? title;
  String? description;
  String? startAt;
  String? endAt;

  BusinessBookingsData({
    this.id,
    this.userId,
    this.serviceId,
    this.slotId,
    this.qty,
    this.amount,
    this.bvcAmount,
    this.amountTotal,
    this.bvcAmountTotal,
    this.additionalServices,
    this.additionalAmount,
    this.additionalAmountStatus,
    this.otp,
    this.status,
    this.remarks,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.phone,
    this.title,
    this.description,
    this.startAt,
    this.endAt,
  });

  BusinessBookingsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    slotId = json['slot_id'];
    qty = json['qty'];
    amount = json['amount'];
    bvcAmount = json['bvc_amount'];
    amountTotal = json['amount_total'];
    bvcAmountTotal = json['bvc_amount_total'];
    additionalServices = json['additional_services'] != null
        ? AdditionalServices.fromJson(json['additional_services'])
        : null;
    additionalAmount = json['additional_amount'];
    additionalAmountStatus = json['additional_amount_status'];
    otp = json['otp'];
    status = json['status'];
    remarks = json['remarks'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    phone = json['phone'];
    title = json['title'];
    description = json['description'];
    startAt = json['start_at'];
    endAt = json['end_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['service_id'] = serviceId;
    data['slot_id'] = slotId;
    data['qty'] = qty;
    data['amount'] = amount;
    data['bvc_amount'] = bvcAmount;
    data['amount_total'] = amountTotal;
    data['bvc_amount_total'] = bvcAmountTotal;

    if (additionalServices != null) {
      data['additional_services'] = additionalServices!.toJson();
    }

    data['additional_amount'] = additionalAmount;
    data['additional_amount_status'] = additionalAmountStatus;
    data['otp'] = otp;
    data['status'] = status;
    data['remarks'] = remarks;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['phone'] = phone;
    data['title'] = title;
    data['description'] = description;
    data['start_at'] = startAt;
    data['end_at'] = endAt;
    return data;
  }
}
