// To parse this JSON data, do
//
//     final searchTherapistResultsModel = searchTherapistResultsModelFromJson(jsonString);

import 'dart:convert';

SearchTherapistResultsModel searchTherapistResultsModelFromJson(String str) =>
    SearchTherapistResultsModel.fromJson(json.decode(str));

String searchTherapistResultsModelToJson(SearchTherapistResultsModel data) =>
    json.encode(data.toJson());

class SearchTherapistResultsModel {
  SearchTherapistResultsModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory SearchTherapistResultsModel.fromJson(Map<String, dynamic> json) =>
      SearchTherapistResultsModel(
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
        searchList: List<SearchList>.from(
            json["searchList"].map((x) => SearchList.fromJson(x))),
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
    this.favoriteId,
    this.favoriteTherapistId,
    this.favoriteUserId,
    this.favouriteToTherapist,
    this.rating,
    this.noOfReviewsMembers,
  });

  int id;
  String userId;
  String userName;
  String uploadProfileImgUrl;
  String businessForm;
  String storeName;
  String storeType;
  int coronameasure;
  int businesstrip;
  String childrenMeasure;
  String genderOfService;
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
  String addressTypeSelection;
  String address;
  double lat;
  double lon;
  Geomet geomet;
  String capitalAndPrefecture;
  int citiesId;
  String cityName;
  String area;
  double distance;
  int numberOfTreatement;
  int certificateId;
  dynamic acquireNationalQualifications;
  String acupuncturist;
  dynamic moxibutionist;
  dynamic anmaMassageShiatsushi;
  dynamic judoRehabilitationTeacher;
  String physicalTherapist;
  dynamic acupuncturistAndMoxibustion;
  dynamic privateQualification1;
  dynamic privateQualification2;
  dynamic privateQualification3;
  dynamic privateQualification4;
  dynamic privateQualification5;
  int favoriteId;
  int favoriteTherapistId;
  int favoriteUserId;
  int favouriteToTherapist;
  String rating;
  int noOfReviewsMembers;

  factory SearchList.fromJson(Map<String, dynamic> json) => SearchList(
        id: json["id"],
        userId: json["userId"],
        userName: json["userName"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
        businessForm: json["businessForm"],
        storeName: json["storeName"],
        storeType: json["storeType"],
        coronameasure: json["coronameasure"],
        businesstrip: json["businesstrip"],
        childrenMeasure: json["childrenMeasure"],
        genderOfService: json["genderOfService"],
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
        addressTypeSelection: json["addressTypeSelection"],
        address: json["address"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        geomet: Geomet.fromJson(json["geomet"]),
        capitalAndPrefecture: json["capitalAndPrefecture"],
        citiesId: json["citiesId"],
        cityName: json["cityName"],
        area: json["area"],
        distance: json["distance"].toDouble(),
        numberOfTreatement: json["numberOfTreatement"],
        certificateId: json["certificateId"],
        acquireNationalQualifications: json["acquireNationalQualifications"],
        acupuncturist:
            json["acupuncturist"] == null ? null : json["acupuncturist"],
        moxibutionist: json["moxibutionist"],
        anmaMassageShiatsushi: json["anmaMassageShiatsushi"],
        judoRehabilitationTeacher: json["judoRehabilitationTeacher"],
        physicalTherapist: json["physicalTherapist"] == null
            ? null
            : json["physicalTherapist"],
        acupuncturistAndMoxibustion: json["acupuncturistAndMoxibustion"],
        privateQualification1: json["privateQualification1"],
        privateQualification2: json["privateQualification2"],
        privateQualification3: json["privateQualification3"],
        privateQualification4: json["privateQualification4"],
        privateQualification5: json["privateQualification5"],
        favoriteId: json["favoriteId"] == null ? null : json["favoriteId"],
        favoriteTherapistId: json["favoriteTherapistId"] == null
            ? null
            : json["favoriteTherapistId"],
        favoriteUserId:
            json["favoriteUserId"] == null ? null : json["favoriteUserId"],
        favouriteToTherapist: json["favouriteToTherapist"],
        rating: json["rating"],
        noOfReviewsMembers: json["NoOfReviewsMembers"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userName": userName,
        "uploadProfileImgUrl": uploadProfileImgUrl,
        "businessForm": businessForm,
        "storeName": storeName,
        "storeType": storeType,
        "coronameasure": coronameasure,
        "businesstrip": businesstrip,
        "childrenMeasure": childrenMeasure,
        "genderOfService": genderOfService,
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
        "addressTypeSelection": addressTypeSelection,
        "address": address,
        "lat": lat,
        "lon": lon,
        "geomet": geomet.toJson(),
        "capitalAndPrefecture": capitalAndPrefecture,
        "citiesId": citiesId,
        "cityName": cityName,
        "area": area,
        "distance": distance,
        "numberOfTreatement": numberOfTreatement,
        "certificateId": certificateId,
        "acquireNationalQualifications": acquireNationalQualifications,
        "acupuncturist": acupuncturist == null ? null : acupuncturist,
        "moxibutionist": moxibutionist,
        "anmaMassageShiatsushi": anmaMassageShiatsushi,
        "judoRehabilitationTeacher": judoRehabilitationTeacher,
        "physicalTherapist":
            physicalTherapist == null ? null : physicalTherapist,
        "acupuncturistAndMoxibustion": acupuncturistAndMoxibustion,
        "privateQualification1": privateQualification1,
        "privateQualification2": privateQualification2,
        "privateQualification3": privateQualification3,
        "privateQualification4": privateQualification4,
        "privateQualification5": privateQualification5,
        "favoriteId": favoriteId == null ? null : favoriteId,
        "favoriteTherapistId":
            favoriteTherapistId == null ? null : favoriteTherapistId,
        "favoriteUserId": favoriteUserId == null ? null : favoriteUserId,
        "favouriteToTherapist": favouriteToTherapist,
        "rating": rating,
        "NoOfReviewsMembers": noOfReviewsMembers,
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
