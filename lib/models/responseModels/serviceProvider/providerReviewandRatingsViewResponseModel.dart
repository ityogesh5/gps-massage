// To parse this JSON data, do
//
//     final providerReviewandRatingsViewResponseModel = providerReviewandRatingsViewResponseModelFromJson(jsonString);

import 'dart:convert';

ProviderReviewandRatingsViewResponseModel providerReviewandRatingsViewResponseModelFromJson(String str) => ProviderReviewandRatingsViewResponseModel.fromJson(json.decode(str));

String providerReviewandRatingsViewResponseModelToJson(ProviderReviewandRatingsViewResponseModel data) => json.encode(data.toJson());

class ProviderReviewandRatingsViewResponseModel {
    ProviderReviewandRatingsViewResponseModel({
        this.status,
        this.userData,
    });

    String status;
    UserData userData;

    factory ProviderReviewandRatingsViewResponseModel.fromJson(Map<String, dynamic> json) => ProviderReviewandRatingsViewResponseModel(
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
        this.userList,
        this.totalPages,
        this.pageNumber,
    });

    int totalElements;
    List<UserList> userList;
    int totalPages;
    int pageNumber;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        totalElements: json["totalElements"],
        userList: List<UserList>.from(json["userList"].map((x) => UserList.fromJson(x))),
        totalPages: json["totalPages"],
        pageNumber: json["pageNumber"],
    );

    Map<String, dynamic> toJson() => {
        "totalElements": totalElements,
        "userList": List<dynamic>.from(userList.map((x) => x.toJson())),
        "totalPages": totalPages,
        "pageNumber": pageNumber,
    };
}

class UserList {
    UserList({
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
        this.userName,
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
    String userName;

    factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        id: json["id"],
        userId: json["userId"],
        therapistId: json["therapistId"],
        ratingsId: json["ratingsId"],
        isReviewStatus: json["isReviewStatus"],
        ratingsCount: json["ratingsCount"],
        reviewComment: json["reviewComment"],
        createdUser: json["createdUser"],
        updatedUser: json["updatedUser"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "therapistId": therapistId,
        "ratingsId": ratingsId,
        "isReviewStatus": isReviewStatus,
        "ratingsCount": ratingsCount,
        "reviewComment": reviewComment,
        "createdUser": createdUser,
        "updatedUser": updatedUser,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "userName": userName,
    };
}
