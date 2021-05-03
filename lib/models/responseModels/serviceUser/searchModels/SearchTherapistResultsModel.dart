class SearchTherapistResultsModel {
  String status;
  Data data;

  SearchTherapistResultsModel({this.status, this.data});

  SearchTherapistResultsModel.fromJson(Map<String, dynamic> json) {
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
  int totalElements;
  List<SearchList> searchList;
  int totalPages;
  int pageNumber;

  Data({this.totalElements, this.searchList, this.totalPages, this.pageNumber});

  Data.fromJson(Map<String, dynamic> json) {
    totalElements = json['totalElements'];
    if (json['searchList'] != null) {
      searchList = new List<SearchList>();
      json['searchList'].forEach((v) {
        searchList.add(new SearchList.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    pageNumber = json['pageNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalElements'] = this.totalElements;
    if (this.searchList != null) {
      data['searchList'] = this.searchList.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['pageNumber'] = this.pageNumber;
    return data;
  }
}

class SearchList {
  String ratingAvg;
  String leastPriceMin;
  int id;
  int userId;
  int categoryId;
  int subCategoryId;
  String name;
  int sixtyMin;
  int nintyMin;
  int oneTwentyMin;
  int oneFifityMin;
  int oneEightyMin;
  int lowestPrice;
  User user;

  SearchList(
      {this.ratingAvg,
        this.leastPriceMin,
        this.id,
        this.userId,
        this.categoryId,
        this.subCategoryId,
        this.name,
        this.sixtyMin,
        this.nintyMin,
        this.oneTwentyMin,
        this.oneFifityMin,
        this.oneEightyMin,
        this.lowestPrice,
        this.user});

  SearchList.fromJson(Map<String, dynamic> json) {
    ratingAvg = json['ratingAvg'];
    leastPriceMin = json['leastPriceMin'];
    id = json['id'];
    userId = json['userId'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    name = json['name'];
    sixtyMin = json['sixtyMin'];
    nintyMin = json['nintyMin'];
    oneTwentyMin = json['oneTwentyMin'];
    oneFifityMin = json['oneFifityMin'];
    oneEightyMin = json['oneEightyMin'];
    lowestPrice = json['lowestPrice'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ratingAvg'] = this.ratingAvg;
    data['leastPriceMin'] = this.leastPriceMin;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['categoryId'] = this.categoryId;
    data['subCategoryId'] = this.subCategoryId;
    data['name'] = this.name;
    data['sixtyMin'] = this.sixtyMin;
    data['nintyMin'] = this.nintyMin;
    data['oneTwentyMin'] = this.oneTwentyMin;
    data['oneFifityMin'] = this.oneFifityMin;
    data['oneEightyMin'] = this.oneEightyMin;
    data['lowestPrice'] = this.lowestPrice;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String userName;
  dynamic uploadProfileImgUrl;
  String businessForm;
  String storeType;
  int coronameasure;
  int businesstrip;
  String childrenMeasure;
  String genderOfService;
  bool isShop;
  List<Addresses> addresses;
  List<SearchTherapistCertificates> certificationUploads;

  User(
      {this.id,
        this.userName,
        this.uploadProfileImgUrl,
        this.businessForm,
        this.storeType,
        this.coronameasure,
        this.businesstrip,
        this.childrenMeasure,
        this.genderOfService,
        this.isShop,
        this.addresses,
        this.certificationUploads});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    uploadProfileImgUrl = json['uploadProfileImgUrl'];
    businessForm = json['businessForm'];
    storeType = json['storeType'];
    coronameasure = json['coronameasure'];
    businesstrip = json['businesstrip '];
    childrenMeasure = json['childrenMeasure'];
    genderOfService = json['genderOfService'];
    isShop = json['isShop'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    if (json['certification_uploads'] != null) {
      certificationUploads = new List<SearchTherapistCertificates>();
      json['certification_uploads'].forEach((v) {
        certificationUploads.add(new SearchTherapistCertificates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['uploadProfileImgUrl'] = this.uploadProfileImgUrl;
    data['businessForm'] = this.businessForm;
    data['storeType'] = this.storeType;
    data['coronameasure'] = this.coronameasure;
    data['businesstrip '] = this.businesstrip;
    data['childrenMeasure'] = this.childrenMeasure;
    data['genderOfService'] = this.genderOfService;
    data['isShop'] = this.isShop;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    if (this.certificationUploads != null) {
      data['certification_uploads'] =
          this.certificationUploads.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  int id;
  double lat;
  double lon;
  dynamic geomet;
  String address;

  Addresses({this.id, this.lat, this.lon, this.geomet, this.address});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    lon = json['lon'];
    geomet = json['geomet'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['geomet'] = this.geomet;
    data['address'] = this.address;
    return data;
  }
}

class SearchTherapistCertificates {
  int id;
  int userId;
  dynamic acupuncturist;
  dynamic moxibutionist;
  dynamic acupuncturistAndMoxibustion;
  dynamic anmaMassageShiatsushi;
  dynamic judoRehabilitationTeacher;
  dynamic physicalTherapist;
  dynamic acquireNationalQualifications;
  dynamic privateQualification1;
  dynamic privateQualification2;
  dynamic privateQualification3;
  dynamic privateQualification4;
  dynamic privateQualification5;

  SearchTherapistCertificates(
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
        this.privateQualification5});

  SearchTherapistCertificates.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
