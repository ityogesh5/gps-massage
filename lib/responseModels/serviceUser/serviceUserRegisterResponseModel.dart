class ServiceUserRegisterModel {
  String status;
  Data data;
  Address address;

  ServiceUserRegisterModel({this.status, this.data, this.address});

  ServiceUserRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

class Data {
  bool isVerified;
  bool coronaMeasure;
  int id;
  String userName;
  String dob;
  String age;
  String userOccupation;
  String phoneNumber;
  String email;
  String isTherapist;
  String userPlaceForMassage;
  String userPrefecture;
  String userRoomNumber;
  String gender;
  String userId;
  String uploadProfileImgUrl;
  String updatedAt;
  String createdAt;

  Data(
      {this.isVerified,
        this.coronaMeasure,
        this.id,
        this.userName,
        this.dob,
        this.age,
        this.userOccupation,
        this.phoneNumber,
        this.email,
        this.isTherapist,
        this.userPlaceForMassage,
        this.userPrefecture,
        this.userRoomNumber,
        this.gender,
        this.userId,
        this.uploadProfileImgUrl,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    isVerified = json['isVerified'];
    coronaMeasure = json['coronaMeasure'];
    id = json['id'];
    userName = json['userName'];
    dob = json['dob'];
    age = json['age'];
    userOccupation = json['userOccupation'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    isTherapist = json['isTherapist'];
    userPlaceForMassage = json['userPlaceForMassage'];
    userPrefecture = json['userPrefecture'];
    userRoomNumber = json['userRoomNumber'];
    gender = json['gender'];
    userId = json['userId'];
    uploadProfileImgUrl = json['uploadProfileImgUrl'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isVerified'] = this.isVerified;
    data['coronaMeasure'] = this.coronaMeasure;
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['userOccupation'] = this.userOccupation;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['isTherapist'] = this.isTherapist;
    data['userPlaceForMassage'] = this.userPlaceForMassage;
    data['userPrefecture'] = this.userPrefecture;
    data['userRoomNumber'] = this.userRoomNumber;
    data['gender'] = this.gender;
    data['userId'] = this.userId;
    data['uploadProfileImgUrl'] = this.uploadProfileImgUrl;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Address {
  int id;
  String city;
  String buildingName;
  String area;
  String address;
  String lat;
  String lon;
  int userId;
  String createdUser;
  String updatedUser;
  String updatedAt;
  String createdAt;

  Address(
      {this.id,
        this.city,
        this.buildingName,
        this.area,
        this.address,
        this.lat,
        this.lon,
        this.userId,
        this.createdUser,
        this.updatedUser,
        this.updatedAt,
        this.createdAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    buildingName = json['buildingName'];
    area = json['area'];
    address = json['address'];
    lat = json['lat'];
    lon = json['lon'];
    userId = json['userId'];
    createdUser = json['createdUser'];
    updatedUser = json['updatedUser'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city'] = this.city;
    data['buildingName'] = this.buildingName;
    data['area'] = this.area;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['userId'] = this.userId;
    data['createdUser'] = this.createdUser;
    data['updatedUser'] = this.updatedUser;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
