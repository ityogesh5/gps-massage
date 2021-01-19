class RegisterProviderResponseModel {
  String status;
  Data data;

  RegisterProviderResponseModel({this.status, this.data});

  RegisterProviderResponseModel.fromJson(Map<String, dynamic> json) {
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
  UserResponse userResponse;
  AddressResponse addressResponse;
  CertificationResponse certificationResponse;
  BankResponse bankResponse;
  BannerResponse bannerResponse;
  List<EstheticListResponse> estheticListResponse;
  List<FitnessListResponse> fitnessListResponse;
  List<OrteopathicListResponse> orteopathicListResponse;
  List<RelaxationListResponse> relaxationListResponse;

  Data(
      {this.userResponse,
      this.addressResponse,
      this.certificationResponse,
      this.bankResponse,
      this.bannerResponse,
      this.estheticListResponse,
      this.fitnessListResponse,
      this.orteopathicListResponse,
      this.relaxationListResponse});

  Data.fromJson(Map<String, dynamic> json) {
    userResponse = json['userResponse'] != null
        ? new UserResponse.fromJson(json['userResponse'])
        : null;
    addressResponse = json['addressResponse'] != null
        ? new AddressResponse.fromJson(json['addressResponse'])
        : null;
    certificationResponse = json['certificationResponse'] != null
        ? new CertificationResponse.fromJson(json['certificationResponse'])
        : null;
    bankResponse = json['bankResponse'] != null
        ? new BankResponse.fromJson(json['bankResponse'])
        : null;
    bannerResponse = json['bannerResponse'] != null
        ? new BannerResponse.fromJson(json['bannerResponse'])
        : null;
    if (json['estheticListResponse'] != null) {
      estheticListResponse = new List<EstheticListResponse>();
      json['estheticListResponse'].forEach((v) {
        estheticListResponse.add(new EstheticListResponse.fromJson(v));
      });
    }
    if (json['fitnessListResponse'] != null) {
      fitnessListResponse = new List<FitnessListResponse>();
      json['fitnessListResponse'].forEach((v) {
        fitnessListResponse.add(new FitnessListResponse.fromJson(v));
      });
    }
    if (json['orteopathicListResponse'] != null) {
      orteopathicListResponse = new List<OrteopathicListResponse>();
      json['orteopathicListResponse'].forEach((v) {
        orteopathicListResponse.add(new OrteopathicListResponse.fromJson(v));
      });
    }
    if (json['relaxationListResponse'] != null) {
      relaxationListResponse = new List<RelaxationListResponse>();
      json['relaxationListResponse'].forEach((v) {
        relaxationListResponse.add(new RelaxationListResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userResponse != null) {
      data['userResponse'] = this.userResponse.toJson();
    }
    if (this.addressResponse != null) {
      data['addressResponse'] = this.addressResponse.toJson();
    }
    if (this.certificationResponse != null) {
      data['certificationResponse'] = this.certificationResponse.toJson();
    }
    if (this.bankResponse != null) {
      data['bankResponse'] = this.bankResponse.toJson();
    }
    if (this.bannerResponse != null) {
      data['bannerResponse'] = this.bannerResponse.toJson();
    }
    if (this.estheticListResponse != null) {
      data['estheticListResponse'] =
          this.estheticListResponse.map((v) => v.toJson()).toList();
    }
    if (this.fitnessListResponse != null) {
      data['fitnessListResponse'] =
          this.fitnessListResponse.map((v) => v.toJson()).toList();
    }
    if (this.orteopathicListResponse != null) {
      data['orteopathicListResponse'] =
          this.orteopathicListResponse.map((v) => v.toJson()).toList();
    }
    if (this.relaxationListResponse != null) {
      data['relaxationListResponse'] =
          this.relaxationListResponse.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserResponse {
  bool isVerified;
  int id;
  String email;
  String phoneNumber;
  String userName;
  String gender;
  String dob;
  String age;
  String storeName;
  String storePhone;
  String isTherapist;
  String numberOfEmp;
  String businessTrip;
  String coronaMeasure;
  String childrenMeasure;
  String businessForm;
  String proofOfIdentityType;
  String proofOfIdentityImgUrl;
  bool isActive;
  String uploadProfileImgUrl;
  String userId;
  String updatedAt;
  String createdAt;

  UserResponse(
      {this.isVerified,
      this.id,
      this.email,
      this.phoneNumber,
      this.userName,
      this.gender,
      this.dob,
      this.age,
      this.storeName,
      this.storePhone,
      this.isTherapist,
      this.numberOfEmp,
      this.businessTrip,
      this.coronaMeasure,
      this.childrenMeasure,
      this.businessForm,
      this.proofOfIdentityType,
      this.proofOfIdentityImgUrl,
      this.isActive,
      this.uploadProfileImgUrl,
      this.userId,
      this.updatedAt,
      this.createdAt});

  UserResponse.fromJson(Map<String, dynamic> json) {
    isVerified = json['isVerified'];
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    userName = json['userName'];
    gender = json['gender'];
    dob = json['dob'];
    age = json['age'];
    storeName = json['storeName'];
    storePhone = json['storePhone'];
    isTherapist = json['isTherapist'];
    numberOfEmp = json['numberOfEmp'];
    businessTrip = json['businessTrip'];
    coronaMeasure = json['coronaMeasure'];
    childrenMeasure = json['childrenMeasure'];
    businessForm = json['businessForm'];
    proofOfIdentityType = json['proofOfIdentityType'];
    proofOfIdentityImgUrl = json['proofOfIdentityImgUrl'];
    isActive = json['isActive'];
    uploadProfileImgUrl = json['uploadProfileImgUrl'];
    userId = json['userId'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isVerified'] = this.isVerified;
    data['id'] = this.id;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['userName'] = this.userName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['storeName'] = this.storeName;
    data['storePhone'] = this.storePhone;
    data['isTherapist'] = this.isTherapist;
    data['numberOfEmp'] = this.numberOfEmp;
    data['businessTrip'] = this.businessTrip;
    data['coronaMeasure'] = this.coronaMeasure;
    data['childrenMeasure'] = this.childrenMeasure;
    data['businessForm'] = this.businessForm;
    data['proofOfIdentityType'] = this.proofOfIdentityType;
    data['proofOfIdentityImgUrl'] = this.proofOfIdentityImgUrl;
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
  String address;
  String area;
  String lat;
  String lon;
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
    data['userId'] = this.userId;
    data['createdUser'] = this.createdUser;
    data['updatedUser'] = this.updatedUser;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class CertificationResponse {
  int id;
  String moxibutionist;
  int userId;
  String updatedAt;
  String createdAt;

  CertificationResponse(
      {this.id,
      this.moxibutionist,
      this.userId,
      this.updatedAt,
      this.createdAt});

  CertificationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moxibutionist = json['moxibutionist'];
    userId = json['userId'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['moxibutionist'] = this.moxibutionist;
    data['userId'] = this.userId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class BankResponse {
  int id;
  String bankName;
  String branchCode;
  String branchNumber;
  String accountNumber;
  String accountType;
  int userId;
  String updatedAt;
  String createdAt;

  BankResponse(
      {this.id,
      this.bankName,
      this.branchCode,
      this.branchNumber,
      this.accountNumber,
      this.accountType,
      this.userId,
      this.updatedAt,
      this.createdAt});

  BankResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankName = json['bankName'];
    branchCode = json['branchCode'];
    branchNumber = json['branchNumber'];
    accountNumber = json['accountNumber'];
    accountType = json['accountType'];
    userId = json['userId'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bankName'] = this.bankName;
    data['branchCode'] = this.branchCode;
    data['branchNumber'] = this.branchNumber;
    data['accountNumber'] = this.accountNumber;
    data['accountType'] = this.accountType;
    data['userId'] = this.userId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class BannerResponse {
  int id;
  String bannerImageUrl1;
  String bannerImageUrl2;
  String bannerImageUrl3;
  String bannerImageUrl4;
  String bannerImageUrl5;
  int userId;
  String updatedAt;
  String createdAt;

  BannerResponse(
      {this.id,
      this.bannerImageUrl1,
      this.bannerImageUrl2,
      this.bannerImageUrl3,
      this.bannerImageUrl4,
      this.bannerImageUrl5,
      this.userId,
      this.updatedAt,
      this.createdAt});

  BannerResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImageUrl1 = json['bannerImageUrl1'];
    bannerImageUrl2 = json['bannerImageUrl2'];
    bannerImageUrl3 = json['bannerImageUrl3'];
    bannerImageUrl4 = json['bannerImageUrl4'];
    bannerImageUrl5 = json['bannerImageUrl5'];
    userId = json['userId'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bannerImageUrl1'] = this.bannerImageUrl1;
    data['bannerImageUrl2'] = this.bannerImageUrl2;
    data['bannerImageUrl3'] = this.bannerImageUrl3;
    data['bannerImageUrl4'] = this.bannerImageUrl4;
    data['bannerImageUrl5'] = this.bannerImageUrl5;
    data['userId'] = this.userId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class EstheticListResponse {
  int id;
  String name;
  int sixtyMin;
  int nintyMin;
  int oneTwentyMin;
  int oneFifityMin;
  int oneEightyMin;
  int estheticId;
  int userId;
  String createdAt;
  String updatedAt;

  EstheticListResponse(
      {this.id,
      this.name,
      this.sixtyMin,
      this.nintyMin,
      this.oneTwentyMin,
      this.oneFifityMin,
      this.oneEightyMin,
      this.estheticId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  EstheticListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sixtyMin = json['sixtyMin'];
    nintyMin = json['nintyMin'];
    oneTwentyMin = json['oneTwentyMin'];
    oneFifityMin = json['oneFifityMin'];
    oneEightyMin = json['oneEightyMin'];
    estheticId = json['estheticId'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sixtyMin'] = this.sixtyMin;
    data['nintyMin'] = this.nintyMin;
    data['oneTwentyMin'] = this.oneTwentyMin;
    data['oneFifityMin'] = this.oneFifityMin;
    data['oneEightyMin'] = this.oneEightyMin;
    data['estheticId'] = this.estheticId;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class FitnessListResponse {
  int id;
  String name;
  int sixtyMin;
  int nintyMin;
  int oneTwentyMin;
  int oneFifityMin;
  int oneEightyMin;
  int fitnessId;
  int userId;
  String createdAt;
  String updatedAt;

  FitnessListResponse(
      {this.id,
      this.name,
      this.sixtyMin,
      this.nintyMin,
      this.oneTwentyMin,
      this.oneFifityMin,
      this.oneEightyMin,
      this.fitnessId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  FitnessListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sixtyMin = json['sixtyMin'];
    nintyMin = json['nintyMin'];
    oneTwentyMin = json['oneTwentyMin'];
    oneFifityMin = json['oneFifityMin'];
    oneEightyMin = json['oneEightyMin'];
    fitnessId = json['fitnessId'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sixtyMin'] = this.sixtyMin;
    data['nintyMin'] = this.nintyMin;
    data['oneTwentyMin'] = this.oneTwentyMin;
    data['oneFifityMin'] = this.oneFifityMin;
    data['oneEightyMin'] = this.oneEightyMin;
    data['fitnessId'] = this.fitnessId;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class OrteopathicListResponse {
  int id;
  String name;
  int sixtyMin;
  int nintyMin;
  int oneTwentyMin;
  int oneFifityMin;
  int oneEightyMin;
  int orteopathicId;
  int userId;
  String createdAt;
  String updatedAt;

  OrteopathicListResponse(
      {this.id,
      this.name,
      this.sixtyMin,
      this.nintyMin,
      this.oneTwentyMin,
      this.oneFifityMin,
      this.oneEightyMin,
      this.orteopathicId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  OrteopathicListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sixtyMin = json['sixtyMin'];
    nintyMin = json['nintyMin'];
    oneTwentyMin = json['oneTwentyMin'];
    oneFifityMin = json['oneFifityMin'];
    oneEightyMin = json['oneEightyMin'];
    orteopathicId = json['orteopathicId'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sixtyMin'] = this.sixtyMin;
    data['nintyMin'] = this.nintyMin;
    data['oneTwentyMin'] = this.oneTwentyMin;
    data['oneFifityMin'] = this.oneFifityMin;
    data['oneEightyMin'] = this.oneEightyMin;
    data['orteopathicId'] = this.orteopathicId;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class RelaxationListResponse {
  int id;
  String name;
  int sixtyMin;
  int nintyMin;
  int oneTwentyMin;
  int oneFifityMin;
  int oneEightyMin;
  int relaxationId;
  int userId;
  String createdAt;
  String updatedAt;

  RelaxationListResponse(
      {this.id,
      this.name,
      this.sixtyMin,
      this.nintyMin,
      this.oneTwentyMin,
      this.oneFifityMin,
      this.oneEightyMin,
      this.relaxationId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  RelaxationListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sixtyMin = json['sixtyMin'];
    nintyMin = json['nintyMin'];
    oneTwentyMin = json['oneTwentyMin'];
    oneFifityMin = json['oneFifityMin'];
    oneEightyMin = json['oneEightyMin'];
    relaxationId = json['relaxationId'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sixtyMin'] = this.sixtyMin;
    data['nintyMin'] = this.nintyMin;
    data['oneTwentyMin'] = this.oneTwentyMin;
    data['oneFifityMin'] = this.oneFifityMin;
    data['oneEightyMin'] = this.oneEightyMin;
    data['relaxationId'] = this.relaxationId;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
