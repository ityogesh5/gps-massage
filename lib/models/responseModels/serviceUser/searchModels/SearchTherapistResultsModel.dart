// To parse this JSON data, do
//
//     final searchTherapistResultsModel = searchTherapistResultsModelFromJson(jsonString);

import 'dart:convert';

SearchTherapistResultsModel searchTherapistResultsModelFromJson(String str) => SearchTherapistResultsModel.fromJson(json.decode(str));

String searchTherapistResultsModelToJson(SearchTherapistResultsModel data) => json.encode(data.toJson());

class SearchTherapistResultsModel {
  SearchTherapistResultsModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory SearchTherapistResultsModel.fromJson(Map<String, dynamic> json) => SearchTherapistResultsModel(
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
    this.searchList,
    this.totalPages,
    this.pageNumber,
  });

  int totalElements;
  List<SearchList> searchList;
  int totalPages;
  int pageNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalElements: json["totalElements"],
    searchList: List<SearchList>.from(json["searchList"].map((x) => SearchList.fromJson(x))),
    totalPages: json["totalPages"],
    pageNumber: json["pageNumber"],
  );

  Map<String, dynamic> toJson() => {
    "totalElements": totalElements,
    "searchList": List<dynamic>.from(searchList.map((x) => x.toJson())),
    "totalPages": totalPages,
    "pageNumber": pageNumber,
  };
}

class SearchList {
  SearchList({
    this.ratings,
    this.id,
    this.userId,
    this.categoryId,
    this.subCategoryId,
    this.name,
    this.sixtyMin,
    this.nintyMin,
    this.oneTwentyMin,
    this.oneFifityMin,
    this.oneEightyMin,
    this.user,
  });

  String ratings;
  int id;
  int userId;
  int categoryId;
  int subCategoryId;
  String name;
  int sixtyMin;
  int nintyMin;
  int oneTwentyMin;
  int oneFifityMin;
  int oneEightyMin;
  User user;

  factory SearchList.fromJson(Map<String, dynamic> json) => SearchList(
    ratings: json["ratings"],
    id: json["id"],
    userId: json["userId"],
    categoryId: json["categoryId"],
    subCategoryId: json["subCategoryId"],
    name: json["name"],
    sixtyMin: json["sixtyMin"],
    nintyMin: json["nintyMin"],
    oneTwentyMin: json["oneTwentyMin"],
    oneFifityMin: json["oneFifityMin"],
    oneEightyMin: json["oneEightyMin"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "ratings": ratings,
    "id": id,
    "userId": userId,
    "categoryId": categoryId,
    "subCategoryId": subCategoryId,
    "name": name,
    "sixtyMin": sixtyMin,
    "nintyMin": nintyMin,
    "oneTwentyMin": oneTwentyMin,
    "oneFifityMin": oneFifityMin,
    "oneEightyMin": oneEightyMin,
    "user": user.toJson(),
  };
}

class User {
  User({
    this.id,
    this.userName,
    this.uploadProfileImgUrl,
    this.addresses,
  });

  int id;
  String userName;
  dynamic uploadProfileImgUrl;
  List<Address> addresses;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userName: json["userName"],
    uploadProfileImgUrl: json["uploadProfileImgUrl"],
    addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "uploadProfileImgUrl": uploadProfileImgUrl,
    "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    this.id,
    this.lat,
    this.lon,
    this.geomet,
    this.distance,
  });

  int id;
  double lat;
  double lon;
  Geomet geomet;
  double distance;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    geomet: Geomet.fromJson(json["geomet"]),
    distance: json["distance"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lat": lat,
    "lon": lon,
    "geomet": geomet.toJson(),
    "distance": distance,
  };
}

class Geomet {
  Geomet({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geomet.fromJson(Map<String, dynamic> json) => Geomet(
    type: json["type"],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}
