// To parse this JSON data, do
//
//     final upComingBookingModel = upComingBookingModelFromJson(jsonString);

import 'dart:convert';

UpComingBookingModel upComingBookingModelFromJson(String str) =>
    UpComingBookingModel.fromJson(json.decode(str));

String upComingBookingModelToJson(UpComingBookingModel data) =>
    json.encode(data.toJson());

class UpComingBookingModel {
  UpComingBookingModel({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory UpComingBookingModel.fromJson(Map<String, dynamic> json) =>
      UpComingBookingModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
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
    this.reviewAvgData,
    this.noOfReviewsMembers,
    this.favouriteToTherapist,
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
  dynamic therapistComments;
  String userComments;
  dynamic cancellationReason;
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        lat: json["lat"],
        lon: json["lon"],
        geomet: Geomet.fromJson(json["geomet"]),
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
        reviewAvgData: json["reviewAvgData"],
        noOfReviewsMembers: json["NoOfReviewsMembers"],
        favouriteToTherapist: json["favouriteToTherapist"],
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
        "geomet": geomet.toJson(),
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
  });

  int id;
  String userId;
  String userName;
  String gender;
  String uploadProfileImgUrl;
  String businessForm;
  bool businessTrip;
  bool coronaMeasure;
  dynamic storeName;
  String storeType;
  bool isShop;
  String qulaificationCertImgUrl;
  String firebaseUdid;

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
