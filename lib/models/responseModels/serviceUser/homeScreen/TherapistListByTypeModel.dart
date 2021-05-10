class TherapistsByTypeModel {
  String status;
  HomeTherapistData homeTherapistData;

  TherapistsByTypeModel({this.status, this.homeTherapistData});

  TherapistsByTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    homeTherapistData = json['homeTherapistData'] != null
        ? new HomeTherapistData.fromJson(json['homeTherapistData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.homeTherapistData != null) {
      data['homeTherapistData'] = this.homeTherapistData.toJson();
    }
    return data;
  }
}

class HomeTherapistData {
  int count;
  List<TypeTherapistData> typeTherapistData;

  HomeTherapistData({this.count, this.typeTherapistData});

  HomeTherapistData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      typeTherapistData = new List<TypeTherapistData>();
      json['rows'].forEach((v) {
        typeTherapistData.add(new TypeTherapistData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.typeTherapistData != null) {
      data['rows'] = this.typeTherapistData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TypeTherapistData {
  int id;
  int userId;
  int categoryId;
  int subCategoryId;
  String name;
  User user;
  String reviewAvgData;
  int noOfReviewsMembers;
  int lowestPrice;
  String priceForMinute;

  TypeTherapistData(
      {this.id,
        this.userId,
        this.categoryId,
        this.subCategoryId,
        this.name,
        this.user,
        this.reviewAvgData,
        this.noOfReviewsMembers,
        this.lowestPrice,
        this.priceForMinute});

  TypeTherapistData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    name = json['name'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    reviewAvgData = json['reviewAvgData'];
    noOfReviewsMembers = json['NoOfReviewsMembers'];
    lowestPrice = json['lowestPrice'];
    priceForMinute = json['priceForMinute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    data['subCategoryId'] = this.subCategoryId;
    data['name'] = this.name;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['reviewAvgData'] = this.reviewAvgData;
    data['NoOfReviewsMembers'] = this.noOfReviewsMembers;
    data['lowestPrice'] = this.lowestPrice;
    data['priceForMinute'] = this.priceForMinute;
    return data;
  }
}

class User {
  int id;
  String userId;
  String userName;
  String uploadProfileImgUrl;
  String storeName;
  String storeType;
  String qulaificationCertImgUrl;
  String businessForm;
  String childrenMeasure;
  bool coronaMeasure;
  bool businessTrip;
  List<TherapistTypeAddress> addresses;
  List<CertificationUploadsByType> certificationUploads;
  List<Banners> banners;

  User(
      {this.id,
        this.userId,
        this.userName,
        this.uploadProfileImgUrl,
        this.storeName,
        this.storeType,
        this.qulaificationCertImgUrl,
        this.businessForm,
        this.childrenMeasure,
        this.coronaMeasure,
        this.businessTrip,
        this.addresses,
        this.certificationUploads,
        this.banners});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userName = json['userName'];
    uploadProfileImgUrl = json['uploadProfileImgUrl'];
    storeName = json['storeName'];
    storeType = json['storeType'];
    qulaificationCertImgUrl = json['qulaificationCertImgUrl'];
    businessForm = json['businessForm'];
    childrenMeasure = json['childrenMeasure'];
    coronaMeasure = json['coronaMeasure'];
    businessTrip = json['businessTrip'];
    if (json['addresses'] != null) {
      addresses = new List<TherapistTypeAddress>();
      json['addresses'].forEach((v) {
        addresses.add(new TherapistTypeAddress.fromJson(v));
      });
    }
    if (json['certification_uploads'] != null) {
      certificationUploads = new List<CertificationUploadsByType>();
      json['certification_uploads'].forEach((v) {
        certificationUploads.add(new CertificationUploadsByType.fromJson(v));
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
    data['userName'] = this.userName;
    data['uploadProfileImgUrl'] = this.uploadProfileImgUrl;
    data['storeName'] = this.storeName;
    data['storeType'] = this.storeType;
    data['qulaificationCertImgUrl'] = this.qulaificationCertImgUrl;
    data['businessForm'] = this.businessForm;
    data['childrenMeasure'] = this.childrenMeasure;
    data['coronaMeasure'] = this.coronaMeasure;
    data['businessTrip'] = this.businessTrip;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    if (this.certificationUploads != null) {
      data['certification_uploads'] =
          this.certificationUploads.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TherapistTypeAddress {
  int id;
  double lat;
  double lon;
  Geomet geomet;
  String address;
  double distance;

  TherapistTypeAddress(
      {this.id, this.lat, this.lon, this.geomet, this.address, this.distance});

  TherapistTypeAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    lon = json['lon'];
    geomet =
    json['geomet'] != null ? new Geomet.fromJson(json['geomet']) : null;
    address = json['address'];
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
    data['distance'] = this.distance;
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

class CertificationUploadsByType {
  int id;
  int userId;
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

  CertificationUploadsByType(
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

  CertificationUploadsByType.fromJson(Map<String, dynamic> json) {
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
  Null bannerImageUrl2;
  String bannerImageUrl3;
  Null bannerImageUrl4;
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
