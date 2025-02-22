// To parse this JSON data, do
//
//     final providerDetailsResponseModel = providerDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

ProviderDetailsResponseModel providerDetailsResponseModelFromJson(String str) =>
    ProviderDetailsResponseModel.fromJson(json.decode(str));

String providerDetailsResponseModelToJson(ProviderDetailsResponseModel data) =>
    json.encode(data.toJson());

class ProviderDetailsResponseModel {
  ProviderDetailsResponseModel({
    this.status,
    this.data,
    this.reviewData,
    this.therapistEstheticList,
    this.therapistFitnessListList,
    this.therapistOrteopathicList,
    this.therapistRelaxationList,
    this.therapistProfit,
  });

  String status;
  Data data;
  ReviewData reviewData;
  List<TherapistEstheticList> therapistEstheticList;
  List<dynamic> therapistFitnessListList;
  List<dynamic> therapistOrteopathicList;
  List<dynamic> therapistRelaxationList;
  TherapistProfit therapistProfit;

  factory ProviderDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      ProviderDetailsResponseModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        reviewData: ReviewData.fromJson(json["reviewData"]),
        therapistEstheticList: List<TherapistEstheticList>.from(
            json["therapistEstheticList"]
                .map((x) => TherapistEstheticList.fromJson(x))),
        therapistFitnessListList:
            List<dynamic>.from(json["therapistFitnessListList"].map((x) => x)),
        therapistOrteopathicList:
            List<dynamic>.from(json["therapistOrteopathicList"].map((x) => x)),
        therapistRelaxationList:
            List<dynamic>.from(json["therapistRelaxationList"].map((x) => x)),
        therapistProfit: TherapistProfit.fromJson(json["therapistProfit"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "ReviewData": reviewData.toJson(),
        "therapistEstheticList":
            List<dynamic>.from(therapistEstheticList.map((x) => x.toJson())),
        "therapistFitnessListList":
            List<dynamic>.from(therapistFitnessListList.map((x) => x)),
        "therapistOrteopathicList":
            List<dynamic>.from(therapistOrteopathicList.map((x) => x)),
        "therapistRelaxationList":
            List<dynamic>.from(therapistRelaxationList.map((x) => x)),
        "therapistProfit": therapistProfit.toJson(),
      };
}

class Data {
  Data({
    this.id,
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
    this.userSearchRadiusDistance,
    this.isShop,
    this.createdAt,
    this.updatedAt,
    this.addresses,
    this.certificationUploads,
    this.bankDetails,
    this.banners,
    this.storeServiceTimes,
  });

