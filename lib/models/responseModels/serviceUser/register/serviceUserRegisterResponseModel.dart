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
  String email;
  String phoneNumber;
  String userName;
  String gender;
  String dob;
  String age;
  String storePhone;
  String isTherapist;
  String userOccupation;
  bool isActive;
  bool isAccepted;
  String uploadProfileImgUrl;
  String userId;
  String updatedAt;
  String createdAt;

  UserResponse(
      {this.isVerified,
        this.coronaMeasure,
        this.id,
        this.email,
        this.phoneNumber,
        this.userName,
        this.gender,
        this.dob,
        this.age,
        this.storePhone,
        this.isTherapist,
        this.userOccupation,
        this.isActive,
        this.isAccepted,
        this.uploadProfileImgUrl,
        this.userId,
        this.updatedAt,
        this.createdAt});

  UserResponse.fromJson(Map<String, dynamic> json) {
    isVerified = json['isVerified'];
    coronaMeasure = json['coronaMeasure'];
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    userName = json['userName'];
    gender = json['gender'];
    dob = json['dob'];
    age = json['age'];
    storePhone = json['storePhone'];
    isTherapist = json['isTherapist'];
    userOccupation = json['userOccupation'];
    isActive = json['isActive'];
    isAccepted = json['isAccepted'];
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
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['userName'] = this.userName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['storePhone'] = this.storePhone;
    data['isTherapist'] = this.isTherapist;
    data['userOccupation'] = this.userOccupation;
    data['isActive'] = this.isActive;
    data['isAccepted'] = this.isAccepted;
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
  String address;
  String area;
  String lat;
  String lon;
  String userPlaceForMassage;
  String userRoomNumber;
  String addressTypeSelection;
  int userId;
  String createdUser;
  String updatedUser;
  String updatedAt;
  String createdAt;

  AddressResponse(
      {this.id,
        this.buildingName,
        this.address,
        this.area,
        this.lat,
        this.lon,
        this.userPlaceForMassage,
        this.userRoomNumber,
        this.addressTypeSelection,
        this.userId,
        this.createdUser,
        this.updatedUser,
        this.updatedAt,
        this.createdAt});

  AddressResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buildingName = json['buildingName'];
    address = json['address'];
    area = json['area'];
    lat = json['lat'];
    lon = json['lon'];
    userPlaceForMassage = json['userPlaceForMassage'];
    userRoomNumber = json['userRoomNumber'];
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
    data['address'] = this.address;
    data['area'] = this.area;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['userPlaceForMassage'] = this.userPlaceForMassage;
    data['userRoomNumber'] = this.userRoomNumber;
    data['addressTypeSelection'] = this.addressTypeSelection;
    data['userId'] = this.userId;
    data['createdUser'] = this.createdUser;
    data['updatedUser'] = this.updatedUser;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
