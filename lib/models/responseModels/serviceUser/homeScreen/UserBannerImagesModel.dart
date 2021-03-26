// To parse this JSON data, do
//
//     final userBannerImagesModel = userBannerImagesModelFromJson(jsonString);

import 'dart:convert';

UserBannerImagesModel userBannerImagesModelFromJson(String str) =>
    UserBannerImagesModel.fromJson(json.decode(str));

String userBannerImagesModelToJson(UserBannerImagesModel data) =>
    json.encode(data.toJson());

class UserBannerImagesModel {
  UserBannerImagesModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory UserBannerImagesModel.fromJson(Map<String, dynamic> json) =>
      UserBannerImagesModel(
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
    this.totalElements,
    this.bannersList,
    this.totalPages,
    this.pageNumber,
  });

  int totalElements;
  List<BannersList> bannersList;
  int totalPages;
  int pageNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalElements: json["totalElements"],
        bannersList: List<BannersList>.from(
            json["bannersList"].map((x) => BannersList.fromJson(x))),
        totalPages: json["totalPages"],
        pageNumber: json["pageNumber"],
      );

  Map<String, dynamic> toJson() => {
        "totalElements": totalElements,
        "bannersList": List<dynamic>.from(bannersList.map((x) => x.toJson())),
        "totalPages": totalPages,
        "pageNumber": pageNumber,
      };
}

class BannersList {
  BannersList({
    this.id,
    this.adminBannerId,
    this.isBannerActive,
    this.bannerImageName,
    this.bannerImageUrl,
    this.bannerDisplayOrder,
    this.bannerUrl,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  dynamic adminBannerId;
  bool isBannerActive;
  String bannerImageName;
  String bannerImageUrl;
  String bannerDisplayOrder;
  dynamic bannerUrl;
  DateTime createdAt;
  DateTime updatedAt;

  factory BannersList.fromJson(Map<String, dynamic> json) => BannersList(
        id: json["id"],
        adminBannerId: json["adminBannerId"],
        isBannerActive: json["isBannerActive"],
        bannerImageName: json["bannerImageName"],
        bannerImageUrl: json["bannerImageUrl"],
        bannerDisplayOrder: json["bannerDisplayOrder"],
        bannerUrl: json["bannerUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adminBannerId": adminBannerId,
        "isBannerActive": isBannerActive,
        "bannerImageName": bannerImageName,
        "bannerImageUrl": bannerImageUrl,
        "bannerDisplayOrder": bannerDisplayOrder,
        "bannerUrl": bannerUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
