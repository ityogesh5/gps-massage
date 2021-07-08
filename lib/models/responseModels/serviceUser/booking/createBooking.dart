// To parse this JSON data, do
//
//     final createBookingModel = createBookingModelFromJson(jsonString);

import 'dart:convert';

CreateBookingModel createBookingModelFromJson(String str) =>
    CreateBookingModel.fromJson(json.decode(str));

String createBookingModelToJson(CreateBookingModel data) =>
    json.encode(data.toJson());

class CreateBookingModel {
  CreateBookingModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory CreateBookingModel.fromJson(Map<String, dynamic> json) =>
      CreateBookingModel(
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
    this.id,
    this.userId,
    this.therapistId,
    this.startTime,
    this.endTime,
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
    this.bookingStatus,
    this.travelAmount,
    this.locationType,
    this.location,
    this.locationDistance,
    this.totalCost,
    this.userReviewStatus,
    this.therapistReviewStatus,
    this.therapistCommants,
    this.userCommants,
    this.cancellationReason,
    this.cancellationFee,
    this.cancelledUserId,
    this.createdUser,
    this.updatedUser,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int therapistId;
  DateTime startTime;
  DateTime endTime;
  DateTime newStartTime;
  DateTime newEndTime;
  int paymentId;
  int paymentStatus;
  String paymentRefId;
  int subCategoryId;
  int categoryId;
  String nameOfService;
  int totalMinOfService;
  int priceOfService;
  int bookingStatus;
  int travelAmount;
  String locationType;
  String location;
  String locationDistance;
  int totalCost;
  int userReviewStatus;
  int therapistReviewStatus;
  String therapistCommants;
  String userCommants;
  String cancellationReason;
  int cancellationFee;
  int cancelledUserId;
  String createdUser;
  String updatedUser;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["userId"],
        therapistId: json["therapistId"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        newStartTime: DateTime.parse(json["newStartTime"]),
        newEndTime: DateTime.parse(json["newEndTime"]),
        paymentId: json["paymentId"],
        paymentStatus: json["paymentStatus"],
        paymentRefId: json["paymentRefId"],
        subCategoryId: json["subCategoryId"],
        categoryId: json["categoryId"],
        nameOfService: json["nameOfService"],
        totalMinOfService: json["totalMinOfService"],
        priceOfService: json["priceOfService"],
        bookingStatus: json["bookingStatus"],
        travelAmount: json["travelAmount"],
        locationType: json["locationType"],
        location: json["location"],
        locationDistance: json["locationDistance"],
        totalCost: json["totalCost"],
        userReviewStatus: json["userReviewStatus"],
        therapistReviewStatus: json["therapistReviewStatus"],
        therapistCommants: json["therapistCommants"],
        userCommants: json["userCommants"],
        cancellationReason: json["cancellationReason"],
        cancellationFee: json["cancellationFee"],
        cancelledUserId: json["cancelledUserId"],
        createdUser: json["createdUser"],
        updatedUser: json["updatedUser"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "therapistId": therapistId,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "newStartTime": newStartTime.toIso8601String(),
        "newEndTime": newEndTime.toIso8601String(),
        "paymentId": paymentId,
        "paymentStatus": paymentStatus,
        "paymentRefId": paymentRefId,
        "subCategoryId": subCategoryId,
        "categoryId": categoryId,
        "nameOfService": nameOfService,
        "totalMinOfService": totalMinOfService,
        "priceOfService": priceOfService,
        "bookingStatus": bookingStatus,
        "travelAmount": travelAmount,
        "locationType": locationType,
        "location": location,
        "locationDistance": locationDistance,
        "totalCost": totalCost,
        "userReviewStatus": userReviewStatus,
        "therapistReviewStatus": therapistReviewStatus,
        "therapistCommants": therapistCommants,
        "userCommants": userCommants,
        "cancellationReason": cancellationReason,
        "cancellationFee": cancellationFee,
        "cancelledUserId": cancelledUserId,
        "createdUser": createdUser,
        "updatedUser": updatedUser,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
