class GuestUserModel {
  String status;
  String accessToken;
  Data data;

  GuestUserModel({this.status, this.accessToken, this.data});

  GuestUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['accessToken'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['accessToken'] = this.accessToken;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  bool guestUserStatus;
  int otp;
  bool isTherapist;
  bool isVerified;
  bool isActive;
  int isAccepted;
  bool coronaMeasure;
  bool isShop;
  int id;
  String updatedAt;
  String createdAt;

  Data(
      {this.guestUserStatus,
        this.otp,
        this.isTherapist,
        this.isVerified,
        this.isActive,
        this.isAccepted,
        this.coronaMeasure,
        this.isShop,
        this.id,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    guestUserStatus = json['guestUserStatus'];
    otp = json['otp'];
    isTherapist = json['isTherapist'];
    isVerified = json['isVerified'];
    isActive = json['isActive'];
    isAccepted = json['isAccepted'];
    coronaMeasure = json['coronaMeasure'];
    isShop = json['isShop'];
    id = json['id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guestUserStatus'] = this.guestUserStatus;
    data['otp'] = this.otp;
    data['isTherapist'] = this.isTherapist;
    data['isVerified'] = this.isVerified;
    data['isActive'] = this.isActive;
    data['isAccepted'] = this.isAccepted;
    data['coronaMeasure'] = this.coronaMeasure;
    data['isShop'] = this.isShop;
    data['id'] = this.id;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
