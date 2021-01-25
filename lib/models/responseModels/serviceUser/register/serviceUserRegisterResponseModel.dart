class ServiceUserRegisterModel {
  String status;
  Data data;

  ServiceUserRegisterModel({this.status, this.data});

  ServiceUserRegisterModel.fromJson(Map<String, dynamic> json) {
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
  String token;
  UserResponse userResponse;
  AddressResponse addressResponse;

  Data({this.token, this.userResponse, this.addressResponse});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userResponse = json['userResponse'] != null
        ? new UserResponse.fromJson(json['userResponse'])
        : null;
    addressResponse = json['addressResponse'] != null
        ? new AddressResponse.fromJson(json['addressResponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.userResponse != null) {
      data['userResponse'] = this.userResponse.toJson();
    }
    if (this.addressResponse != null) {
      data['addressResponse'] = this.addressResponse.toJson();
    }
    return data;
  }
}

class UserResponse {
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
  String gender;
  bool isActive;
  String uploadProfileImgUrl;
  String userId;
  String updatedAt;
  String createdAt;

  UserResponse(
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
        this.gender,
        this.isActive,
        this.uploadProfileImgUrl,
        this.userId,
        this.updatedAt,
        this.createdAt});

  UserResponse.fromJson(Map<String, dynamic> json) {
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
    gender = json['gender'];
    isActive = json['isActive'];
    uploadProfileImgUrl = json['uploadProfileImgUrl'];
    userId = json['userId'];
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
    data['gender'] = this.gender;
    data['isActive'] = this.isActive;
    data['uploadProfileImgUrl'] = this.uploadProfileImgUrl;
    data['userId'] = this.userId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class AddressResponse {
  int id;
  String buildingName;
  String area;
  String address;
  String lat;
  String lon;
  String addressTypeSelection;
  int userId;
  String createdUser;
  String updatedUser;
  String updatedAt;
  String createdAt;

  AddressResponse(
      {this.id,
        this.buildingName,
        this.area,
        this.address,
        this.lat,
        this.lon,
        this.addressTypeSelection,
        this.userId,
        this.createdUser,
        this.updatedUser,
        this.updatedAt,
        this.createdAt});

  AddressResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buildingName = json['buildingName'];
    area = json['area'];
    address = json['address'];
    lat = json['lat'];
    lon = json['lon'];
    addressTypeSelection = json['addressTypeSelection'];
    userId = json['userId'];
    createdUser = json['createdUser'];
    updatedUser = json['updatedUser'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['buildingName'] = this.buildingName;
    data['area'] = this.area;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['addressTypeSelection'] = this.addressTypeSelection;
    data['userId'] = this.userId;
    data['createdUser'] = this.createdUser;
    data['updatedUser'] = this.updatedUser;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
