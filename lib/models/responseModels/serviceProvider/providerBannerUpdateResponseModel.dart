
import 'dart:convert';

ProviderBannerUpdateResponseModel providerBannerUpdateResponseModelFromJson(String str) => ProviderBannerUpdateResponseModel.fromJson(json.decode(str));

String providerBannerUpdateResponseModelToJson(ProviderBannerUpdateResponseModel data) => json.encode(data.toJson());

class ProviderBannerUpdateResponseModel {
    ProviderBannerUpdateResponseModel({
        this.status,
        this.message,
    });

    String status;
    Message message;

    factory ProviderBannerUpdateResponseModel.fromJson(Map<String, dynamic> json) => ProviderBannerUpdateResponseModel(
        status: json["status"],
        message: Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
    };
}

class Message {
    Message({
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
    String bannerImageUrl1;
    String bannerImageUrl2;
    String bannerImageUrl3;
    String bannerImageUrl4;
    String bannerImageUrl5;
    DateTime createdAt;
    DateTime updatedAt;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
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
