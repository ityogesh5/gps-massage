// To parse this JSON data, do
//
//     final ratingReviewModel = ratingReviewModelFromJson(jsonString);

import 'dart:convert';

RatingReviewModel ratingReviewModelFromJson(String str) =>
    RatingReviewModel.fromJson(json.decode(str));

String ratingReviewModelToJson(RatingReviewModel data) =>
    json.encode(data.toJson());

class RatingReviewModel {
  RatingReviewModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory RatingReviewModel.fromJson(Map<String, dynamic> json) =>
      RatingReviewModel(
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
    this.isReviewStatus,
    this.ratingsCount,
    this.reviewComment,
    this.createdUser,
    this.updatedUser,
    this.updatedAt,
    this.createdAt,
  });

  dynamic id;
  dynamic userId;
  String therapistId;
  bool isReviewStatus;
  String ratingsCount;
  String reviewComment;
  dynamic createdUser;
  dynamic updatedUser;
  DateTime updatedAt;
  DateTime createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["userId"],
        therapistId: json["therapistId"],
        isReviewStatus: json["isReviewStatus"],
        ratingsCount: json["ratingsCount"],
        reviewComment: json["reviewComment"],
        createdUser: json["createdUser"],
        updatedUser: json["updatedUser"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "therapistId": therapistId,
        "isReviewStatus": isReviewStatus,
        "ratingsCount": ratingsCount,
        "reviewComment": reviewComment,
        "createdUser": createdUser,
        "updatedUser": updatedUser,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