  int id;
  String userId;
  String email;
  int phoneNumber;
  dynamic fcmToken;
  dynamic lineBotUserId;
  dynamic appleUserId;
  String userName;
  DateTime dob;
  int age;
  String gender;
  bool isTherapist;
  bool isVerified;
  bool isActive;
  int isAccepted;
  dynamic rejectReason;
  dynamic updatedUser;
  dynamic uploadProfileImgUrl;
  String proofOfIdentityType;
  dynamic proofOfIdentityImgUrl;
  dynamic qulaificationCertImgUrl;
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
  dynamic userSearchRadiusDistance;
  bool isShop;
  DateTime createdAt;
  DateTime updatedAt;
  List<Address> addresses;
  List<CertificationUpload> certificationUploads;
  List<BankDetail> bankDetails;
  List<Banner> banners;
  List<StoreServiceTime> storeServiceTimes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["userId"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        fcmToken: json["fcmToken"],
        lineBotUserId: json["lineBotUserId"],
        appleUserId: json["appleUserId"],
        userName: json["userName"],
        dob: DateTime.parse(json["dob"]),
        age: json["age"],
        gender: json["gender"],
        isTherapist: json["isTherapist"],
        isVerified: json["isVerified"],
        isActive: json["isActive"],
        isAccepted: json["isAccepted"],
        rejectReason: json["rejectReason"],
        updatedUser: json["updatedUser"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
        proofOfIdentityType: json["proofOfIdentityType"],
        proofOfIdentityImgUrl: json["proofOfIdentityImgUrl"],
        qulaificationCertImgUrl: json["qulaificationCertImgUrl"],
        businessForm: json["businessForm"],
        numberOfEmp: json["numberOfEmp"],
        businessTrip: json["businessTrip"],
        coronaMeasure: json["coronaMeasure"],
        storeName: json["storeName"],
        storeType: json["storeType"],
        storePhone: json["storePhone"],
        storeDescription: json["storeDescription"],
        userOccupation: json["userOccupation"],
        genderOfService: json["genderOfService"],
        childrenMeasure: json["childrenMeasure"],
        customerId: json["customerId"],
        userSearchRadiusDistance: json["userSearchRadiusDistance"],
        isShop: json["isShop"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
        certificationUploads: List<CertificationUpload>.from(
            json["certification_uploads"]
                .map((x) => CertificationUpload.fromJson(x))),
        bankDetails: List<BankDetail>.from(
            json["bankDetails"].map((x) => BankDetail.fromJson(x))),
        banners:
            List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
        storeServiceTimes: List<StoreServiceTime>.from(
            json["storeServiceTimes"].map((x) => StoreServiceTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "email": email,
        "phoneNumber": phoneNumber,
        "fcmToken": fcmToken,
        "lineBotUserId": lineBotUserId,
        "appleUserId": appleUserId,
        "userName": userName,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "age": age,
        "gender": gender,
        "isTherapist": isTherapist,
        "isVerified": isVerified,
        "isActive": isActive,
        "isAccepted": isAccepted,
        "rejectReason": rejectReason,
        "updatedUser": updatedUser,
        "uploadProfileImgUrl": uploadProfileImgUrl,
        "proofOfIdentityType": proofOfIdentityType,
        "proofOfIdentityImgUrl": proofOfIdentityImgUrl,
        "qulaificationCertImgUrl": qulaificationCertImgUrl,
        "businessForm": businessForm,
        "numberOfEmp": numberOfEmp,
        "businessTrip": businessTrip,
        "coronaMeasure": coronaMeasure,
        "storeName": storeName,
        "storeType": storeType,
        "storePhone": storePhone,
        "storeDescription": storeDescription,
        "userOccupation": userOccupation,
        "genderOfService": genderOfService,
        "childrenMeasure": childrenMeasure,
        "customerId": customerId,
        "userSearchRadiusDistance": userSearchRadiusDistance,
        "isShop": isShop,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "certification_uploads":
            List<dynamic>.from(certificationUploads.map((x) => x.toJson())),
        "bankDetails": List<dynamic>.from(bankDetails.map((x) => x.toJson())),
        "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
        "storeServiceTimes":
            List<dynamic>.from(storeServiceTimes.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.id,
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
    this.updatedAt,
  });

  int id;
  int userId;
  String addressTypeSelection;
  String address;
  String userRoomNumber;
  String userPlaceForMassage;
  dynamic otherAddressType;
  String capitalAndPrefecture;
  dynamic capitalAndPrefectureId;
  String cityName;
  dynamic citiesId;
  String area;
  String buildingName;
  dynamic postalCode;
  Geomet geomet;
  double lat;
  double lon;
  String createdUser;
  String updatedUser;
  bool isDefault;
  DateTime createdAt;
  DateTime updatedAt;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["userId"],
        addressTypeSelection: json["addressTypeSelection"],
        address: json["address"],
        userRoomNumber: json["userRoomNumber"],
        userPlaceForMassage: json["userPlaceForMassage"],
        otherAddressType: json["otherAddressType"],
        capitalAndPrefecture: json["capitalAndPrefecture"],
        capitalAndPrefectureId: json["capitalAndPrefectureId"],
        cityName: json["cityName"],
        citiesId: json["citiesId"],
        area: json["area"],
        buildingName: json["buildingName"],
        postalCode: json["postalCode"],
        geomet: Geomet.fromJson(json["geomet"]),
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        createdUser: json["createdUser"],
        updatedUser: json["updatedUser"],
        isDefault: json["isDefault"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "addressTypeSelection": addressTypeSelection,
        "address": address,
        "userRoomNumber": userRoomNumber,
        "userPlaceForMassage": userPlaceForMassage,
        "otherAddressType": otherAddressType,
        "capitalAndPrefecture": capitalAndPrefecture,
        "capitalAndPrefectureId": capitalAndPrefectureId,
        "cityName": cityName,
        "citiesId": citiesId,
        "area": area,
        "buildingName": buildingName,
        "postalCode": postalCode,
        "geomet": geomet.toJson(),
        "lat": lat,
        "lon": lon,
        "createdUser": createdUser,
        "updatedUser": updatedUser,
        "isDefault": isDefault,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Geomet {
  Geomet({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geomet.fromJson(Map<String, dynamic> json) => Geomet(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class BankDetail {
  BankDetail({
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

  factory BankDetail.fromJson(Map<String, dynamic> json) => BankDetail(
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

class Banner {
  Banner({
    this.id,
    this.userId,
    this.bannerImageUrl1,
    this.bannerImageUrl2,
    this.bannerImageUrl3,
    this.bannerImageUrl4,
    this.bannerImageUrl5,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  dynamic bannerImageUrl1;
  dynamic bannerImageUrl2;
  dynamic bannerImageUrl3;
  dynamic bannerImageUrl4;
  dynamic bannerImageUrl5;
  DateTime createdAt;
  DateTime updatedAt;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["id"],
        userId: json["userId"],
        bannerImageUrl1: json["bannerImageUrl1"],
        bannerImageUrl2: json["bannerImageUrl2"],
        bannerImageUrl3: json["bannerImageUrl3"],
        bannerImageUrl4: json["bannerImageUrl4"],
        bannerImageUrl5: json["bannerImageUrl5"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bannerImageUrl1": bannerImageUrl1,
        "bannerImageUrl2": bannerImageUrl2,
        "bannerImageUrl3": bannerImageUrl3,
        "bannerImageUrl4": bannerImageUrl4,
        "bannerImageUrl5": bannerImageUrl5,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class CertificationUpload {
  CertificationUpload({
    this.id,
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
    this.updatedAt,
  });

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
  DateTime createdAt;
  DateTime updatedAt;

  factory CertificationUpload.fromJson(Map<String, dynamic> json) =>
      CertificationUpload(
        id: json["id"],
        userId: json["userId"],
        acupuncturist: json["acupuncturist"],
        moxibutionist: json["moxibutionist"],
        acupuncturistAndMoxibustion: json["acupuncturistAndMoxibustion"],
        anmaMassageShiatsushi: json["anmaMassageShiatsushi"],
        judoRehabilitationTeacher: json["judoRehabilitationTeacher"],
        physicalTherapist: json["physicalTherapist"],
        acquireNationalQualifications: json["acquireNationalQualifications"],
        privateQualification1: json["privateQualification1"],
        privateQualification2: json["privateQualification2"],
        privateQualification3: json["privateQualification3"],
        privateQualification4: json["privateQualification4"],
        privateQualification5: json["privateQualification5"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "acupuncturist": acupuncturist,
        "moxibutionist": moxibutionist,
        "acupuncturistAndMoxibustion": acupuncturistAndMoxibustion,
        "anmaMassageShiatsushi": anmaMassageShiatsushi,
        "judoRehabilitationTeacher": judoRehabilitationTeacher,
        "physicalTherapist": physicalTherapist,
        "acquireNationalQualifications": acquireNationalQualifications,
        "privateQualification1": privateQualification1,
        "privateQualification2": privateQualification2,
        "privateQualification3": privateQualification3,
        "privateQualification4": privateQualification4,
        "privateQualification5": privateQualification5,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class StoreServiceTime {
  StoreServiceTime({
    this.id,
    this.userId,
    this.weekDay,
    this.dayInNumber,
    this.startTime,
    this.endTime,
    this.shopOpen,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String weekDay;
  int dayInNumber;
  DateTime startTime;
  DateTime endTime;
  bool shopOpen;
  DateTime createdAt;
  DateTime updatedAt;

  factory StoreServiceTime.fromJson(Map<String, dynamic> json) =>
      StoreServiceTime(
        id: json["id"],
        userId: json["userId"],
        weekDay: json["weekDay"],
        dayInNumber: json["dayInNumber"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        shopOpen: json["shopOpen"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "weekDay": weekDay,
        "dayInNumber": dayInNumber,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "shopOpen": shopOpen,
        "createdAt": createdAt == null ? "" : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? "" : updatedAt.toIso8601String(),
      };
}

class ReviewData {
  ReviewData({
    this.ratingAvg,
    this.noOfReviewsMembers,
  });

  String ratingAvg;
  int noOfReviewsMembers;

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        ratingAvg: json["ratingAvg"],
        noOfReviewsMembers: json["NoOfReviewsMembers"],
      );

  Map<String, dynamic> toJson() => {
        "ratingAvg": ratingAvg,
        "NoOfReviewsMembers": noOfReviewsMembers,
      };
}

class TherapistEstheticList {
  TherapistEstheticList({
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
    this.createdAt,
    this.updatedAt,
    this.mstMassageCategory,
    this.mstMassageSubCategory,
  });

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
  DateTime createdAt;
  DateTime updatedAt;
  MstMassageCategory mstMassageCategory;
  MstMassageCategory mstMassageSubCategory;

  factory TherapistEstheticList.fromJson(Map<String, dynamic> json) =>
      TherapistEstheticList(
        id: json["id"],
        userId: json["userId"],
        categoryId: json["categoryId"],
        subCategoryId: json["subCategoryId"],
        name: json["name"],
        sixtyMin: json["sixtyMin"],
        nintyMin: json["nintyMin"],
        oneTwentyMin: json["oneTwentyMin"],
        oneFifityMin: json["oneFifityMin"],
        oneEightyMin: json["oneEightyMin"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        mstMassageCategory:
            MstMassageCategory.fromJson(json["mstMassageCategory"]),
        mstMassageSubCategory:
            MstMassageCategory.fromJson(json["mstMassageSubCategory"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "name": name,
        "sixtyMin": sixtyMin,
        "nintyMin": nintyMin,
        "oneTwentyMin": oneTwentyMin,
        "oneFifityMin": oneFifityMin,
        "oneEightyMin": oneEightyMin,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "mstMassageCategory": mstMassageCategory.toJson(),
        "mstMassageSubCategory": mstMassageSubCategory.toJson(),
      };
}

class MstMassageCategory {
  MstMassageCategory({
    this.id,
    this.value,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
  });

  int id;
  Value value;
  DateTime createdAt;
  DateTime updatedAt;
  int categoryId;

  factory MstMassageCategory.fromJson(Map<String, dynamic> json) =>
      MstMassageCategory(
        id: json["id"],
        value: valueValues.map[json["value"]],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        categoryId: json["categoryId"] == null ? null : json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": valueValues.reverse[value],
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "categoryId": categoryId == null ? null : categoryId,
      };
}

enum Value { EMPTY, VALUE, PURPLE }

final valueValues = EnumValues(
    {"エステ": Value.EMPTY, "太もも・ヒップ": Value.PURPLE, "ブライダル": Value.VALUE});

class TherapistProfit {
  TherapistProfit({
    this.weeklyProfit,
    this.monthlyProfit,
    this.yearlyProfit,
  });

  int weeklyProfit;
  int monthlyProfit;
  int yearlyProfit;

  factory TherapistProfit.fromJson(Map<String, dynamic> json) =>
      TherapistProfit(
        weeklyProfit: json["weeklyProfit"],
        monthlyProfit: json["monthlyProfit"],
        yearlyProfit: json["yearlyProfit"],
      );

  Map<String, dynamic> toJson() => {
        "weeklyProfit": weeklyProfit,
        "monthlyProfit": monthlyProfit,
        "yearlyProfit": yearlyProfit,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
