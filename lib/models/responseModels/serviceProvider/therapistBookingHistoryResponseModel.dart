// To parse this JSON data, do
//
//     final therapistBookingHistoryResponseModel = therapistBookingHistoryResponseModelFromJson(jsonString);

import 'dart:convert';

TherapistBookingHistoryResponseModel
    therapistBookingHistoryResponseModelFromJson(String str) =>
        TherapistBookingHistoryResponseModel.fromJson(json.decode(str));

String therapistBookingHistoryResponseModelToJson(
        TherapistBookingHistoryResponseModel data) =>
    json.encode(data.toJson());

class TherapistBookingHistoryResponseModel {
  TherapistBookingHistoryResponseModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory TherapistBookingHistoryResponseModel.fromJson(
          Map<String, dynamic> json) =>
      TherapistBookingHistoryResponseModel(
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
    this.bookingUserId,
    this.reviewAvgData,
    this.noOfReviewsMembers,
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
  dynamic statusUpdatedAt;
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
  BookingUserId bookingUserId;
  String reviewAvgData;
  int noOfReviewsMembers;

  factory BookingDetailsList.fromJson(Map<String, dynamic> json) =>
      BookingDetailsList(
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
        statusUpdatedAt: json["statusUpdatedAt"],
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
        bookingUserId: BookingUserId.fromJson(json["bookingUserId"]),
        reviewAvgData: json["reviewAvgData"],
        noOfReviewsMembers: json["NoOfReviewsMembers"],
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
  dynamic uploadProfileImgUrl;
  String firebaseUdid;

  factory BookingUserId.fromJson(Map<String, dynamic> json) => BookingUserId(
        id: json["id"],
        userId: json["userId"],
        userName: json["userName"],
        gender: json["gender"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
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
