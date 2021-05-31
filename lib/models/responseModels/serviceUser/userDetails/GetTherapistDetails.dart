// To parse this JSON data, do
//
//     final therapistByIdModel = therapistByIdModelFromJson(jsonString);

import 'dart:convert';

TherapistByIdModel therapistByIdModelFromJson(String str) =>
    TherapistByIdModel.fromJson(json.decode(str));

String therapistByIdModelToJson(TherapistByIdModel data) =>
    json.encode(data.toJson());

class TherapistByIdModel {
  TherapistByIdModel({
    this.status,
    this.data,
    this.reviewData,
    this.favouriteDataResponse,
    this.therapistEstheticList,
    this.therapistFitnessListList,
    this.therapistOrteopathicList,
    this.therapistRelaxationList,
    this.storeServiceTiming,
    this.bookingDataResponse,
  });

  String status;
  Data data;
  ReviewData reviewData;
  FavouriteDataResponse favouriteDataResponse;
  List<TherapistList> therapistEstheticList;
  List<TherapistList> therapistFitnessListList;
  List<TherapistList> therapistOrteopathicList;
  List<TherapistList> therapistRelaxationList;
  List<StoreServiceTiming> storeServiceTiming;
  List<BookingDataResponse> bookingDataResponse;

  factory TherapistByIdModel.fromJson(Map<String, dynamic> json) =>
      TherapistByIdModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        reviewData: ReviewData.fromJson(json["reviewData"]),
        favouriteDataResponse:
            FavouriteDataResponse.fromJson(json["favouriteDataResponse"]),
        therapistEstheticList: List<TherapistList>.from(
            json["therapistEstheticList"]
                .map((x) => TherapistList.fromJson(x))),
        therapistFitnessListList: List<TherapistList>.from(
            json["therapistFitnessListList"]
                .map((x) => TherapistList.fromJson(x))),
        therapistOrteopathicList: List<TherapistList>.from(
            json["therapistOrteopathicList"]
                .map((x) => TherapistList.fromJson(x))),
        therapistRelaxationList: List<TherapistList>.from(
            json["therapistRelaxationList"]
                .map((x) => TherapistList.fromJson(x))),
        storeServiceTiming: List<StoreServiceTiming>.from(
            json["storeServiceTiming"]
                .map((x) => StoreServiceTiming.fromJson(x))),
        bookingDataResponse: List<BookingDataResponse>.from(
            json["bookingDataResponse"]
                .map((x) => BookingDataResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "ReviewData": reviewData.toJson(),
        "favouriteDataResponse": favouriteDataResponse.toJson(),
        "therapistEstheticList":
            List<dynamic>.from(therapistEstheticList.map((x) => x.toJson())),
        "therapistFitnessListList":
            List<dynamic>.from(therapistFitnessListList.map((x) => x.toJson())),
        "therapistOrteopathicList":
            List<dynamic>.from(therapistOrteopathicList.map((x) => x.toJson())),
        "therapistRelaxationList":
            List<dynamic>.from(therapistRelaxationList.map((x) => x.toJson())),
        "storeServiceTiming":
            List<dynamic>.from(storeServiceTiming.map((x) => x.toJson())),
        "bookingDataResponse":
            List<dynamic>.from(bookingDataResponse.map((x) => x.toJson())),
      };
}

class BookingDataResponse {
  BookingDataResponse({
    this.id,
    this.userId,
    this.therapistId,
    this.eventId,
    this.startTime,
    this.endTime,
    this.monthOfBooking,
    this.yearOfBooking,
    this.newStartTime,
    this.newEndTime,
    this.paymentId,
    this.paymentStatus,
    this.paymentRefId,
    this.subCategoryId,
    this.categoryId,
    this.nameOfService,
    this.totalMinOfService,
    this.priceOfService,
    this.addedPrice,
    this.bookingStatus,
    this.statusUpdatedAt,
    this.travelAmount,
    this.locationType,
    this.location,
    this.locationDistance,
    this.totalCost,
    this.userReviewStatus,
    this.therapistReviewStatus,
    this.therapistComments,
    this.userComments,
    this.cancellationReason,
    this.cancellationFee,
    this.cancelledUserId,
    this.orderCompletion,
    this.createdUser,
    this.updatedUser,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int therapistId;
  dynamic eventId;
  DateTime startTime;
  DateTime endTime;
  String monthOfBooking;
  String yearOfBooking;
  dynamic newStartTime;
  dynamic newEndTime;
  dynamic paymentId;
  int paymentStatus;
  dynamic paymentRefId;
  int subCategoryId;
  int categoryId;
  String nameOfService;
  int totalMinOfService;
  int priceOfService;
  dynamic addedPrice;
  int bookingStatus;
  DateTime statusUpdatedAt;
  dynamic travelAmount;
  String locationType;
  String location;
  dynamic locationDistance;
  int totalCost;
  int userReviewStatus;
  dynamic therapistReviewStatus;
  dynamic therapistComments;
  dynamic userComments;
  dynamic cancellationReason;
  dynamic cancellationFee;
  dynamic cancelledUserId;
  dynamic orderCompletion;
  String createdUser;
  String updatedUser;
  DateTime createdAt;
  DateTime updatedAt;

  factory BookingDataResponse.fromJson(Map<String, dynamic> json) =>
      BookingDataResponse(
        id: json["id"],
        userId: json["userId"],
        therapistId: json["therapistId"],
        eventId: json["eventId"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        monthOfBooking: json["monthOfBooking"],
        yearOfBooking: json["yearOfBooking"],
        newStartTime: json["newStartTime"],
        newEndTime: json["newEndTime"],
        paymentId: json["paymentId"],
        paymentStatus: json["paymentStatus"],
        paymentRefId: json["paymentRefId"],
        subCategoryId: json["subCategoryId"],
        categoryId: json["categoryId"],
        nameOfService: json["nameOfService"],
        totalMinOfService: json["totalMinOfService"],
        priceOfService: json["priceOfService"],
        addedPrice: json["addedPrice"],
        bookingStatus: json["bookingStatus"],
        statusUpdatedAt: DateTime.parse(json["statusUpdatedAt"]),
        travelAmount: json["travelAmount"],
        locationType: json["locationType"],
        location: json["location"],
        locationDistance: json["locationDistance"],
        totalCost: json["totalCost"],
        userReviewStatus: json["userReviewStatus"],
        therapistReviewStatus: json["therapistReviewStatus"],
        therapistComments: json["therapistComments"],
        userComments: json["userComments"],
        cancellationReason: json["cancellationReason"],
        cancellationFee: json["cancellationFee"],
        cancelledUserId: json["cancelledUserId"],
        orderCompletion: json["orderCompletion"],
        createdUser: json["createdUser"],
        updatedUser: json["updatedUser"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "therapistId": therapistId,
        "eventId": eventId,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "monthOfBooking": monthOfBooking,
        "yearOfBooking": yearOfBooking,
        "newStartTime": newStartTime,
        "newEndTime": newEndTime,
        "paymentId": paymentId,
        "paymentStatus": paymentStatus,
        "paymentRefId": paymentRefId,
        "subCategoryId": subCategoryId,
        "categoryId": categoryId,
        "nameOfService": nameOfService,
        "totalMinOfService": totalMinOfService,
        "priceOfService": priceOfService,
        "addedPrice": addedPrice,
        "bookingStatus": bookingStatus,
        "statusUpdatedAt": statusUpdatedAt.toIso8601String(),
        "travelAmount": travelAmount,
        "locationType": locationType,
        "location": location,
        "locationDistance": locationDistance,
        "totalCost": totalCost,
        "userReviewStatus": userReviewStatus,
        "therapistReviewStatus": therapistReviewStatus,
        "therapistComments": therapistComments,
        "userComments": userComments,
        "cancellationReason": cancellationReason,
        "cancellationFee": cancellationFee,
        "cancelledUserId": cancelledUserId,
        "orderCompletion": orderCompletion,
        "createdUser": createdUser,
        "updatedUser": updatedUser,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Data {
  Data({
    this.id,
    this.userId,
    this.guestUserStatus,
    this.email,
    this.phoneNumber,
    this.firebaseUdid,
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
  });

  int id;
  String userId;
  bool guestUserStatus;
  String email;
  int phoneNumber;
  dynamic firebaseUdid;
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
  String storeDescription;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["userId"],
        guestUserStatus: json["guestUserStatus"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        firebaseUdid: json["firebaseUDID"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "guestUserStatus": guestUserStatus,
        "email": email,
        "phoneNumber": phoneNumber,
        "firebaseUDID": firebaseUdid,
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
    this.branchCode,
    this.branchNumber,
    this.accountNumber,
    this.accountType,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String bankName;
  String branchCode;
  String branchNumber;
  String accountNumber;
  String accountType;
  DateTime createdAt;
  DateTime updatedAt;

  factory BankDetail.fromJson(Map<String, dynamic> json) => BankDetail(
        id: json["id"],
        userId: json["userId"],
        bankName: json["bankName"],
        branchCode: json["branchCode"],
        branchNumber: json["branchNumber"],
        accountNumber: json["accountNumber"],
        accountType: json["accountType"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bankName": bankName,
        "branchCode": branchCode,
        "branchNumber": branchNumber,
        "accountNumber": accountNumber,
        "accountType": accountType,
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
  String bannerImageUrl1;
  String bannerImageUrl2;
  String bannerImageUrl3;
  String bannerImageUrl4;
  String bannerImageUrl5;
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
  dynamic acupuncturist;
  String moxibutionist;
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

class FavouriteDataResponse {
  FavouriteDataResponse({
    this.favouriteToTherapist,
  });

  int favouriteToTherapist;

  factory FavouriteDataResponse.fromJson(Map<String, dynamic> json) =>
      FavouriteDataResponse(
        favouriteToTherapist: json["favouriteToTherapist"],
      );

  Map<String, dynamic> toJson() => {
        "favouriteToTherapist": favouriteToTherapist,
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

class StoreServiceTiming {
  StoreServiceTiming({
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

  factory StoreServiceTiming.fromJson(Map<String, dynamic> json) =>
      StoreServiceTiming(
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class TherapistList {
  TherapistList({
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

  factory TherapistList.fromJson(Map<String, dynamic> json) => TherapistList(
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
  String value;
  DateTime createdAt;
  DateTime updatedAt;
  int categoryId;

  factory MstMassageCategory.fromJson(Map<String, dynamic> json) =>
      MstMassageCategory(
        id: json["id"],
        value: json["value"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        categoryId: json["categoryId"] == null ? null : json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "categoryId": categoryId == null ? null : categoryId,
      };
}
