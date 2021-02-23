import 'dart:convert';

ProviderBannerDeleteResponseModel providerBannerDeleteResponseModelFromJson(String str) => ProviderBannerDeleteResponseModel.fromJson(json.decode(str));

String providerBannerDeleteResponseModelToJson(ProviderBannerDeleteResponseModel data) => json.encode(data.toJson());

class ProviderBannerDeleteResponseModel {
    ProviderBannerDeleteResponseModel({
        this.status,
        this.message,
        this.data,
    });

    String status;
    String message;
    Data data;

    factory ProviderBannerDeleteResponseModel.fromJson(Map<String, dynamic> json) => ProviderBannerDeleteResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.userId,
        this.bannerImageUrl1,
        this.bannerImageUrl2,
        this.bannerImageUrl3,
        this.bannerImageUrl4,
        this.bannerImageUrl5,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int userId;
    dynamic bannerImageUrl1;
    dynamic bannerImageUrl2;
    dynamic bannerImageUrl3;
    String bannerImageUrl4;
    dynamic bannerImageUrl5;
    DateTime createdAt;
    DateTime updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["userId"],
        bannerImageUrl1: json["bannerImageUrl1"],
        bannerImageUrl2: json["bannerImageUrl2"],
        bannerImageUrl3: json["bannerImageUrl3"],
        bannerImageUrl4: json["bannerImageUrl4"],
        bannerImageUrl5: json["bannerImageUrl5"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bannerImageUrl1": bannerImageUrl1,
        "bannerImageUrl2": bannerImageUrl2,
        "bannerImageUrl3": bannerImageUrl3,
        "bannerImageUrl4": bannerImageUrl4,
        "bannerImageUrl5": bannerImageUrl5,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
