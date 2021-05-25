class FavouriteTherapist {
  String status;
  Data data;

  FavouriteTherapist({this.status, this.data});

  FavouriteTherapist.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic userId;
  dynamic therapistId;
  bool isFavourite;
  dynamic createdUser;
  dynamic updatedUser;
  dynamic updatedAt;
  dynamic createdAt;

  Data(
      {this.id,
      this.userId,
      this.therapistId,
      this.isFavourite,
      this.createdUser,
      this.updatedUser,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    therapistId = json['therapistId'];
    isFavourite = json['isFavourite'];
    createdUser = json['createdUser'];
    updatedUser = json['updatedUser'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['therapistId'] = this.therapistId;
    data['isFavourite'] = this.isFavourite;
    data['createdUser'] = this.createdUser;
    data['updatedUser'] = this.updatedUser;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
