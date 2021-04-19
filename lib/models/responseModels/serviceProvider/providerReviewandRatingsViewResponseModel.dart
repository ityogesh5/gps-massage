// To parse this JSON data, do
//
//     final providerReviewandRatingsViewResponseModel = providerReviewandRatingsViewResponseModelFromJson(jsonString);

import 'dart:convert';

ProviderReviewandRatingsViewResponseModel providerReviewandRatingsViewResponseModelFromJson(String str) => ProviderReviewandRatingsViewResponseModel.fromJson(json.decode(str));

String providerReviewandRatingsViewResponseModelToJson(ProviderReviewandRatingsViewResponseModel data) => json.encode(data.toJson());

class ProviderReviewandRatingsViewResponseModel {
    ProviderReviewandRatingsViewResponseModel({
        this.status,
        this.therapistsData,
    });

    String status;
    TherapistsData therapistsData;

    factory ProviderReviewandRatingsViewResponseModel.fromJson(Map<String, dynamic> json) => ProviderReviewandRatingsViewResponseModel(
        status: json["status"],
        therapistsData: TherapistsData.fromJson(json["therapistsData"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "therapistsData": therapistsData.toJson(),
    };
}

class TherapistsData {
    TherapistsData({
        this.totalElements,
        this.therapistReviewList,
        this.totalPages,
        this.pageNumber,
    });

    int totalElements;
    List<TherapistReviewList> therapistReviewList;
    int totalPages;
    int pageNumber;

    factory TherapistsData.fromJson(Map<String, dynamic> json) => TherapistsData(
        totalElements: json["totalElements"],
        therapistReviewList: List<TherapistReviewList>.from(json["therapistReviewList"].map((x) => TherapistReviewList.fromJson(x))),
        totalPages: json["totalPages"],
        pageNumber: json["pageNumber"],
    );

    Map<String, dynamic> toJson() => {
        "totalElements": totalElements,
        "therapistReviewList": List<dynamic>.from(therapistReviewList.map((x) => x.toJson())),
        "totalPages": totalPages,
        "pageNumber": pageNumber,
    };
}

class TherapistReviewList {
    TherapistReviewList({
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
        this.reviewUserId,
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
    ReviewUserId reviewUserId;

    factory TherapistReviewList.fromJson(Map<String, dynamic> json) => TherapistReviewList(
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
        reviewUserId: ReviewUserId.fromJson(json["reviewUserId"]),
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
        "reviewUserId": reviewUserId.toJson(),
    };
}

class ReviewUserId {
    ReviewUserId({
        this.id,
        this.userId,
        this.userName,
        this.uploadProfileImgUrl,
    });

    int id;
    String userId;
    String userName;
    dynamic uploadProfileImgUrl;

    factory ReviewUserId.fromJson(Map<String, dynamic> json) => ReviewUserId(
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
