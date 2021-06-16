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
    this.isTherapistStatus,
    this.firebaseNotiticationId,
    this.isReadStatus,
    this.createdAt,
    this.updatedAt,
    this.bookingDetail,
  });

  int id;
  int userId;
  int bookingId;
  dynamic adminInfoId;
  bool isTherapistStatus;
  int firebaseNotiticationId;
  bool isReadStatus;
  DateTime createdAt;
  DateTime updatedAt;
  BookingDetail bookingDetail;

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      NotificationList(
        id: json["id"],
        userId: json["userId"],
        bookingId: json["bookingId"],
        adminInfoId: json["adminInfoId"],
        isTherapistStatus: json["isTherapistStatus"],
        firebaseNotiticationId: json["firebaseNotiticationId"],
        isReadStatus: json["isReadStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        bookingDetail: BookingDetail.fromJson(json["bookingDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bookingId": bookingId,
        "adminInfoId": adminInfoId,
        "isTherapistStatus": isTherapistStatus,
        "firebaseNotiticationId": firebaseNotiticationId,
        "isReadStatus": isReadStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "bookingDetail": bookingDetail.toJson(),
      };
}

class BookingDetail {
  BookingDetail({
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
  int therapistReviewStatus;
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
        addressId: json["addressId"] == null ? null : json["addressId"],
        eventId: json["eventId"],
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
        geomet: Geomet.fromJson(json["geomet"]),
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
        bookingTherapistId:
            BookingTherapistId.fromJson(json["bookingTherapistId"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "therapistId": therapistId,
        "addressId": addressId == null ? null : addressId,
        "eventId": eventId,
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
        "travelAmount": travelAmount,
        "locationType": locationType,
        "location": location,
        "locationDistance": locationDistance,
        "lat": lat,
        "lon": lon,
        "geomet": geomet.toJson(),
        "totalCost": totalCost,
        "userReviewStatus": userReviewStatus,
        "therapistReviewStatus":
            therapistReviewStatus == null ? null : therapistReviewStatus,
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
      };
}

class BookingTherapistId {
  BookingTherapistId({
    this.id,
    this.userId,
    this.userName,
    this.gender,
    this.uploadProfileImgUrl,
    this.numberOfEmp,
    this.businessForm,
    this.businessTrip,
    this.firebaseUdid,
    this.storeName,
    this.isShop,
  });

  int id;
  String userId;
  String userName;
  String gender;
  String uploadProfileImgUrl;
  int numberOfEmp;
  String businessForm;
  bool businessTrip;
  String firebaseUdid;
  String storeName;
  bool isShop;

  factory BookingTherapistId.fromJson(Map<String, dynamic> json) =>
      BookingTherapistId(
        id: json["id"],
        userId: json["userId"],
        userName: json["userName"],
        gender: json["gender"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
        numberOfEmp: json["numberOfEmp"],
        businessForm: json["businessForm"],
        businessTrip: json["businessTrip"],
        firebaseUdid: json["firebaseUDID"],
        storeName: json["storeName"],
        isShop: json["isShop"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userName": userName,
        "gender": gender,
        "uploadProfileImgUrl": uploadProfileImgUrl,
        "numberOfEmp": numberOfEmp,
        "businessForm": businessForm,
        "businessTrip": businessTrip,
        "firebaseUDID": firebaseUdid,
        "storeName": storeName,
        "isShop": isShop,
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
