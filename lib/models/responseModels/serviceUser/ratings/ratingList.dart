// To parse this JSON data, do
//
//     final userReviewListById = userReviewListByIdFromJson(jsonString);

import 'dart:convert';

UserReviewListById userReviewListByIdFromJson(String str) =>
    UserReviewListById.fromJson(json.decode(str));

String userReviewListByIdToJson(UserReviewListById data) =>
    json.encode(data.toJson());

class UserReviewListById {
  UserReviewListById({
    this.status,
    this.therapistsData,
  });

  String status;
  TherapistsData therapistsData;

  factory UserReviewListById.fromJson(Map<String, dynamic> json) =>
      UserReviewListById(
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
        therapistReviewList: List<TherapistReviewList>.from(
            json["therapistReviewList"]
                .map((x) => TherapistReviewList.fromJson(x))),
        totalPages: json["totalPages"],
        pageNumber: json["pageNumber"],
      );

  Map<String, dynamic> toJson() => {
        "totalElements": totalElements,
        "therapistReviewList":
            List<dynamic>.from(therapistReviewList.map((x) => x.toJson())),
        "totalPages": totalPages,
        "pageNumber": pageNumber,
      };
}

class TherapistReviewList {
  TherapistReviewList({
    this.id,
    this.userId,
    this.therapistId,
    this.bookingId,
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
  int bookingId;
  bool isReviewStatus;
  int ratingsCount;
  ReviewComment reviewComment;
  String createdUser;
  String updatedUser;
  DateTime createdAt;
  DateTime updatedAt;
  ReviewUserId reviewUserId;

  factory TherapistReviewList.fromJson(Map<String, dynamic> json) =>
      TherapistReviewList(
        id: json["id"],
        userId: json["userId"],
        therapistId: json["therapistId"],
        bookingId: json["bookingId"] == null ? null : json["bookingId"],
        isReviewStatus: json["isReviewStatus"],
        ratingsCount: json["ratingsCount"],
        reviewComment: reviewCommentValues.map[json["reviewComment"]],
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
        "bookingId": bookingId == null ? null : bookingId,
        "isReviewStatus": isReviewStatus,
        "ratingsCount": ratingsCount,
        "reviewComment": reviewCommentValues.reverse[reviewComment],
        "createdUser": createdUser,
        "updatedUser": updatedUser,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "reviewUserId": reviewUserId.toJson(),
      };
}

enum ReviewComment { VERY_VERY_GOOD, TEST, REVIEW_COMMENT_TEST }

final reviewCommentValues = EnumValues({
  "test": ReviewComment.REVIEW_COMMENT_TEST,
  "test...": ReviewComment.TEST,
  "very very good": ReviewComment.VERY_VERY_GOOD
});

class ReviewUserId {
  ReviewUserId({
    this.id,
    this.userId,
    this.userName,
    this.uploadProfileImgUrl,
  });

  int id;
  UserId userId;
  UserName userName;
  String uploadProfileImgUrl;

  factory ReviewUserId.fromJson(Map<String, dynamic> json) => ReviewUserId(
        id: json["id"],
        userId: userIdValues.map[json["userId"]],
        userName: userNameValues.map[json["userName"]],
        uploadProfileImgUrl: json["uploadProfileImgUrl"] == null
            ? null
            : json["uploadProfileImgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userIdValues.reverse[userId],
        "userName": userNameValues.reverse[userName],
        "uploadProfileImgUrl":
            uploadProfileImgUrl == null ? null : uploadProfileImgUrl,
      };
}

enum UserId { U282, U277 }

final userIdValues = EnumValues({"U277": UserId.U277, "U282": UserId.U282});

enum UserName { MARSMELO, AKIL }

final userNameValues =
    EnumValues({"Akil": UserName.AKIL, "marsmelo": UserName.MARSMELO});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
