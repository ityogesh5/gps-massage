class StripePayOutVerifyFieldsModel {
  String status;
  Message message;

  StripePayOutVerifyFieldsModel({this.status, this.message});

  StripePayOutVerifyFieldsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message.toJson();
    }
    return data;
  }
}

class Message {
  String object;
  int created;
  int expiresAt;
  String url;

  Message({this.object, this.created, this.expiresAt, this.url});

  Message.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    created = json['created'];
    expiresAt = json['expires_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object'] = this.object;
    data['created'] = this.created;
    data['expires_at'] = this.expiresAt;
    data['url'] = this.url;
    return data;
  }
}
