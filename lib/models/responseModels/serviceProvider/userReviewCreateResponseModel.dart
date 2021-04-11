// To parse this JSON data, do
//
//     final userReviewCreateResponseModel = userReviewCreateResponseModelFromJson(jsonString);

import 'dart:convert';

UserReviewCreateResponseModel userReviewCreateResponseModelFromJson(String str) => UserReviewCreateResponseModel.fromJson(json.decode(str));

String userReviewCreateResponseModelToJson(UserReviewCreateResponseModel data) => json.encode(data.toJson());

class UserReviewCreateResponseModel {
    UserReviewCreateResponseModel({
        this.status,
        this.userData,
    });

    String status;
    UserData userData;

    factory UserReviewCreateResponseModel.fromJson(Map<String, dynamic> json) => UserReviewCreateResponseModel(
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
        this.id,
        this.userId,
        this.therapistId,
        this.ratingsCount,
        this.reviewComment,
        this.isReviewStatus,
        this.updatedAt,
        this.createdAt,
    });

    int id;
    String userId;
    int therapistId;
    int ratingsCount;
    String reviewComment;
    bool isReviewStatus;
    DateTime updatedAt;
    DateTime createdAt;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        userId: json["userId"],
        therapistId: json["therapistId"],
        ratingsCount: json["ratingsCount"],
        reviewComment: json["reviewComment"],
        isReviewStatus: json["isReviewStatus"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "therapistId": therapistId,
        "ratingsCount": ratingsCount,
        "reviewComment": reviewComment,
        "isReviewStatus": isReviewStatus,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
    };
}
