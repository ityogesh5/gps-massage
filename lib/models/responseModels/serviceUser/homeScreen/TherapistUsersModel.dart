// To parse this JSON data, do
//
//     final therapistUsersModel = therapistUsersModelFromJson(jsonString);

import 'dart:convert';

TherapistUsersModel therapistUsersModelFromJson(String str) =>
    TherapistUsersModel.fromJson(json.decode(str));

String therapistUsersModelToJson(TherapistUsersModel data) =>
    json.encode(data.toJson());

class TherapistUsersModel {
  TherapistUsersModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory TherapistUsersModel.fromJson(Map<String, dynamic> json) =>
      TherapistUsersModel(
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
    this.count,
    this.userList,
    this.totalPages,
    this.pageNumber,
  });

  int count;
  List<UserList> userList;
  int totalPages;
  int pageNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        userList: List<UserList>.from(
            json["userList"].map((x) => UserList.fromJson(x))),
        totalPages: json["totalPages"],
        pageNumber: json["pageNumber"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "userList": List<dynamic>.from(userList.map((x) => x.toJson())),
        "totalPages": totalPages,
        "pageNumber": pageNumber,
      };
}

class UserList {
  UserList({
    this.favouriteToTherapist,
    this.id,
    this.userId,
    this.userName,
    this.uploadProfileImgUrl,
    this.businessForm,
    this.storeName,
    this.storeType,
    this.coronameasure,
    this.businesstrip,
    this.childrenMeasure,
    this.genderOfService,
    this.qulaificationCertImgUrl,
    this.isShop,
    this.isTherapist,
    this.isActive,
    this.isAccepted,
    this.therapistSubCatId,
    this.categoryId,
    this.subCategoryId,
    this.name,
    this.sixtyMin,
    this.nintyMin,
    this.oneTwentyMin,
    this.oneFifityMin,
    this.oneEightyMin,
    this.lowestPrice,
    this.leastPriceMin,
    this.addressId,
    this.addressTypeSelection,
    this.address,
    this.lat,
    this.lon,
    this.geomet,
    this.capitalAndPrefecture,
    this.citiesId,
    this.cityName,
    this.area,
    this.distance,
    this.numberOfTreatement,
    this.certificateId,
    this.acquireNationalQualifications,
    this.acupuncturist,
    this.moxibutionist,
    this.anmaMassageShiatsushi,
    this.judoRehabilitationTeacher,
    this.physicalTherapist,
    this.acupuncturistAndMoxibustion,
    this.privateQualification1,
    this.privateQualification2,
    this.privateQualification3,
    this.privateQualification4,
    this.privateQualification5,
    this.rating,
    this.noOfReviewsMembers,
  });

