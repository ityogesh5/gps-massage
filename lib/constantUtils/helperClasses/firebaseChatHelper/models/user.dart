// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) =>
    UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  UserDetail({
    this.id,
    this.serverId,
    this.isTherapist,
    this.contacts,
    this.email,
    this.imageUrl,
    this.username,
    this.isOnline,
    this.isTyping,
    this.searchKey,
  });

  String id;
  int serverId;
  int isTherapist;
  List<String> contacts;
  String email;
  String imageUrl;
  String username;
  bool isOnline;
  bool isTyping;
  String searchKey;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        serverId: json["serverId"],
        isTherapist: json["isTherapist"],
        contacts: List<String>.from(json["contacts"].map((x) => x)),
        email: json["email"],
        imageUrl: json["imageUrl"],
        username: json["username"],
        isOnline: json["isOnline"],
        isTyping: json["isTyping"],
        searchKey: json["searchKey"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serverId": serverId,
        "isTherapist": isTherapist,
        "contacts": List<dynamic>.from(contacts.map((x) => x)),
        "email": email,
        "imageUrl": imageUrl,
        "username": username,
        "isOnline": isOnline,
        "isTyping": isTyping,
        "searchKey": searchKey,
      };
}
