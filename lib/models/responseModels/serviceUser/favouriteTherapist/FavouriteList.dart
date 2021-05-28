class FavouriteListModel {
  String status;
  Data data;

  FavouriteListModel({this.status, this.data});

  FavouriteListModel.fromJson(Map<String, dynamic> json) {
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
  dynamic count;
  List<FavouriteUserList> favouriteUserList;
  dynamic totalPages;
  dynamic pageNumber;

  Data({this.count, this.favouriteUserList, this.totalPages, this.pageNumber});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['favouriteUserList'] != null) {
      favouriteUserList = new List<FavouriteUserList>();
      json['favouriteUserList'].forEach((v) {
        favouriteUserList.add(new FavouriteUserList.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    pageNumber = json['pageNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.favouriteUserList != null) {
      data['favouriteUserList'] =
          this.favouriteUserList.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['pageNumber'] = this.pageNumber;
    return data;
  }
}

class FavouriteUserList {
  dynamic id;
  dynamic userId;
  dynamic therapistId;
  bool isFavourite;
  String createdUser;
  String updatedUser;
  String createdAt;
  String updatedAt;
  FavouriteTherapistId favouriteTherapistId;
  dynamic reviewAvgData;
  dynamic noOfReviewsMembers;

  FavouriteUserList(
      {this.id,
      this.userId,
      this.therapistId,
      this.isFavourite,
      this.createdUser,
      this.updatedUser,
      this.createdAt,
      this.updatedAt,
      this.favouriteTherapistId,
      this.reviewAvgData,
      this.noOfReviewsMembers});

  FavouriteUserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    therapistId = json['therapistId'];
    isFavourite = json['isFavourite'];
    createdUser = json['createdUser'];
    updatedUser = json['updatedUser'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    favouriteTherapistId = json['favouriteTherapistId'] != null
        ? new FavouriteTherapistId.fromJson(json['favouriteTherapistId'])
        : null;
    reviewAvgData = json['reviewAvgData'];
    noOfReviewsMembers = json['NoOfReviewsMembers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['therapistId'] = this.therapistId;
    data['isFavourite'] = this.isFavourite;
    data['createdUser'] = this.createdUser;
    data['updatedUser'] = this.updatedUser;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.favouriteTherapistId != null) {
      data['favouriteTherapistId'] = this.favouriteTherapistId.toJson();
    }
    data['reviewAvgData'] = this.reviewAvgData;
    data['NoOfReviewsMembers'] = this.noOfReviewsMembers;
    return data;
  }
}

class FavouriteTherapistId {
  dynamic id;
  String userId;
  bool guestUserStatus;
  String email;
  dynamic phoneNumber;
  Null firebaseUDID;
  Null fcmToken;
  Null lineBotUserId;
  Null appleUserId;
  String userName;
  String dob;
  dynamic age;
  String gender;
  bool isTherapist;
  bool isVerified;
  bool isActive;
  dynamic isAccepted;
  Null rejectReason;
  Null updatedUser;
  String uploadProfileImgUrl;
  String proofOfIdentityType;
  String proofOfIdentityImgUrl;
  String qulaificationCertImgUrl;
  String businessForm;
  dynamic numberOfEmp;
  bool businessTrip;
  bool coronaMeasure;
  String storeName;
  String storeType;
  dynamic storePhone;
  String storeDescription;
  Null userOccupation;
  String genderOfService;
  String childrenMeasure;
  Null customerId;
  Null userSearchRadiusDistance;
  bool isShop;
  String createdAt;
  String updatedAt;
  List<Addresses> addresses;
  List<CertificationUploads> certificationUploads;
  List<BankDetails> bankDetails;
  List<Banners> banners;

  FavouriteTherapistId(
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
      this.userSearchRadiusDistance,
      this.isShop,
      this.createdAt,
      this.updatedAt,
      this.addresses,
      this.certificationUploads,
      this.bankDetails,
      this.banners});

  FavouriteTherapistId.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic lat;
  dynamic lon;
  Geomet geomet;
  String address;
  String capitalAndPrefecture;
  String cityName;
  String area;
  double distance;

  Addresses(
      {this.id,
      this.lat,
      this.lon,
      this.geomet,
      this.address,
      this.capitalAndPrefecture,
      this.cityName,
      this.area,
      this.distance});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    lon = json['lon'];
    geomet =
        json['geomet'] != null ? new Geomet.fromJson(json['geomet']) : null;
    address = json['address'];
    capitalAndPrefecture = json['capitalAndPrefecture'];
    cityName = json['cityName'];
    area = json['area'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    if (this.geomet != null) {
      data['geomet'] = this.geomet.toJson();
    }
    data['address'] = this.address;
    data['capitalAndPrefecture'] = this.capitalAndPrefecture;
    data['cityName'] = this.cityName;
    data['area'] = this.area;
    data['distance'] = this.distance;
    return data;
  }
}

class Geomet {
  String type;
  List<dynamic> coordinates;

  Geomet({this.type, this.coordinates});

  Geomet.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class CertificationUploads {
  dynamic id;
  dynamic userId;
  String acupuncturist;
  String moxibutionist;
  String acupuncturistAndMoxibustion;
  String anmaMassageShiatsushi;
  String judoRehabilitationTeacher;
  String physicalTherapist;
  String acquireNationalQualifications;
  String privateQualification1;
  String privateQualification2;
  String privateQualification3;
  String privateQualification4;
  String privateQualification5;
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
  dynamic id;
  dynamic userId;
  String bankName;
  String branchCode;
  String branchNumber;
  String accountNumber;
  String accountType;
  String createdAt;
  String updatedAt;

  BankDetails(
      {this.id,
      this.userId,
      this.bankName,
      this.branchCode,
      this.branchNumber,
      this.accountNumber,
      this.accountType,
      this.createdAt,
      this.updatedAt});

  BankDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    bankName = json['bankName'];
    branchCode = json['branchCode'];
    branchNumber = json['branchNumber'];
    accountNumber = json['accountNumber'];
    accountType = json['accountType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['bankName'] = this.bankName;
    data['branchCode'] = this.branchCode;
    data['branchNumber'] = this.branchNumber;
    data['accountNumber'] = this.accountNumber;
    data['accountType'] = this.accountType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Banners {
  dynamic id;
  dynamic userId;
  String bannerImageUrl1;
  String bannerImageUrl2;
  String bannerImageUrl3;
  String bannerImageUrl4;
  String bannerImageUrl5;
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
