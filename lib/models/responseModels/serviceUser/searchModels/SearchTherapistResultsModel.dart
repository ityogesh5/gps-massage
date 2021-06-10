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
        this.ratingAvg,
        this.noOfReviewsMembers,
        this.favouriteToTherapist,
        this.leastPriceMin,
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
        this.lowestPrice,
        this.numberOfTreatement,
        this.user,
    });

    String ratingAvg;
    int noOfReviewsMembers;
    int favouriteToTherapist;
    String leastPriceMin;
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
    int lowestPrice;
    int numberOfTreatement;
    User user;

    factory SearchList.fromJson(Map<String, dynamic> json) => SearchList(
        ratingAvg: json["ratingAvg"],
        noOfReviewsMembers: json["NoOfReviewsMembers"],
        favouriteToTherapist: json["favouriteToTherapist"],
        leastPriceMin: json["leastPriceMin"],
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
        lowestPrice: json["lowestPrice"],
        numberOfTreatement: json["numberOfTreatement"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "ratingAvg": ratingAvg,
        "NoOfReviewsMembers": noOfReviewsMembers,
        "favouriteToTherapist": favouriteToTherapist,
        "leastPriceMin": leastPriceMin,
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
        "lowestPrice": lowestPrice,
        "numberOfTreatement": numberOfTreatement,
        "user": user.toJson(),
    };
}

class User {
    User({
        this.id,
        this.userName,
        this.uploadProfileImgUrl,
        this.businessForm,
        this.storeName,
        this.storeType,
        this.coronameasure,
        this.businessTrip,
        this.childrenMeasure,
        this.genderOfService,
        this.qulaificationCertImgUrl,
        this.isShop,
        this.addresses,
        this.certificationUploads,
    });

    int id;
    String userName;
    String uploadProfileImgUrl;
    String businessForm;
    String storeName;
    String storeType;
    int coronameasure;
    bool businessTrip;
    String childrenMeasure;
    String genderOfService;
    String qulaificationCertImgUrl;
    bool isShop;
    List<Address> addresses;
    List<CertificationUpload> certificationUploads;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["userName"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
        businessForm: json["businessForm"],
        storeName: json["storeName"],
        storeType: json["storeType"],
        coronameasure: json["coronameasure"],
        businessTrip: json["businessTrip"],
        childrenMeasure: json["childrenMeasure"],
        genderOfService: json["genderOfService"],
        qulaificationCertImgUrl: json["qulaificationCertImgUrl"],
        isShop: json["isShop"],
        addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
        certificationUploads: List<CertificationUpload>.from(json["certification_uploads"].map((x) => CertificationUpload.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "uploadProfileImgUrl": uploadProfileImgUrl,
        "businessForm": businessForm,
        "storeName": storeName,
        "storeType": storeType,
        "coronameasure": coronameasure,
        "businessTrip": businessTrip,
        "childrenMeasure": childrenMeasure,
        "genderOfService": genderOfService,
        "qulaificationCertImgUrl": qulaificationCertImgUrl,
        "isShop": isShop,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "certification_uploads": List<dynamic>.from(certificationUploads.map((x) => x.toJson())),
    };
}

class Address {
    Address({
        this.id,
        this.lat,
        this.lon,
        this.geomet,
        this.address,
        this.capitalAndPrefecture,
        this.cityName,
        this.area,
        this.distance,
    });

    int id;
    double lat;
    double lon;
    Geomet geomet;
    String address;
    String capitalAndPrefecture;
    String cityName;
    String area;
    double distance;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        geomet: Geomet.fromJson(json["geomet"]),
        address: json["address"],
        capitalAndPrefecture: json["capitalAndPrefecture"],
        cityName: json["cityName"],
        area: json["area"],
        distance: json["distance"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lon": lon,
        "geomet": geomet.toJson(),
        "address": address,
        "capitalAndPrefecture": capitalAndPrefecture,
        "cityName": cityName,
        "area": area,
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
    });

    int id;
    int userId;
    String acupuncturist;
    dynamic moxibutionist;
    dynamic acupuncturistAndMoxibustion;
    dynamic anmaMassageShiatsushi;
    dynamic judoRehabilitationTeacher;
    dynamic physicalTherapist;
    dynamic acquireNationalQualifications;
    String privateQualification1;
    dynamic privateQualification2;
    dynamic privateQualification3;
    dynamic privateQualification4;
    dynamic privateQualification5;

    factory CertificationUpload.fromJson(Map<String, dynamic> json) => CertificationUpload(
        id: json["id"],
        userId: json["userId"],
        acupuncturist: json["acupuncturist"] == null ? null : json["acupuncturist"],
        moxibutionist: json["moxibutionist"],
        acupuncturistAndMoxibustion: json["acupuncturistAndMoxibustion"],
        anmaMassageShiatsushi: json["anmaMassageShiatsushi"],
        judoRehabilitationTeacher: json["judoRehabilitationTeacher"],
        physicalTherapist: json["physicalTherapist"],
        acquireNationalQualifications: json["acquireNationalQualifications"],
        privateQualification1: json["privateQualification1"] == null ? null : json["privateQualification1"],
        privateQualification2: json["privateQualification2"],
        privateQualification3: json["privateQualification3"],
        privateQualification4: json["privateQualification4"],
        privateQualification5: json["privateQualification5"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "acupuncturist": acupuncturist == null ? null : acupuncturist,
        "moxibutionist": moxibutionist,
        "acupuncturistAndMoxibustion": acupuncturistAndMoxibustion,
        "anmaMassageShiatsushi": anmaMassageShiatsushi,
        "judoRehabilitationTeacher": judoRehabilitationTeacher,
        "physicalTherapist": physicalTherapist,
        "acquireNationalQualifications": acquireNationalQualifications,
        "privateQualification1": privateQualification1 == null ? null : privateQualification1,
        "privateQualification2": privateQualification2,
        "privateQualification3": privateQualification3,
        "privateQualification4": privateQualification4,
        "privateQualification5": privateQualification5,
    };
}
