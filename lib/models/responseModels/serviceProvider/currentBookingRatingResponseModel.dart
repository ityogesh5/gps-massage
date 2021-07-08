// To parse this JSON data, do
//
//     final currentOrderReviewResponseModel = currentOrderReviewResponseModelFromJson(jsonString);

import 'dart:convert';

CurrentOrderReviewResponseModel currentOrderReviewResponseModelFromJson(
        String str) =>
    CurrentOrderReviewResponseModel.fromJson(json.decode(str));

String currentOrderReviewResponseModelToJson(
        CurrentOrderReviewResponseModel data) =>
    json.encode(data.toJson());

class CurrentOrderReviewResponseModel {
  CurrentOrderReviewResponseModel({
    this.status,
    this.bookingReviewData,
  });

  String status;
  BookingReviewData bookingReviewData;

  factory CurrentOrderReviewResponseModel.fromJson(Map<String, dynamic> json) =>
      CurrentOrderReviewResponseModel(
        status: json["status"],
        bookingReviewData:
            BookingReviewData.fromJson(json["bookingReviewData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "bookingReviewData": bookingReviewData.toJson(),
      };
}

class BookingReviewData {
  BookingReviewData({
    this.id,
    this.bookingId,
    this.ratingsCount,
    this.reviewComment,
  });

  int id;
  int bookingId;
  int ratingsCount;
  String reviewComment;

  factory BookingReviewData.fromJson(Map<String, dynamic> json) =>
      BookingReviewData(
        id: json["id"],
        bookingId: json["bookingId"],
        ratingsCount: json["ratingsCount"],
        reviewComment: json["reviewComment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookingId": bookingId,
        "ratingsCount": ratingsCount,
        "reviewComment": reviewComment,
      };
}
