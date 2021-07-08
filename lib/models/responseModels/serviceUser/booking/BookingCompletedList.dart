// To parse this JSON data, do
//
//     final bookingCompletedList = bookingCompletedListFromJson(jsonString);

import 'dart:convert';

BookingCompletedList bookingCompletedListFromJson(String str) =>
    BookingCompletedList.fromJson(json.decode(str));

String bookingCompletedListToJson(BookingCompletedList data) =>
    json.encode(data.toJson());

class BookingCompletedList {
  BookingCompletedList({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory BookingCompletedList.fromJson(Map<String, dynamic> json) =>
      BookingCompletedList(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.count,
    this.bookingDetailsList,
    this.totalPages,
    this.pageNumber,
  });

  int count;
  List<BookingDetailsList> bookingDetailsList;
  int totalPages;
  int pageNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        bookingDetailsList: List<BookingDetailsList>.from(
            json["BookingDetailsList"]
                .map((x) => BookingDetailsList.fromJson(x))),
        totalPages: json["totalPages"],
        pageNumber: json["pageNumber"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "BookingDetailsList":
            List<dynamic>.from(bookingDetailsList.map((x) => x.toJson())),
        "totalPages": totalPages,
        "pageNumber": pageNumber,
      };
}

class BookingDetailsList {
  BookingDetailsList({
    this.favouriteToTherapist,
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
    this.bookingTherapistId,
  });

  int favouriteToTherapist;
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
  int therapistReviewStatus;
  String therapistComments;
  dynamic userComments;
  dynamic cancellationReason;
  dynamic cancellationFee;
  dynamic cancelledUserId;
  dynamic orderCompletion;
  String createdUser;
  String updatedUser;
  DateTime createdAt;
  DateTime updatedAt;
  BookingTherapistId bookingTherapistId;

  factory BookingDetailsList.fromJson(Map<String, dynamic> json) =>
      BookingDetailsList(
        favouriteToTherapist: json["favouriteToTherapist"],
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
        bookingTherapistId:
            BookingTherapistId.fromJson(json["bookingTherapistId"]),
      );

  Map<String, dynamic> toJson() => {
        "favouriteToTherapist": favouriteToTherapist,
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
        "bookingTherapistId": bookingTherapistId.toJson(),
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
  String gender;
  String uploadProfileImgUrl;
  String businessForm;
  bool businessTrip;
  bool coronaMeasure;
  String storeName;
  String storeType;
  bool isShop;
  String qulaificationCertImgUrl;
  dynamic firebaseUdid;
  List<CertificationUpload> certificationUploads;

  factory BookingTherapistId.fromJson(Map<String, dynamic> json) =>
      BookingTherapistId(
        id: json["id"],
        userId: json["userId"],
        userName: json["userName"],
        gender: json["gender"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
        businessForm: json["businessForm"],
        businessTrip: json["businessTrip"],
        coronaMeasure: json["coronaMeasure"],
        storeName: json["storeName"],
        storeType: json["storeType"],
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
        "gender": gender,
        "uploadProfileImgUrl": uploadProfileImgUrl,
        "businessForm": businessForm,
        "businessTrip": businessTrip,
        "coronaMeasure": coronaMeasure,
        "storeName": storeName,
        "storeType": storeType,
        "isShop": isShop,
        "qulaificationCertImgUrl": qulaificationCertImgUrl,
        "firebaseUDID": firebaseUdid,
        "certification_uploads":
            List<dynamic>.from(certificationUploads.map((x) => x.toJson())),
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
