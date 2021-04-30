// To parse this JSON data, do
//
//     final userReviewCreateResponseModel = userReviewCreateResponseModelFromJson(jsonString);

import 'dart:convert';

UserReviewCreateResponseModel userReviewCreateResponseModelFromJson(
        String str) =>
    UserReviewCreateResponseModel.fromJson(json.decode(str));

String userReviewCreateResponseModelToJson(
        UserReviewCreateResponseModel data) =>
    json.encode(data.toJson());

class UserReviewCreateResponseModel {
  UserReviewCreateResponseModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory UserReviewCreateResponseModel.fromJson(Map<String, dynamic> json) =>
      UserReviewCreateResponseModel(
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

  int id;
  String userId;
  int therapistId;
  bool isReviewStatus;
  int ratingsCount;
  String reviewComment;
  int createdUser;
  int updatedUser;
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
