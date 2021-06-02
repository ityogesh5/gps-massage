// To parse this JSON data, do
//
//     final bookingStatusModel = bookingStatusModelFromJson(jsonString);

import 'dart:convert';

BookingStatusModel bookingStatusModelFromJson(String str) =>
    BookingStatusModel.fromJson(json.decode(str));

String bookingStatusModelToJson(BookingStatusModel data) =>
    json.encode(data.toJson());

class BookingStatusModel {
  BookingStatusModel({
    this.status,
    this.bookingDetailsList,
  });

  String status;
  List<BookingDetailsList> bookingDetailsList;

  factory BookingStatusModel.fromJson(Map<String, dynamic> json) =>
      BookingStatusModel(
        status: json["status"],
        bookingDetailsList: List<BookingDetailsList>.from(
            json["bookingDetailsList"]
                .map((x) => BookingDetailsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "bookingDetailsList":
            List<dynamic>.from(bookingDetailsList.map((x) => x.toJson())),
      };
}

class BookingDetailsList {
  BookingDetailsList({
    this.id,
    this.userId,
    this.therapistId,
    this.addressId,
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
    this.lat,
    this.lon,
    this.geomet,
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
    this.bookingTherapistId,
    this.reviewAvgData,
    this.noOfReviewsMembers,
    this.favouriteToTherapist,
  });

  int id;
  int userId;
  int therapistId;
  int addressId;
  String eventId;
  DateTime startTime;
  DateTime endTime;
  String monthOfBooking;
  String yearOfBooking;
  DateTime newStartTime;
  DateTime newEndTime;
  int paymentId;
  int paymentStatus;
  dynamic paymentRefId;
  int subCategoryId;
  int categoryId;
  String nameOfService;
  int totalMinOfService;
  int priceOfService;
  String addedPrice;
  int bookingStatus;
  DateTime statusUpdatedAt;
  int travelAmount;
  String locationType;
  String location;
  dynamic locationDistance;
  int lat;
  int lon;
  Geomet geomet;
  int totalCost;
  int userReviewStatus;
  dynamic therapistReviewStatus;
  String therapistComments;
  dynamic userComments;
  String cancellationReason;
  dynamic cancellationFee;
  dynamic cancelledUserId;
  dynamic orderCompletion;
  String createdUser;
  String updatedUser;
  DateTime createdAt;
  DateTime updatedAt;
  BookingTherapistId bookingTherapistId;
  String reviewAvgData;
  int noOfReviewsMembers;
  int favouriteToTherapist;

  factory BookingDetailsList.fromJson(Map<String, dynamic> json) =>
      BookingDetailsList(
        id: json["id"],
        userId: json["userId"],
        therapistId: json["therapistId"],
        addressId: json["addressId"] == null ? null : json["addressId"],
        eventId: json["eventId"] == null ? null : json["eventId"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        monthOfBooking: json["monthOfBooking"],
        yearOfBooking: json["yearOfBooking"],
        newStartTime: json["newStartTime"] == null
            ? null
            : DateTime.parse(json["newStartTime"]),
        newEndTime: json["newEndTime"] == null
            ? null
            : DateTime.parse(json["newEndTime"]),
        paymentId: json["paymentId"] == null ? null : json["paymentId"],
        paymentStatus: json["paymentStatus"],
        paymentRefId: json["paymentRefId"],
        subCategoryId: json["subCategoryId"],
        categoryId: json["categoryId"],
        nameOfService: json["nameOfService"],
        totalMinOfService: json["totalMinOfService"],
        priceOfService: json["priceOfService"],
        addedPrice: json["addedPrice"] == null ? null : json["addedPrice"],
        bookingStatus: json["bookingStatus"],
        statusUpdatedAt: DateTime.parse(json["statusUpdatedAt"]),
        travelAmount:
            json["travelAmount"] == null ? null : json["travelAmount"],
        locationType:
            json["locationType"] == null ? null : json["locationType"],
        location: json["location"],
        locationDistance: json["locationDistance"],
        lat: json["lat"] == null ? null : json["lat"],
        lon: json["lon"] == null ? null : json["lon"],
        geomet: json["geomet"] == null ? null : Geomet.fromJson(json["geomet"]),
        totalCost: json["totalCost"],
        userReviewStatus: json["userReviewStatus"],
        therapistReviewStatus: json["therapistReviewStatus"],
        therapistComments: json["therapistComments"] == null
            ? null
            : json["therapistComments"],
        userComments: json["userComments"],
        cancellationReason: json["cancellationReason"] == null
            ? null
            : json["cancellationReason"],
        cancellationFee: json["cancellationFee"],
        cancelledUserId: json["cancelledUserId"],
        orderCompletion: json["orderCompletion"],
        createdUser: json["createdUser"],
        updatedUser: json["updatedUser"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        bookingTherapistId:
            BookingTherapistId.fromJson(json["bookingTherapistId"]),
        reviewAvgData: json["reviewAvgData"],
        noOfReviewsMembers: json["NoOfReviewsMembers"],
        favouriteToTherapist: json["favouriteToTherapist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "therapistId": therapistId,
        "addressId": addressId == null ? null : addressId,
        "eventId": eventId == null ? null : eventId,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "monthOfBooking": monthOfBooking,
        "yearOfBooking": yearOfBooking,
        "newStartTime":
            newStartTime == null ? null : newStartTime.toIso8601String(),
        "newEndTime": newEndTime == null ? null : newEndTime.toIso8601String(),
        "paymentId": paymentId == null ? null : paymentId,
        "paymentStatus": paymentStatus,
        "paymentRefId": paymentRefId,
        "subCategoryId": subCategoryId,
        "categoryId": categoryId,
        "nameOfService": nameOfService,
        "totalMinOfService": totalMinOfService,
        "priceOfService": priceOfService,
        "addedPrice": addedPrice == null ? null : addedPrice,
        "bookingStatus": bookingStatus,
        "statusUpdatedAt": statusUpdatedAt.toIso8601String(),
        "travelAmount": travelAmount == null ? null : travelAmount,
        "locationType": locationType == null ? null : locationType,
        "location": location,
        "locationDistance": locationDistance,
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "geomet": geomet == null ? null : geomet.toJson(),
        "totalCost": totalCost,
        "userReviewStatus": userReviewStatus,
        "therapistReviewStatus": therapistReviewStatus,
        "therapistComments":
            therapistComments == null ? null : therapistComments,
        "userComments": userComments,
        "cancellationReason":
            cancellationReason == null ? null : cancellationReason,
        "cancellationFee": cancellationFee,
        "cancelledUserId": cancelledUserId,
        "orderCompletion": orderCompletion,
        "createdUser": createdUser,
        "updatedUser": updatedUser,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "bookingTherapistId": bookingTherapistId.toJson(),
        "reviewAvgData": reviewAvgData,
        "NoOfReviewsMembers": noOfReviewsMembers,
        "favouriteToTherapist": favouriteToTherapist,
      };
}

class BookingTherapistId {
  BookingTherapistId({
    this.id,
    this.userId,
    this.userName,
    this.gender,
    this.uploadProfileImgUrl,
    this.businessForm,
    this.businessTrip,
    this.coronaMeasure,
    this.storeName,
    this.storeType,
    this.isShop,
    this.qulaificationCertImgUrl,
    this.firebaseUdid,
    this.certificationUploads,
  });

  int id;
  String userId;
  String userName;
  Gender gender;
  String uploadProfileImgUrl;
  BusinessForm businessForm;
  bool businessTrip;
  bool coronaMeasure;
  String storeName;
  dynamic storeType;
  bool isShop;
  String qulaificationCertImgUrl;
  dynamic firebaseUdid;
  List<CertificationUpload> certificationUploads;

  factory BookingTherapistId.fromJson(Map<String, dynamic> json) =>
      BookingTherapistId(
        id: json["id"],
        userId: json["userId"],
        userName: json["userName"],
        gender: genderValues.map[json["gender"]],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
        businessForm: businessFormValues.map[json["businessForm"]],
        businessTrip: json["businessTrip"],
        coronaMeasure: json["coronaMeasure"],
        storeName: json["storeName"],
        storeType: storeTypeValues.map[json["storeType"]],
        isShop: json["isShop"],
        qulaificationCertImgUrl: json["qulaificationCertImgUrl"],
        firebaseUdid: json["firebaseUDID"],
        certificationUploads: List<CertificationUpload>.from(
            json["certification_uploads"]
                .map((x) => CertificationUpload.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userName": userName,
        "gender": genderValues.reverse[gender],
        "uploadProfileImgUrl": uploadProfileImgUrl,
        "businessForm": businessFormValues.reverse[businessForm],
        "businessTrip": businessTrip,
        "coronaMeasure": coronaMeasure,
        "storeName": storeName,
        "storeType": storeTypeValues.reverse[storeType],
        "isShop": isShop,
        "qulaificationCertImgUrl": qulaificationCertImgUrl,
        "firebaseUDID": firebaseUdid,
        "certification_uploads":
            List<dynamic>.from(certificationUploads.map((x) => x.toJson())),
      };
}

enum BusinessForm { EMPTY, BUSINESS_FORM }

final businessFormValues = EnumValues({
  "施術店舗なし 施術従業員あり（出張のみ)": BusinessForm.BUSINESS_FORM,
  "施術店舗あり 施術従業員あり": BusinessForm.EMPTY
});

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
  String acupuncturistAndMoxibustion;
  String anmaMassageShiatsushi;
  String judoRehabilitationTeacher;
  dynamic physicalTherapist;
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
        moxibutionist:
            json["moxibutionist"] == null ? null : json["moxibutionist"],
        acupuncturistAndMoxibustion: json["acupuncturistAndMoxibustion"] == null
            ? null
            : json["acupuncturistAndMoxibustion"],
        anmaMassageShiatsushi: json["anmaMassageShiatsushi"] == null
            ? null
            : json["anmaMassageShiatsushi"],
        judoRehabilitationTeacher: json["judoRehabilitationTeacher"] == null
            ? null
            : json["judoRehabilitationTeacher"],
        physicalTherapist: json["physicalTherapist"],
        acquireNationalQualifications:
            json["acquireNationalQualifications"] == null
                ? null
                : json["acquireNationalQualifications"],
        privateQualification1: json["privateQualification1"] == null
            ? null
            : json["privateQualification1"],
        privateQualification2: json["privateQualification2"] == null
            ? null
            : json["privateQualification2"],
        privateQualification3: json["privateQualification3"] == null
            ? null
            : json["privateQualification3"],
        privateQualification4: json["privateQualification4"] == null
            ? null
            : json["privateQualification4"],
        privateQualification5: json["privateQualification5"] == null
            ? null
            : json["privateQualification5"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "acupuncturist": acupuncturist,
        "moxibutionist": moxibutionist == null ? null : moxibutionist,
        "acupuncturistAndMoxibustion": acupuncturistAndMoxibustion == null
            ? null
            : acupuncturistAndMoxibustion,
        "anmaMassageShiatsushi":
            anmaMassageShiatsushi == null ? null : anmaMassageShiatsushi,
        "judoRehabilitationTeacher": judoRehabilitationTeacher == null
            ? null
            : judoRehabilitationTeacher,
        "physicalTherapist": physicalTherapist,
        "acquireNationalQualifications": acquireNationalQualifications == null
            ? null
            : acquireNationalQualifications,
        "privateQualification1":
            privateQualification1 == null ? null : privateQualification1,
        "privateQualification2":
            privateQualification2 == null ? null : privateQualification2,
        "privateQualification3":
            privateQualification3 == null ? null : privateQualification3,
        "privateQualification4":
            privateQualification4 == null ? null : privateQualification4,
        "privateQualification5":
            privateQualification5 == null ? null : privateQualification5,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

enum Gender { EMPTY, GENDER }

final genderValues = EnumValues({"男性": Gender.EMPTY, "女性": Gender.GENDER});

enum StoreType { EMPTY, STORE_TYPE, PURPLE }

final storeTypeValues = EnumValues({
  "エステ,接骨・整体": StoreType.EMPTY,
  "エステ,接骨・整体,リラクゼーション,フィットネス": StoreType.PURPLE,
  "エステ,リラクゼーション,フィットネス": StoreType.STORE_TYPE
});

class Geomet {
  Geomet({
    this.type,
    this.coordinates,
  });

  String type;
  List<int> coordinates;

  factory Geomet.fromJson(Map<String, dynamic> json) => Geomet(
        type: json["type"],
        coordinates: List<int>.from(json["coordinates"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
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
