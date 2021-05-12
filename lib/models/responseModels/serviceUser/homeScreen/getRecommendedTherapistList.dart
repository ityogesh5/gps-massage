// To parse this JSON data, do
//
// final recommendList = recommendListFromJson(jsonString);

import 'dart:convert';

RecommendList recommendListFromJson(String str) =>
    RecommendList.fromJson(json.decode(str));

String recommendListToJson(RecommendList data) => json.encode(data.toJson());

class RecommendList {
  RecommendList({
    this.status,
    this.homeTherapistData,
  });

  String status;
  HomeTherapistData homeTherapistData;

  factory RecommendList.fromJson(Map<String, dynamic> json) => RecommendList(
        status: json["status"],
        homeTherapistData:
            HomeTherapistData.fromJson(json["homeTherapistData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "homeTherapistData": homeTherapistData.toJson(),
      };
}

class HomeTherapistData {
  HomeTherapistData({
    this.count,
    this.rows,
  });

  int count;
  List<Row> rows;

  factory HomeTherapistData.fromJson(Map<String, dynamic> json) =>
      HomeTherapistData(
        count: json["count"],
        rows: List<Row>.from(json["rows"].map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class Row {
  Row({
    this.id,
    this.userId,
    this.categoryId,
    this.subCategoryId,
    this.name,
    this.user,
    this.reviewAvgData,
    this.lowestPrice,
    this.priceForMinute,
  });

  int id;
  int userId;
  int categoryId;
  int subCategoryId;
  String name;
  User user;
  String reviewAvgData;
  int lowestPrice;
  String priceForMinute;

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json["id"],
        userId: json["userId"],
        categoryId: json["categoryId"],
        subCategoryId: json["subCategoryId"],
        name: json["name"],
        user: User.fromJson(json["user"]),
        reviewAvgData: json["reviewAvgData"],
        lowestPrice: json["lowestPrice"],
        priceForMinute: json["priceForMinute"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "name": name,
        "user": user.toJson(),
        "reviewAvgData": reviewAvgData,
        "lowestPrice": lowestPrice,
        "priceForMinute": priceForMinute,
      };
}

class User {
  User({
    this.id,
    this.userId,
    this.userName,
    this.uploadProfileImgUrl,
    this.storeType,
    this.qulaificationCertImgUrl,
    this.businessForm,
    this.childrenMeasure,
    this.coronaMeasure,
    this.businessTrip,
    this.addresses,
    this.certificationUploads,
    this.banners,
  });

  int id;
  String userId;
  String userName;
  dynamic uploadProfileImgUrl;
  String storeType;
  dynamic qulaificationCertImgUrl;
  String businessForm;
  String childrenMeasure;
  bool coronaMeasure;
  bool businessTrip;
  List<Address> addresses;
  List<CertificationUpload> certificationUploads;
  List<Banner> banners;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userId: json["userId"],
        userName: json["userName"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
        storeType: json["storeType"],
        qulaificationCertImgUrl: json["qulaificationCertImgUrl"],
        businessForm: json["businessForm"],
        childrenMeasure: json["childrenMeasure"],
        coronaMeasure: json["coronaMeasure"],
        businessTrip: json["businessTrip"],
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
        certificationUploads: List<CertificationUpload>.from(
            json["certification_uploads"]
                .map((x) => CertificationUpload.fromJson(x))),
        banners:
            List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userName": userName,
        "uploadProfileImgUrl": uploadProfileImgUrl,
        "storeType": storeType,
        "qulaificationCertImgUrl": qulaificationCertImgUrl,
        "businessForm": businessForm,
        "childrenMeasure": childrenMeasure,
        "coronaMeasure": coronaMeasure,
        "businessTrip": businessTrip,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "certification_uploads":
            List<dynamic>.from(certificationUploads.map((x) => x.toJson())),
        "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.id,
    this.lat,
    this.lon,
    this.geomet,
    this.address,
    this.distance,
  });

  int id;
  double lat;
  double lon;
  Geomet geomet;
  String address;
  int distance;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        geomet: Geomet.fromJson(json["geomet"]),
        address: json["address"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lon": lon,
        "geomet": geomet.toJson(),
        "address": address,
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
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Banner {
  Banner({
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
  dynamic bannerImageUrl4;
  dynamic bannerImageUrl5;
  DateTime createdAt;
  DateTime updatedAt;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
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

class CertificationUpload {
  CertificationUpload({
    this.id,
    this.userId,
    this.acupuncturist,
    this.moxibutionist,
    this.acupuncturistAndMoxibustion,
    this.anmaMassageShiatsushi,
    this.judoRehabilitationTeacher,
    this.physicalTherapist,
    this.acquireNationalQualifications,
    this.privateQualification1,
    this.privateQualification2,
    this.privateQualification3,
    this.privateQualification4,
    this.privateQualification5,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  dynamic acupuncturist;
  dynamic moxibutionist;
  dynamic acupuncturistAndMoxibustion;
  dynamic anmaMassageShiatsushi;
  dynamic judoRehabilitationTeacher;
  dynamic physicalTherapist;
  dynamic acquireNationalQualifications;
  dynamic privateQualification1;
  dynamic privateQualification2;
  dynamic privateQualification3;
  dynamic privateQualification4;
  dynamic privateQualification5;
  DateTime createdAt;
  DateTime updatedAt;

  factory CertificationUpload.fromJson(Map<String, dynamic> json) =>
      CertificationUpload(
        id: json["id"],
        userId: json["userId"],
        acupuncturist: json["acupuncturist"],
        moxibutionist: json["moxibutionist"],
        acupuncturistAndMoxibustion: json["acupuncturistAndMoxibustion"],
        anmaMassageShiatsushi: json["anmaMassageShiatsushi"],
        judoRehabilitationTeacher: json["judoRehabilitationTeacher"],
        physicalTherapist: json["physicalTherapist"],
        acquireNationalQualifications: json["acquireNationalQualifications"],
        privateQualification1: json["privateQualification1"],
        privateQualification2: json["privateQualification2"],
        privateQualification3: json["privateQualification3"],
        privateQualification4: json["privateQualification4"],
        privateQualification5: json["privateQualification5"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "acupuncturist": acupuncturist,
        "moxibutionist": moxibutionist,
        "acupuncturistAndMoxibustion": acupuncturistAndMoxibustion,
        "anmaMassageShiatsushi": anmaMassageShiatsushi,
        "judoRehabilitationTeacher": judoRehabilitationTeacher,
        "physicalTherapist": physicalTherapist,
        "acquireNationalQualifications": acquireNationalQualifications,
        "privateQualification1": privateQualification1,
        "privateQualification2": privateQualification2,
        "privateQualification3": privateQualification3,
        "privateQualification4": privateQualification4,
        "privateQualification5": privateQualification5,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
