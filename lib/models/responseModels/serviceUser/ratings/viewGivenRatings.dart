// To parse this JSON data, do
//
//     final viewGivenRating = viewGivenRatingFromJson(jsonString);

import 'dart:convert';

ViewGivenRating viewGivenRatingFromJson(String str) =>
    ViewGivenRating.fromJson(json.decode(str));

String viewGivenRatingToJson(ViewGivenRating data) =>
    json.encode(data.toJson());

class ViewGivenRating {
  ViewGivenRating({
    this.status,
    this.bookingReviewData,
  });

  String status;
  BookingReviewData bookingReviewData;

  factory ViewGivenRating.fromJson(Map<String, dynamic> json) =>
      ViewGivenRating(
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
