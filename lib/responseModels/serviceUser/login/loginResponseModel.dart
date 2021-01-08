class LoginResponseModel {
  String status;
  String accessToken;
  Data data;

  LoginResponseModel({this.status, this.accessToken, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  String userId;
  String email;
  int phoneNumber;
  String userName;
  String dob;
  int age;
  String gender;
  bool isTherapist;
  bool isVerified;
  String uploadProfileImgUrl;
  String proofOfIdentityType;
  String proofOfIdentityImgUrl;
  Null qulaificationCertImgUrl;
  String businessForm;
  int numberOfEmp;
  bool businessTrip;
  bool coronaMeasure;
  String storeName;
  int storePhone;
  Null userOccupation;
  String childrenMeasure;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.userId,
      this.email,
      this.phoneNumber,
      this.userName,
      this.dob,
      this.age,
      this.gender,
      this.isTherapist,
      this.isVerified,
      this.uploadProfileImgUrl,
      this.proofOfIdentityType,
      this.proofOfIdentityImgUrl,
      this.qulaificationCertImgUrl,
      this.businessForm,
      this.numberOfEmp,
      this.businessTrip,
      this.coronaMeasure,
      this.storeName,
      this.storePhone,
      this.userOccupation,
      this.childrenMeasure,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    userName = json['userName'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    isTherapist = json['isTherapist'];
    isVerified = json['isVerified'];
    uploadProfileImgUrl = json['uploadProfileImgUrl'];
    proofOfIdentityType = json['proofOfIdentityType'];
    proofOfIdentityImgUrl = json['proofOfIdentityImgUrl'];
    qulaificationCertImgUrl = json['qulaificationCertImgUrl'];
    businessForm = json['businessForm'];
    numberOfEmp = json['numberOfEmp'];
    businessTrip = json['businessTrip'];
    coronaMeasure = json['coronaMeasure'];
    storeName = json['storeName'];
    storePhone = json['storePhone'];
    userOccupation = json['userOccupation'];
    childrenMeasure = json['childrenMeasure'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['userName'] = this.userName;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['isTherapist'] = this.isTherapist;
    data['isVerified'] = this.isVerified;
    data['uploadProfileImgUrl'] = this.uploadProfileImgUrl;
    data['proofOfIdentityType'] = this.proofOfIdentityType;
    data['proofOfIdentityImgUrl'] = this.proofOfIdentityImgUrl;
    data['qulaificationCertImgUrl'] = this.qulaificationCertImgUrl;
    data['businessForm'] = this.businessForm;
    data['numberOfEmp'] = this.numberOfEmp;
    data['businessTrip'] = this.businessTrip;
    data['coronaMeasure'] = this.coronaMeasure;
    data['storeName'] = this.storeName;
    data['storePhone'] = this.storePhone;
    data['userOccupation'] = this.userOccupation;
    data['childrenMeasure'] = this.childrenMeasure;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