  int favouriteToTherapist;
  int id;
  String userId;
  String userName;
  String uploadProfileImgUrl;
  String businessForm;
  String storeName;
  String storeType;
  int coronameasure;
  int businesstrip;
  ChildrenMeasure childrenMeasure;
  GenderOfService genderOfService;
  String qulaificationCertImgUrl;
  int isShop;
  int isTherapist;
  int isActive;
  int isAccepted;
  int therapistSubCatId;
  int categoryId;
  int subCategoryId;
  String name;
  int sixtyMin;
  int nintyMin;
  int oneTwentyMin;
  int oneFifityMin;
  int oneEightyMin;
  int lowestPrice;
  String leastPriceMin;
  int addressId;
  AddressTypeSelection addressTypeSelection;
  String address;
  double lat;
  double lon;
  Geomet geomet;
  CapitalAndPrefecture capitalAndPrefecture;
  int citiesId;
  String cityName;
  String area;
  double distance;
  int numberOfTreatement;
  int certificateId;
  String acquireNationalQualifications;
  String acupuncturist;
  dynamic moxibutionist;
  dynamic anmaMassageShiatsushi;
  String judoRehabilitationTeacher;
  String physicalTherapist;
  dynamic acupuncturistAndMoxibustion;
  String privateQualification1;
  dynamic privateQualification2;
  dynamic privateQualification3;
  dynamic privateQualification4;
  dynamic privateQualification5;
  String rating;
  int noOfReviewsMembers;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        favouriteToTherapist: json["favouriteToTherapist"],
        id: json["id"],
        userId: json["userId"],
        userName: json["userName"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
        businessForm: json["businessForm"],
        storeName: json["storeName"],
        storeType: json["storeType"],
        coronameasure: json["coronameasure"],
        businesstrip: json["businesstrip"],
        childrenMeasure: childrenMeasureValues.map[json["childrenMeasure"]],
        genderOfService: genderOfServiceValues.map[json["genderOfService"]],
        qulaificationCertImgUrl: json["qulaificationCertImgUrl"],
        isShop: json["isShop"],
        isTherapist: json["isTherapist"],
        isActive: json["isActive"],
        isAccepted: json["isAccepted"],
        therapistSubCatId: json["therapistSubCatId"],
        categoryId: json["categoryId"],
        subCategoryId: json["subCategoryId"],
        name: json["name"],
        sixtyMin: json["sixtyMin"],
        nintyMin: json["nintyMin"],
        oneTwentyMin: json["oneTwentyMin"],
        oneFifityMin: json["oneFifityMin"],
        oneEightyMin: json["oneEightyMin"],
        lowestPrice: json["lowestPrice"],
        leastPriceMin: json["leastPriceMin"],
        addressId: json["addressId"],
        addressTypeSelection:
            addressTypeSelectionValues.map[json["addressTypeSelection"]],
        address: json["address"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        geomet: Geomet.fromJson(json["geomet"]),
        capitalAndPrefecture:
            capitalAndPrefectureValues.map[json["capitalAndPrefecture"]],
        citiesId: json["citiesId"],
        cityName: json["cityName"],
        area: json["area"],
        distance: json["distance"].toDouble(),
        numberOfTreatement: json["numberOfTreatement"],
        certificateId: json["certificateId"],
        acquireNationalQualifications:
            json["acquireNationalQualifications"] == null
                ? null
                : json["acquireNationalQualifications"],
        acupuncturist:
            json["acupuncturist"] == null ? null : json["acupuncturist"],
        moxibutionist: json["moxibutionist"],
        anmaMassageShiatsushi: json["anmaMassageShiatsushi"],
        judoRehabilitationTeacher: json["judoRehabilitationTeacher"] == null
            ? null
            : json["judoRehabilitationTeacher"],
        physicalTherapist: json["physicalTherapist"] == null
            ? null
            : json["physicalTherapist"],
        acupuncturistAndMoxibustion: json["acupuncturistAndMoxibustion"],
        privateQualification1: json["privateQualification1"] == null
            ? null
            : json["privateQualification1"],
        privateQualification2: json["privateQualification2"],
        privateQualification3: json["privateQualification3"],
        privateQualification4: json["privateQualification4"],
        privateQualification5: json["privateQualification5"],
        rating: json["rating"],
        noOfReviewsMembers: json["NoOfReviewsMembers"],
      );

  Map<String, dynamic> toJson() => {
        "favouriteToTherapist": favouriteToTherapist,
        "id": id,
        "userId": userId,
        "userName": userName,
        "uploadProfileImgUrl": uploadProfileImgUrl,
        "businessForm": businessForm,
        "storeName": storeName,
        "storeType": storeType,
        "coronameasure": coronameasure,
        "businesstrip": businesstrip,
        "childrenMeasure": childrenMeasureValues.reverse[childrenMeasure],
        "genderOfService": genderOfServiceValues.reverse[genderOfService],
        "qulaificationCertImgUrl": qulaificationCertImgUrl,
        "isShop": isShop,
        "isTherapist": isTherapist,
        "isActive": isActive,
        "isAccepted": isAccepted,
        "therapistSubCatId": therapistSubCatId,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "name": name,
        "sixtyMin": sixtyMin,
        "nintyMin": nintyMin,
        "oneTwentyMin": oneTwentyMin,
        "oneFifityMin": oneFifityMin,
        "oneEightyMin": oneEightyMin,
        "lowestPrice": lowestPrice,
        "leastPriceMin": leastPriceMin,
        "addressId": addressId,
        "addressTypeSelection":
            addressTypeSelectionValues.reverse[addressTypeSelection],
        "address": address,
        "lat": lat,
        "lon": lon,
        "geomet": geomet.toJson(),
        "capitalAndPrefecture":
            capitalAndPrefectureValues.reverse[capitalAndPrefecture],
        "citiesId": citiesId,
        "cityName": cityName,
        "area": area,
        "distance": distance,
        "numberOfTreatement": numberOfTreatement,
        "certificateId": certificateId,
        "acquireNationalQualifications": acquireNationalQualifications == null
            ? null
            : acquireNationalQualifications,
        "acupuncturist": acupuncturist == null ? null : acupuncturist,
        "moxibutionist": moxibutionist,
        "anmaMassageShiatsushi": anmaMassageShiatsushi,
        "judoRehabilitationTeacher": judoRehabilitationTeacher == null
            ? null
            : judoRehabilitationTeacher,
        "physicalTherapist":
            physicalTherapist == null ? null : physicalTherapist,
        "acupuncturistAndMoxibustion": acupuncturistAndMoxibustion,
        "privateQualification1":
            privateQualification1 == null ? null : privateQualification1,
        "privateQualification2": privateQualification2,
        "privateQualification3": privateQualification3,
        "privateQualification4": privateQualification4,
        "privateQualification5": privateQualification5,
        "rating": rating,
        "NoOfReviewsMembers": noOfReviewsMembers,
      };
}

enum AddressTypeSelection { EMPTY }

final addressTypeSelectionValues =
    EnumValues({"直接入力": AddressTypeSelection.EMPTY});

enum CapitalAndPrefecture { EMPTY }

final capitalAndPrefectureValues =
    EnumValues({"北海道": CapitalAndPrefecture.EMPTY});

enum ChildrenMeasure { EMPTY, CHILDREN_MEASURE, OK }

final childrenMeasureValues = EnumValues({
  "キッズスペースの完備": ChildrenMeasure.CHILDREN_MEASURE,
  "": ChildrenMeasure.EMPTY,
  "キッズスペースの完備,子供同伴OK": ChildrenMeasure.OK
});

enum GenderOfService { EMPTY, GENDER_OF_SERVICE, PURPLE }

final genderOfServiceValues = EnumValues({
  "": GenderOfService.EMPTY,
  "男性女性両方": GenderOfService.GENDER_OF_SERVICE,
  "女性のみ": GenderOfService.PURPLE
});

class Geomet {
  Geomet({
    this.type,
    this.coordinates,
  });

  Type type;
  List<double> coordinates;

  factory Geomet.fromJson(Map<String, dynamic> json) => Geomet(
        type: typeValues.map[json["type"]],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

enum Type { POINT }

final typeValues = EnumValues({"Point": Type.POINT});

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
