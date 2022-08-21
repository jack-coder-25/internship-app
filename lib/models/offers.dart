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
