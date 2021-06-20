// To parse this JSON data, do
//
//     final firebaseNotificationTherapistListModel = firebaseNotificationTherapistListModelFromJson(jsonString);

import 'dart:convert';

FirebaseNotificationTherapistListModel
    firebaseNotificationTherapistListModelFromJson(String str) =>
        FirebaseNotificationTherapistListModel.fromJson(json.decode(str));

String firebaseNotificationTherapistListModelToJson(
        FirebaseNotificationTherapistListModel data) =>
    json.encode(data.toJson());

class FirebaseNotificationTherapistListModel {
  FirebaseNotificationTherapistListModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory FirebaseNotificationTherapistListModel.fromJson(
          Map<String, dynamic> json) =>
      FirebaseNotificationTherapistListModel(
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
    this.reviewAvgData,
    this.noOfReviewsMembers,
    this.information,
  });

  int id;
  int userId;
  int bookingId;
  dynamic adminInfoId;
  int bookingStatus;
  bool isTherapistStatus;
  int firebaseNotiticationId;
  bool isReadStatus;
  DateTime createdAt;
  DateTime updatedAt;
  BookingDetail bookingDetail;
  String reviewAvgData;
  int noOfReviewsMembers;
  Information information;

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      NotificationList(
        id: json["id"],
        userId: json["userId"],
        bookingId: json["bookingId"],
        adminInfoId: json["adminInfoId"],
        bookingStatus: json["bookingStatus"],
        isTherapistStatus: json["isTherapistStatus"],
        firebaseNotiticationId: json["firebaseNotiticationId"],
        isReadStatus: json["isReadStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        bookingDetail: BookingDetail.fromJson(json["bookingDetail"]),
        reviewAvgData: json["reviewAvgData"],
        noOfReviewsMembers: json["NoOfReviewsMembers"],
        information: json["information"] == null
            ? null
            : Information.fromJson(json["information"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bookingId": bookingId,
        "adminInfoId": adminInfoId,
        "bookingStatus": bookingStatus,
        "isTherapistStatus": isTherapistStatus,
        "firebaseNotiticationId": firebaseNotiticationId,
        "isReadStatus": isReadStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "bookingDetail": bookingDetail.toJson(),
        "reviewAvgData": reviewAvgData,
        "NoOfReviewsMembers": noOfReviewsMembers,
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
    this.bookingUserId,
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
  dynamic newStartTime;
  dynamic newEndTime;
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
  int totalCost;
  int userReviewStatus;
  dynamic therapistReviewStatus;
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
  BookingUserId bookingUserId;

  factory BookingDetail.fromJson(Map<String, dynamic> json) => BookingDetail(
        id: json["id"],
        userId: json["userId"],
        therapistId: json["therapistId"],
        addressId: json["addressId"] == null ? null : json["addressId"],
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
        addedPrice: json["addedPrice"] == null ? null : json["addedPrice"],
        bookingStatus: json["bookingStatus"],
        statusUpdatedAt: DateTime.parse(json["statusUpdatedAt"]),
        travelAmount: json["travelAmount"],
        locationType: json["locationType"],
        location: json["location"],
        locationDistance: json["locationDistance"],
        lat: json["lat"],
        lon: json["lon"],
        totalCost: json["totalCost"],
        userReviewStatus: json["userReviewStatus"],
        therapistReviewStatus: json["therapistReviewStatus"] == null
            ? null
            : json["therapistReviewStatus"],
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
        bookingUserId: BookingUserId.fromJson(json["bookingUserId"]),
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
        "lat": lat,
        "lon": lon,
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
        "bookingUserId": bookingUserId.toJson(),
      };
}

class BookingUserId {
  BookingUserId({
    this.id,
    this.userId,
    this.userName,
    this.gender,
    this.uploadProfileImgUrl,
    this.firebaseUdid,
  });

  int id;
  String userId;
  String userName;
  String gender;
  String uploadProfileImgUrl;
  String firebaseUdid;

  factory BookingUserId.fromJson(Map<String, dynamic> json) => BookingUserId(
        id: json["id"],
        userId: json["userId"],
        userName: json["userName"],
        gender: json["gender"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"] == null
            ? null
            : json["uploadProfileImgUrl"],
        firebaseUdid: json["firebaseUDID"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userName": userName,
        "gender": gender,
        "uploadProfileImgUrl": uploadProfileImgUrl,
        "firebaseUDID": firebaseUdid,
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
