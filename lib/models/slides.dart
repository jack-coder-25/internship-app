class SlidesResponse {
  String? status;
  String? message;
  List<Data>? data;

  SlidesResponse({this.status, this.message, this.data});

  SlidesResponse.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data ={};
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
  String? app;
  String? image;
  String? actionUrl;
  String? orderPos;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.app,
      this.image,
      this.actionUrl,
      this.orderPos,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    app = json['app'];
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
    data['app'] = app;
    data['image'] = image;
    data['action_url'] = actionUrl;
    data['order_pos'] = orderPos;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
