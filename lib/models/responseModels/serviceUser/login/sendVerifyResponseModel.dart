class SendVerifyResponseModel {
  String status;
  String message;
  Data data;

  SendVerifyResponseModel({this.status, this.message, this.data});

  SendVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  bool isFulfilled;
  bool isRejected;

  Data({this.isFulfilled, this.isRejected});

  Data.fromJson(Map<String, dynamic> json) {
    isFulfilled = json['isFulfilled'];
    isRejected = json['isRejected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isFulfilled'] = this.isFulfilled;
    data['isRejected'] = this.isRejected;
    return data;
  }
}
