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
    this.bookingUserId,
    this.reviewAvgData,
    this.noOfReviewsMembers,
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
  BookingUserId bookingUserId;
  String reviewAvgData;
  int noOfReviewsMembers;

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      NotificationList(
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
        bookingUserId: BookingUserId.fromJson(json["bookingUserId"]),
        reviewAvgData: json["reviewAvgData"],
        noOfReviewsMembers: json["NoOfReviewsMembers"],
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
        "bookingUserId": bookingUserId.toJson(),
        "reviewAvgData": reviewAvgData,
        "NoOfReviewsMembers": noOfReviewsMembers,
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
        "uploadProfileImgUrl":
            uploadProfileImgUrl == null ? null : uploadProfileImgUrl,
        "firebaseUDID": firebaseUdid,
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
