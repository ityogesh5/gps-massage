class GetUserDetailsByIdModel {
  String status;
  Data data;

  GetUserDetailsByIdModel({this.status, this.data});

  GetUserDetailsByIdModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  String email;
  int phoneNumber;
  String userName;
  String gender;
  String dob;
  int age;
  bool isTherapist;
  bool isVerified;
  String userOccupation;
  String uploadProfileImgUrl;
  dynamic userSearchRadiusDistance;
  List<UserAddresses> addresses;

  Data(
      {this.id,
      this.email,
      this.phoneNumber,
      this.userName,
      this.gender,
      this.dob,
      this.age,
      this.isTherapist,
      this.isVerified,
      this.userOccupation,
      this.uploadProfileImgUrl,
      this.userSearchRadiusDistance,
      this.addresses});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    userName = json['userName'];
    gender = json['gender'];
    dob = json['dob'];
    age = json['age'];
    isTherapist = json['isTherapist'];
    isVerified = json['isVerified'];
    userOccupation = json['userOccupation'];
    uploadProfileImgUrl = json['uploadProfileImgUrl'];
    userSearchRadiusDistance = json['userSearchRadiusDistance'];
    if (json['addresses'] != null) {
      addresses = new List<UserAddresses>();
      json['addresses'].forEach((v) {
        addresses.add(new UserAddresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['userName'] = this.userName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['isTherapist'] = this.isTherapist;
    data['isVerified'] = this.isVerified;
    data['userOccupation'] = this.userOccupation;
    data['uploadProfileImgUrl'] = this.uploadProfileImgUrl;
    data['userSearchRadiusDistance'] = this.userSearchRadiusDistance;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserAddresses {
  int id;
  int userId;
  String addressTypeSelection;
  String address;
  String userRoomNumber;
  String userPlaceForMassage;
  String otherAddressType;
  String capitalAndPrefecture;
  String cityName;
  String area;
  String buildingName;
  double lat;
  double lon;
  bool isDefault;

  UserAddresses(
      {this.id,
      this.userId,
      this.addressTypeSelection,
      this.address,
      this.userRoomNumber,
      this.userPlaceForMassage,
      this.otherAddressType,
      this.capitalAndPrefecture,
      this.cityName,
      this.area,
      this.buildingName,
      this.lat,
      this.lon,
      this.isDefault});

  UserAddresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    addressTypeSelection = json['addressTypeSelection'];
    address = json['address'];
    userRoomNumber = json['userRoomNumber'];
    userPlaceForMassage = json['userPlaceForMassage'];
    otherAddressType = json['otherAddressType'];
    capitalAndPrefecture = json['capitalAndPrefecture'];
    cityName = json['cityName'];
    area = json['area'];
    buildingName = json['buildingName'];
    lat = json['lat'];
    lon = json['lon'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['addressTypeSelection'] = this.addressTypeSelection;
    data['address'] = this.address;
    data['userRoomNumber'] = this.userRoomNumber;
    data['userPlaceForMassage'] = this.userPlaceForMassage;
    data['otherAddressType'] = this.otherAddressType;
    data['capitalAndPrefecture'] = this.capitalAndPrefecture;
    data['cityName'] = this.cityName;
    data['area'] = this.area;
    data['buildingName'] = this.buildingName;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['isDefault'] = this.isDefault;
    return data;
  }
}
