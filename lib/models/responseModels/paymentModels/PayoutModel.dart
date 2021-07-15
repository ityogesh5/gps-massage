// To parse this JSON data, do
//
//     final stripePayOutVerifyFieldsModel = stripePayOutVerifyFieldsModelFromJson(jsonString);

import 'dart:convert';

StripePayOutVerifyFieldsModel stripePayOutVerifyFieldsModelFromJson(
        String str) =>
    StripePayOutVerifyFieldsModel.fromJson(json.decode(str));

String stripePayOutVerifyFieldsModelToJson(
        StripePayOutVerifyFieldsModel data) =>
    json.encode(data.toJson());

class StripePayOutVerifyFieldsModel {
  StripePayOutVerifyFieldsModel({
    this.status,
    this.message,
  });

  String status;
  Message message;

  factory StripePayOutVerifyFieldsModel.fromJson(Map<String, dynamic> json) =>
      StripePayOutVerifyFieldsModel(
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
    this.object,
    this.created,
    this.expiresAt,
    this.url,
  });

  dynamic object;
  dynamic created;
  dynamic expiresAt;
  dynamic url;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        object: json["object"],
        created: json["created"],
        expiresAt: json["expires_at"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "created": created,
        "expires_at": expiresAt,
        "url": url,
      };
}
