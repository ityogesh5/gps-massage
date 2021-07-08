// To parse this JSON data, do
//
//     final firebaseNotificationUserListModel = firebaseNotificationUserListModelFromJson(jsonString);

import 'dart:convert';

FirebaseNotificationUserListModel firebaseNotificationUserListModelFromJson(
        String str) =>
    FirebaseNotificationUserListModel.fromJson(json.decode(str));

String firebaseNotificationUserListModelToJson(
        FirebaseNotificationUserListModel data) =>
    json.encode(data.toJson());

class FirebaseNotificationUserListModel {
  FirebaseNotificationUserListModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory FirebaseNotificationUserListModel.fromJson(
          Map<String, dynamic> json) =>
      FirebaseNotificationUserListModel(
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
    this.notificationList,
    this.totalPages,
    this.pageNumber,
  });

  int count;
  List<NotificationList> notificationList;
  int totalPages;
  int pageNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        notificationList: List<NotificationList>.from(
            json["notificationList"].map((x) => NotificationList.fromJson(x))),
        totalPages: json["totalPages"],
        pageNumber: json["pageNumber"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "notificationList":
            List<dynamic>.from(notificationList.map((x) => x.toJson())),
        "totalPages": totalPages,
        "pageNumber": pageNumber,
      };
}

class NotificationList {
  NotificationList({
    this.id,
    this.userId,
    this.bookingId,
    this.adminInfoId,
    this.bookingStatus,
    this.isTherapistStatus,
    this.firebaseNotiticationId,
    this.isReadStatus,
    this.createdAt,
    this.updatedAt,
    this.bookingDetail,
    this.information,
  });

  int id;
  int userId;
  int bookingId;
  int adminInfoId;
  int bookingStatus;
  bool isTherapistStatus;
  int firebaseNotiticationId;
  bool isReadStatus;
  DateTime createdAt;
  DateTime updatedAt;
  BookingDetail bookingDetail;
  Information information;

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      NotificationList(
        id: json["id"],
        userId: json["userId"],
        bookingId: json["bookingId"] == null ? null : json["bookingId"],
        adminInfoId: json["adminInfoId"] == null ? null : json["adminInfoId"],
        bookingStatus:
            json["bookingStatus"] == null ? null : json["bookingStatus"],
        isTherapistStatus: json["isTherapistStatus"],
        firebaseNotiticationId: json["firebaseNotiticationId"],
        isReadStatus: json["isReadStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        bookingDetail: json["bookingDetail"] == null
            ? null
            : BookingDetail.fromJson(json["bookingDetail"]),
        information: json["information"] == null
            ? null
            : Information.fromJson(json["information"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bookingId": bookingId == null ? null : bookingId,
        "adminInfoId": adminInfoId == null ? null : adminInfoId,
        "bookingStatus": bookingStatus == null ? null : bookingStatus,
        "isTherapistStatus": isTherapistStatus,
        "firebaseNotiticationId": firebaseNotiticationId,
        "isReadStatus": isReadStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "bookingDetail": bookingDetail == null ? null : bookingDetail.toJson(),
        "information": information == null ? null : information.toJson(),
      };
}

class BookingDetail {
  BookingDetail({
    this.id,
    this.userId,
    this.therapistId,
    this.addressId,
    this.eventId,
    this.currentPrefecture,
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
  });

  int id;
  int userId;
  int therapistId;
  int addressId;
  String eventId;
  String currentPrefecture;
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
  dynamic addedPrice;
  int bookingStatus;
  DateTime statusUpdatedAt;
  int travelAmount;
  String locationType;
  String location;
  String locationDistance;
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

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
        id: json["id"],
        userId: json["userId"],
        therapistId: json["therapistId"],
        addressId: json["addressId"],
        eventId: json["eventId"],
        currentPrefecture: json["currentPrefecture"],
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
        addedPrice: json["addedPrice"],
        bookingStatus: json["bookingStatus"],
        statusUpdatedAt: DateTime.parse(json["statusUpdatedAt"]),
        travelAmount: json["travelAmount"],
        locationType: json["locationType"],
        location: json["location"],
        locationDistance: json["locationDistance"],
        lat: json["lat"],
        lon: json["lon"],
        geomet: Geomet.fromJson(json["geomet"]),
        totalCost: json["totalCost"],
        userReviewStatus: json["userReviewStatus"],
        therapistReviewStatus: json["therapistReviewStatus"],
        therapistComments: json["therapistComments"] == null
            ? null
            : json["therapistComments"],
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
        "id": id,
        "userId": userId,
        "therapistId": therapistId,
        "addressId": addressId,
        "eventId": eventId,
        "currentPrefecture": currentPrefecture,
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
        "addedPrice": addedPrice,
        "bookingStatus": bookingStatus,
        "statusUpdatedAt": statusUpdatedAt.toIso8601String(),
        "travelAmount": travelAmount,
        "locationType": locationType,
        "location": location,
        "locationDistance": locationDistance,
        "lat": lat,
        "lon": lon,
        "geomet": geomet.toJson(),
        "totalCost": totalCost,
        "userReviewStatus": userReviewStatus,
        "therapistReviewStatus": therapistReviewStatus,
        "therapistComments":
            therapistComments == null ? null : therapistComments,
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
  String firebaseUdid;
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
  dynamic moxibutionist;
  dynamic acupuncturistAndMoxibustion;
  dynamic anmaMassageShiatsushi;
  dynamic judoRehabilitationTeacher;
  String physicalTherapist;
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

class Information {
  Information({
    this.id,
    this.userId,
    this.infoStatus,
    this.infoMessage,
    this.createdUser,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int infoStatus;
  String infoMessage;
  String createdUser;
  DateTime createdAt;
  DateTime updatedAt;

  factory Information.fromJson(Map<String, dynamic> json) => Information(
        id: json["id"],
        userId: json["userId"],
        infoStatus: json["infoStatus"],
        infoMessage: json["infoMessage"],
        createdUser: json["createdUser"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "infoStatus": infoStatus,
        "infoMessage": infoMessage,
        "createdUser": createdUser,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
