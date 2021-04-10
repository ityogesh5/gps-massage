class TherapistsByTypeModel {
  String status;
  TherapistData therapistData;

  TherapistsByTypeModel({this.status, this.therapistData});

  TherapistsByTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    therapistData = json['therapistData'] != null
        ? new TherapistData.fromJson(json['therapistData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.therapistData != null) {
      data['therapistData'] = this.therapistData.toJson();
    }
    return data;
  }
}

class TherapistData {
  int count;
  List<UserTypeList> userList;
  int totalPages;
  int pageNumber;

  TherapistData({this.count, this.userList, this.totalPages, this.pageNumber});

  TherapistData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['userList'] != null) {
      userList = new List<UserTypeList>();
      json['userList'].forEach((v) {
        userList.add(new UserTypeList.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    pageNumber = json['pageNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.userList != null) {
      data['userList'] = this.userList.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['pageNumber'] = this.pageNumber;
    return data;
  }
}

class UserTypeList {
  int id;
  int userId;
  int orteopathicId;
  String name;
  int sixtyMin;
  int nintyMin;
  int oneTwentyMin;
  int oneFifityMin;
  int oneEightyMin;
  String createdAt;
  String updatedAt;
  User user;

  UserTypeList(
      {this.id,
        this.userId,
        this.orteopathicId,
        this.name,
        this.sixtyMin,
        this.nintyMin,
        this.oneTwentyMin,
        this.oneFifityMin,
        this.oneEightyMin,
        this.createdAt,
        this.updatedAt,
        this.user});

  UserTypeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    orteopathicId = json['orteopathicId'];
    name = json['name'];
    sixtyMin = json['sixtyMin'];
    nintyMin = json['nintyMin'];
    oneTwentyMin = json['oneTwentyMin'];
    oneFifityMin = json['oneFifityMin'];
    oneEightyMin = json['oneEightyMin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['orteopathicId'] = this.orteopathicId;
    data['name'] = this.name;
    data['sixtyMin'] = this.sixtyMin;
    data['nintyMin'] = this.nintyMin;
    data['oneTwentyMin'] = this.oneTwentyMin;
    data['oneFifityMin'] = this.oneFifityMin;
    data['oneEightyMin'] = this.oneEightyMin;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String userId;
  String email;
  int phoneNumber;
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
  String rejectReason;
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
  String createdAt;
  String updatedAt;
  List<CertificationTypeUpload> certificationUploads;
  List<Banners> banners;
  List<Reviews> reviews;

  User(
      {this.id,
        this.userId,
        this.email,
        this.phoneNumber,
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
        this.createdAt,
        this.updatedAt,
        this.certificationUploads,
        this.banners,
        this.reviews});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['certification_uploads'] != null) {
      certificationUploads = new List<CertificationTypeUpload>();
      json['certification_uploads'].forEach((v) {
        certificationUploads.add(new CertificationTypeUpload.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = new List<Banners>();
      json['banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.certificationUploads != null) {
      data['certification_uploads'] =
          this.certificationUploads.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CertificationTypeUpload {
  int id;
  int userId;
  String acupuncturist;
  dynamic moxibutionist;
  String acupuncturistAndMoxibustion;
  String anmaMassageShiatsushi;
  dynamic judoRehabilitationTeacher;
  dynamic physicalTherapist;
  dynamic acquireNationalQualifications;
  String privateQualification1;
  String privateQualification2;
  dynamic privateQualification3;
  dynamic privateQualification4;
  dynamic privateQualification5;
  String createdAt;
  String updatedAt;

  CertificationTypeUpload(
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

  CertificationTypeUpload.fromJson(Map<String, dynamic> json) {
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

class Banners {
  int id;
  int userId;
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

class Reviews {
  int id;
  int userId;
  int therapistId;
  int ratingsId;
  bool isReviewStatus;
  int ratingsCount;
  String reviewComment;
  dynamic createdUser;
  dynamic updatedUser;
  String createdAt;
  String updatedAt;

  Reviews(
      {this.id,
        this.userId,
        this.therapistId,
        this.ratingsId,
        this.isReviewStatus,
        this.ratingsCount,
        this.reviewComment,
        this.createdUser,
        this.updatedUser,
        this.createdAt,
        this.updatedAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    therapistId = json['therapistId'];
    ratingsId = json['ratingsId'];
    isReviewStatus = json['isReviewStatus'];
    ratingsCount = json['ratingsCount'];
    reviewComment = json['reviewComment'];
    createdUser = json['createdUser'];
    updatedUser = json['updatedUser'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['therapistId'] = this.therapistId;
    data['ratingsId'] = this.ratingsId;
    data['isReviewStatus'] = this.isReviewStatus;
    data['ratingsCount'] = this.ratingsCount;
    data['reviewComment'] = this.reviewComment;
    data['createdUser'] = this.createdUser;
    data['updatedUser'] = this.updatedUser;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
