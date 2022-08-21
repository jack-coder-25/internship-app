class WalletTransactionsResponse {
  String? status;
  String? message;
  List<Data>? data;

  WalletTransactionsResponse({this.status, this.message, this.data});

  WalletTransactionsResponse.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? type;
  String? amount;
  String? description;

  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.userId,
    this.type,
    this.amount,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    amount = json['amount'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['type'] = type;
    data['amount'] = amount;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Attributes {
  String? type;
  Lottery? lottery;
  String? ebTxnId;
  Plan? plan;

  Attributes({this.type, this.lottery, this.ebTxnId, this.plan});

  Attributes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    lottery =
        json['lottery'] != null ? Lottery.fromJson(json['lottery']) : null;
    ebTxnId = json['eb_txn_id'];
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    if (lottery != null) {
      data['lottery'] = lottery!.toJson();
    }
    data['eb_txn_id'] = ebTxnId;
    if (plan != null) {
      data['plan'] = plan!.toJson();
    }
    return data;
  }
}

class Lottery {
  String? slotCode;
  String? slotId;
  String? actualEntries;
  String? title;
  String? entryFee;
  String? targetEntries;
  List<String>? prizes;
  String? rules;

  Lottery({
    this.slotCode,
    this.slotId,
    this.actualEntries,
    this.title,
    this.entryFee,
    this.targetEntries,
    this.prizes,
    this.rules,
  });

  Lottery.fromJson(Map<String, dynamic> json) {
    slotCode = json['slot_code'];
    slotId = json['slot_id'];
    actualEntries = json['actual_entries'];
    title = json['title'];
    entryFee = json['entry_fee'];
    targetEntries = json['target_entries'];
    if (json['prizes'] != null) {
      prizes = <String>[];
      json['prizes'].forEach((v) {
        prizes!.add(v.toString());
      });
    }
    rules = json['rules'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['slot_code'] = slotCode;
    data['slot_id'] = slotId;
    data['actual_entries'] = actualEntries;
    data['title'] = title;
    data['entry_fee'] = entryFee;
    data['target_entries'] = targetEntries;
    if (prizes != null) {
      data['prizes'] = prizes!.map((v) => v.toString()).toList();
    }
    data['rules'] = rules;
    return data;
  }
}

class Plan {
  String? id;
  String? title;
  String? amount;
  String? actualAmount;
  String? dsaAmount;
  String? referralAmount;
  String? amc;
  String? dsaAmcAmount;
  String? validityDays;
  String? cardBg;
  String? description;
  String? amcImage;
  String? amcDescription;
  String? status;
  String? orderPos;
  String? createdAt;
  String? updatedAt;

  Plan(
      {this.id,
      this.title,
      this.amount,
      this.actualAmount,
      this.dsaAmount,
      this.referralAmount,
      this.amc,
      this.dsaAmcAmount,
      this.validityDays,
      this.cardBg,
      this.description,
      this.amcImage,
      this.amcDescription,
      this.status,
      this.orderPos,
      this.createdAt,
      this.updatedAt});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    amount = json['amount'];
    actualAmount = json['actual_amount'];
    dsaAmount = json['dsa_amount'];
    referralAmount = json['referral_amount'];
    amc = json['amc'];
    dsaAmcAmount = json['dsa_amc_amount'];
    validityDays = json['validity_days'];
    cardBg = json['card_bg'];
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
    data['title'] = title;
    data['amount'] = amount;
    data['actual_amount'] = actualAmount;
    data['dsa_amount'] = dsaAmount;
    data['referral_amount'] = referralAmount;
    data['amc'] = amc;
    data['dsa_amc_amount'] = dsaAmcAmount;
    data['validity_days'] = validityDays;
    data['card_bg'] = cardBg;
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

class WalletTopupResponse {
  String? status;
  String? message;
  int? walletTxnId;
  String? walletBalance;

  WalletTopupResponse({
    this.status,
    this.message,
    this.walletTxnId,
    this.walletBalance,
  });

  WalletTopupResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    walletTxnId = json['wallet_txn_id'];
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['wallet_txn_id'] = walletTxnId;
    data['wallet_balance'] = walletBalance;
    return data;
  }
}
