class TherapistDetailsModel {
  String status;
  Data data;
  ReviewData reviewData;

  TherapistDetailsModel({this.status, this.data, this.reviewData});

  TherapistDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    reviewData = json['reviewData'] != null
        ? new ReviewData.fromJson(json['reviewData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.reviewData != null) {
      data['reviewData'] = this.reviewData.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String userId;
  bool guestUserStatus;
  String email;
  int phoneNumber;
  String firebaseUDID;
  dynamic fcmToken;
  dynamic lineBotUserId;
  dynamic appleUserId;
  String userName;
  String dob;
  int age;
  String gender;
  bool isTherapist;
  bool isVerified;
  bool isActive;
  int isAccepted;
  dynamic rejectReason;
  String updatedUser;
  String uploadProfileImgUrl;
  String proofOfIdentityType;
  String proofOfIdentityImgUrl;
  String qulaificationCertImgUrl;
  String businessForm;
  int numberOfEmp;
  bool businessTrip;
  bool coronaMeasure;
  String storeName;
  String storeType;
  int storePhone;
  dynamic storeDescription;
  dynamic userOccupation;
  String genderOfService;
  String childrenMeasure;
  dynamic customerId;
  dynamic accountId;
  bool isStripeVerified;
  dynamic userSearchRadiusDistance;
  bool isShop;
  String createdAt;
  String updatedAt;
  List<Addresses> addresses;
  List<CertificationUploads> certificationUploads;
  List<BankDetails> bankDetails;
  List<Banners> banners;

  Data(
      {this.id,
      this.userId,
      this.guestUserStatus,
      this.email,
      this.phoneNumber,
      this.firebaseUDID,
      this.fcmToken,
      this.lineBotUserId,
      this.appleUserId,
      this.userName,
      this.dob,
      this.age,
      this.gender,
      this.isTherapist,
      this.isVerified,
      this.isActive,
      this.isAccepted,
      this.rejectReason,
      this.updatedUser,
      this.uploadProfileImgUrl,
      this.proofOfIdentityType,
      this.proofOfIdentityImgUrl,
      this.qulaificationCertImgUrl,
      this.businessForm,
      this.numberOfEmp,
      this.businessTrip,
      this.coronaMeasure,
      this.storeName,
      this.storeType,
      this.storePhone,
      this.storeDescription,
      this.userOccupation,
      this.genderOfService,
      this.childrenMeasure,
      this.customerId,
      this.accountId,
      this.isStripeVerified,
      this.userSearchRadiusDistance,
      this.isShop,
      this.createdAt,
      this.updatedAt,
      this.addresses,
      this.certificationUploads,
      this.bankDetails,
      this.banners});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    guestUserStatus = json['guestUserStatus'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    firebaseUDID = json['firebaseUDID'];
    fcmToken = json['fcmToken'];
    lineBotUserId = json['lineBotUserId'];
    appleUserId = json['appleUserId'];
    userName = json['userName'];
    dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    isTherapist = json['isTherapist'];
    isVerified = json['isVerified'];
    isActive = json['isActive'];
    isAccepted = json['isAccepted'];
    rejectReason = json['rejectReason'];
    updatedUser = json['updatedUser'];
    uploadProfileImgUrl = json['uploadProfileImgUrl'];
    proofOfIdentityType = json['proofOfIdentityType'];
    proofOfIdentityImgUrl = json['proofOfIdentityImgUrl'];
    qulaificationCertImgUrl = json['qulaificationCertImgUrl'];
    businessForm = json['businessForm'];
    numberOfEmp = json['numberOfEmp'];
    businessTrip = json['businessTrip'];
    coronaMeasure = json['coronaMeasure'];
    storeName = json['storeName'];
    storeType = json['storeType'];
    storePhone = json['storePhone'];
    storeDescription = json['storeDescription'];
    userOccupation = json['userOccupation'];
    genderOfService = json['genderOfService'];
    childrenMeasure = json['childrenMeasure'];
    customerId = json['customerId'];
    accountId = json['accountId'];
    isStripeVerified = json['isStripeVerified'];
    userSearchRadiusDistance = json['userSearchRadiusDistance'];
    isShop = json['isShop'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    if (json['certification_uploads'] != null) {
      certificationUploads = new List<CertificationUploads>();
      json['certification_uploads'].forEach((v) {
        certificationUploads.add(new CertificationUploads.fromJson(v));
      });
    }
    if (json['bankDetails'] != null) {
      bankDetails = new List<BankDetails>();
      json['bankDetails'].forEach((v) {
        bankDetails.add(new BankDetails.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = new List<Banners>();
      json['banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['guestUserStatus'] = this.guestUserStatus;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['firebaseUDID'] = this.firebaseUDID;
    data['fcmToken'] = this.fcmToken;
    data['lineBotUserId'] = this.lineBotUserId;
    data['appleUserId'] = this.appleUserId;
    data['userName'] = this.userName;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['isTherapist'] = this.isTherapist;
    data['isVerified'] = this.isVerified;
    data['isActive'] = this.isActive;
    data['isAccepted'] = this.isAccepted;
    data['rejectReason'] = this.rejectReason;
    data['updatedUser'] = this.updatedUser;
    data['uploadProfileImgUrl'] = this.uploadProfileImgUrl;
    data['proofOfIdentityType'] = this.proofOfIdentityType;
    data['proofOfIdentityImgUrl'] = this.proofOfIdentityImgUrl;
    data['qulaificationCertImgUrl'] = this.qulaificationCertImgUrl;
    data['businessForm'] = this.businessForm;
    data['numberOfEmp'] = this.numberOfEmp;
    data['businessTrip'] = this.businessTrip;
    data['coronaMeasure'] = this.coronaMeasure;
    data['storeName'] = this.storeName;
    data['storeType'] = this.storeType;
    data['storePhone'] = this.storePhone;
    data['storeDescription'] = this.storeDescription;
    data['userOccupation'] = this.userOccupation;
    data['genderOfService'] = this.genderOfService;
    data['childrenMeasure'] = this.childrenMeasure;
    data['customerId'] = this.customerId;
    data['accountId'] = this.accountId;
    data['isStripeVerified'] = this.isStripeVerified;
    data['userSearchRadiusDistance'] = this.userSearchRadiusDistance;
    data['isShop'] = this.isShop;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    if (this.certificationUploads != null) {
      data['certification_uploads'] =
          this.certificationUploads.map((v) => v.toJson()).toList();
    }
    if (this.bankDetails != null) {
      data['bankDetails'] = this.bankDetails.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  int id;
  int userId;
  String addressTypeSelection;
  String address;
  String userRoomNumber;
  dynamic userPlaceForMassage;
  dynamic otherAddressType;
  String capitalAndPrefecture;
  int capitalAndPrefectureId;
  String cityName;
  int citiesId;
  String area;
  String buildingName;
  dynamic postalCode;
  Geomet geomet;
  double lat;
  double lon;
  String createdUser;
  String updatedUser;
  bool isDefault;
  String createdAt;
  String updatedAt;

  Addresses(
      {this.id,
      this.userId,
      this.addressTypeSelection,
      this.address,
      this.userRoomNumber,
      this.userPlaceForMassage,
      this.otherAddressType,
      this.capitalAndPrefecture,
      this.capitalAndPrefectureId,
      this.cityName,
      this.citiesId,
      this.area,
      this.buildingName,
      this.postalCode,
      this.geomet,
      this.lat,
      this.lon,
      this.createdUser,
      this.updatedUser,
      this.isDefault,
      this.createdAt,
      this.updatedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    addressTypeSelection = json['addressTypeSelection'];
    address = json['address'];
    userRoomNumber = json['userRoomNumber'];
    userPlaceForMassage = json['userPlaceForMassage'];
    otherAddressType = json['otherAddressType'];
    capitalAndPrefecture = json['capitalAndPrefecture'];
    capitalAndPrefectureId = json['capitalAndPrefectureId'];
    cityName = json['cityName'];
    citiesId = json['citiesId'];
    area = json['area'];
    buildingName = json['buildingName'];
    postalCode = json['postalCode'];
    geomet =
        json['geomet'] != null ? new Geomet.fromJson(json['geomet']) : null;
    lat = json['lat'];
    lon = json['lon'];
    createdUser = json['createdUser'];
    updatedUser = json['updatedUser'];
    isDefault = json['isDefault'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['capitalAndPrefectureId'] = this.capitalAndPrefectureId;
    data['cityName'] = this.cityName;
    data['citiesId'] = this.citiesId;
    data['area'] = this.area;
    data['buildingName'] = this.buildingName;
    data['postalCode'] = this.postalCode;
    if (this.geomet != null) {
      data['geomet'] = this.geomet.toJson();
    }
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['createdUser'] = this.createdUser;
    data['updatedUser'] = this.updatedUser;
    data['isDefault'] = this.isDefault;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Geomet {
  String type;
  List<double> coordinates;

  Geomet({this.type, this.coordinates});

  Geomet.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class CertificationUploads {
  int id;
  int userId;
  dynamic acupuncturist;
  dynamic moxibutionist;
  dynamic acupuncturistAndMoxibustion;
  String anmaMassageShiatsushi;
  dynamic judoRehabilitationTeacher;
  dynamic physicalTherapist;
  dynamic acquireNationalQualifications;
  dynamic privateQualification1;
  dynamic privateQualification2;
  dynamic privateQualification3;
  dynamic privateQualification4;
  dynamic privateQualification5;
  String createdAt;
  String updatedAt;

  CertificationUploads(
      {this.id,
      this.userId,
      this.acupuncturist,
      this.moxibutionist,
      this.acupuncturistAndMoxibustion,
      this.anmaMassageShiatsushi,
      this.judoRehabilitationTeacher,
      this.physicalTherapist,
      this.acquireNationalQualifications,
      this.privateQualification1,
      this.privateQualification2,
      this.privateQualification3,
      this.privateQualification4,
      this.privateQualification5,
      this.createdAt,
      this.updatedAt});

  CertificationUploads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    acupuncturist = json['acupuncturist'];
    moxibutionist = json['moxibutionist'];
    acupuncturistAndMoxibustion = json['acupuncturistAndMoxibustion'];
    anmaMassageShiatsushi = json['anmaMassageShiatsushi'];
    judoRehabilitationTeacher = json['judoRehabilitationTeacher'];
    physicalTherapist = json['physicalTherapist'];
    acquireNationalQualifications = json['acquireNationalQualifications'];
    privateQualification1 = json['privateQualification1'];
    privateQualification2 = json['privateQualification2'];
    privateQualification3 = json['privateQualification3'];
    privateQualification4 = json['privateQualification4'];
    privateQualification5 = json['privateQualification5'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['acupuncturist'] = this.acupuncturist;
    data['moxibutionist'] = this.moxibutionist;
    data['acupuncturistAndMoxibustion'] = this.acupuncturistAndMoxibustion;
    data['anmaMassageShiatsushi'] = this.anmaMassageShiatsushi;
    data['judoRehabilitationTeacher'] = this.judoRehabilitationTeacher;
    data['physicalTherapist'] = this.physicalTherapist;
    data['acquireNationalQualifications'] = this.acquireNationalQualifications;
    data['privateQualification1'] = this.privateQualification1;
    data['privateQualification2'] = this.privateQualification2;
    data['privateQualification3'] = this.privateQualification3;
    data['privateQualification4'] = this.privateQualification4;
    data['privateQualification5'] = this.privateQualification5;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class BankDetails {
  BankDetails({
    this.id,
    this.userId,
    this.bankName,
    this.bankCode,
    this.branchName,
    this.branchNumber,
    this.accountNumber,
    this.accountType,
    this.accountHolderType,
    this.accountHolderName,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String bankName;
  String bankCode;
  String branchName;
  String branchNumber;
  String accountNumber;
  String accountType;
  String accountHolderType;
  String accountHolderName;
  DateTime createdAt;
  DateTime updatedAt;

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        id: json["id"],
        userId: json["userId"],
        bankName: json["bankName"],
        bankCode: json["bankCode"],
        branchName: json["branchName"],
        branchNumber: json["branchNumber"],
        accountNumber: json["accountNumber"],
        accountType: json["accountType"],
        accountHolderType: json["accountHolderType"],
        accountHolderName: json["accountHolderName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bankName": bankName,
        "bankCode": bankCode,
        "branchName": branchName,
        "branchNumber": branchNumber,
        "accountNumber": accountNumber,
        "accountType": accountType,
        "accountHolderType": accountHolderType,
        "accountHolderName": accountHolderName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Banners {
  int id;
  int userId;
  dynamic bannerImageUrl1;
  dynamic bannerImageUrl2;
  dynamic bannerImageUrl3;
  dynamic bannerImageUrl4;
  dynamic bannerImageUrl5;
  String createdAt;
  String updatedAt;

  Banners(
      {this.id,
      this.userId,
      this.bannerImageUrl1,
      this.bannerImageUrl2,
      this.bannerImageUrl3,
      this.bannerImageUrl4,
      this.bannerImageUrl5,
      this.createdAt,
      this.updatedAt});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    bannerImageUrl1 = json['bannerImageUrl1'];
    bannerImageUrl2 = json['bannerImageUrl2'];
    bannerImageUrl3 = json['bannerImageUrl3'];
    bannerImageUrl4 = json['bannerImageUrl4'];
    bannerImageUrl5 = json['bannerImageUrl5'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['bannerImageUrl1'] = this.bannerImageUrl1;
    data['bannerImageUrl2'] = this.bannerImageUrl2;
    data['bannerImageUrl3'] = this.bannerImageUrl3;
    data['bannerImageUrl4'] = this.bannerImageUrl4;
    data['bannerImageUrl5'] = this.bannerImageUrl5;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ReviewData {
  String ratingAvg;
  int noOfReviewsMembers;

  ReviewData({this.ratingAvg, this.noOfReviewsMembers});

  ReviewData.fromJson(Map<String, dynamic> json) {
    ratingAvg = json['ratingAvg'];
    noOfReviewsMembers = json['NoOfReviewsMembers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ratingAvg'] = this.ratingAvg;
    data['NoOfReviewsMembers'] = this.noOfReviewsMembers;
    return data;
  }
}
