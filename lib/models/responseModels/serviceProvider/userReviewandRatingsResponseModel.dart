// To parse this JSON data, do
//
//     final userReviewandRatingsViewResponseModel = userReviewandRatingsViewResponseModelFromJson(jsonString);

import 'dart:convert';

UserReviewandRatingsViewResponseModel
    userReviewandRatingsViewResponseModelFromJson(String str) =>
        UserReviewandRatingsViewResponseModel.fromJson(json.decode(str));

String userReviewandRatingsViewResponseModelToJson(
        UserReviewandRatingsViewResponseModel data) =>
    json.encode(data.toJson());

class UserReviewandRatingsViewResponseModel {
  UserReviewandRatingsViewResponseModel({
    this.status,
    this.userData,
  });

  String status;
  UserData userData;

  factory UserReviewandRatingsViewResponseModel.fromJson(
          Map<String, dynamic> json) =>
      UserReviewandRatingsViewResponseModel(
        status: json["status"],
        userData: UserData.fromJson(json["userData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "userData": userData.toJson(),
      };
}

class UserData {
  UserData({
    this.totalElements,
    this.userReviewList,
    this.totalPages,
    this.pageNumber,
  });

  int totalElements;
  List<UserReviewList> userReviewList;
  int totalPages;
  int pageNumber;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        totalElements: json["totalElements"],
        userReviewList: List<UserReviewList>.from(
            json["userReviewList"].map((x) => UserReviewList.fromJson(x))),
        totalPages: json["totalPages"],
        pageNumber: json["pageNumber"],
      );

  Map<String, dynamic> toJson() => {
        "totalElements": totalElements,
        "userReviewList":
            List<dynamic>.from(userReviewList.map((x) => x.toJson())),
        "totalPages": totalPages,
        "pageNumber": pageNumber,
      };
}

class UserReviewList {
  UserReviewList({
    this.id,
    this.userId,
    this.therapistId,
    this.ratingsId,
    this.isReviewStatus,
    this.ratingsCount,
    this.reviewComment,
    this.createdUser,
    this.updatedUser,
    this.createdAt,
    this.updatedAt,
    this.reviewTherapistId,
  });

  int id;
  int userId;
  int therapistId;
  dynamic ratingsId;
  bool isReviewStatus;
  int ratingsCount;
  String reviewComment;
  String createdUser;
  String updatedUser;
  DateTime createdAt;
  DateTime updatedAt;
  ReviewTherapistId reviewTherapistId;

  factory UserReviewList.fromJson(Map<String, dynamic> json) => UserReviewList(
        id: json["id"],
        userId: json["userId"],
        therapistId: json["therapistId"],
        ratingsId: json["ratingsId"],
        isReviewStatus: json["isReviewStatus"],
        ratingsCount: json["ratingsCount"],
        reviewComment: json["reviewComment"],
        createdUser: json["createdUser"] == null ? null : json["createdUser"],
        updatedUser: json["updatedUser"] == null ? null : json["updatedUser"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        reviewTherapistId:
            ReviewTherapistId.fromJson(json["reviewTherapistId"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "therapistId": therapistId,
        "ratingsId": ratingsId,
        "isReviewStatus": isReviewStatus,
        "ratingsCount": ratingsCount,
        "reviewComment": reviewComment,
        "createdUser": createdUser == null ? null : createdUser,
        "updatedUser": updatedUser == null ? null : updatedUser,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "reviewTherapistId": reviewTherapistId.toJson(),
      };
}

class ReviewTherapistId {
  ReviewTherapistId({
    this.id,
    this.userId,
    this.userName,
    this.uploadProfileImgUrl,
  });

  int id;
  String userId;
  String userName;
  String uploadProfileImgUrl;

  factory ReviewTherapistId.fromJson(Map<String, dynamic> json) =>
      ReviewTherapistId(
        id: json["id"],
        userId: json["userId"],
        userName: json["userName"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userName": userName,
        "uploadProfileImgUrl": uploadProfileImgUrl,
      };
}
