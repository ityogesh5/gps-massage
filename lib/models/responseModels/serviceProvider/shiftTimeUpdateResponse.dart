// To parse this JSON data, do
//
//     final shiftTimeUpdateResponse = shiftTimeUpdateResponseFromJson(jsonString);

import 'dart:convert';

ShiftTimeUpdateResponse shiftTimeUpdateResponseFromJson(String str) => ShiftTimeUpdateResponse.fromJson(json.decode(str));

String shiftTimeUpdateResponseToJson(ShiftTimeUpdateResponse data) => json.encode(data.toJson());

class ShiftTimeUpdateResponse {
    ShiftTimeUpdateResponse({
        this.status,
        this.data,
    });

    String status;
    Data data;

    factory ShiftTimeUpdateResponse.fromJson(Map<String, dynamic> json) => ShiftTimeUpdateResponse(
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
        this.id,
        this.userId,
        this.email,
        this.phoneNumber,
        this.fcmToken,
        this.lineBotUserId,
        this.appleUserId,
        this.userName,
        this.dob,
        this.age,
        this.gender,
        this.isTherapist,
        this.isVerified,
        this.isActive,
        this.isAccepted,
        this.rejectReason,
        this.updatedUser,
        this.uploadProfileImgUrl,
        this.proofOfIdentityType,
        this.proofOfIdentityImgUrl,
        this.qulaificationCertImgUrl,
        this.businessForm,
        this.numberOfEmp,
        this.businessTrip,
        this.coronaMeasure,
        this.storeName,
        this.storeType,
        this.storePhone,
        this.storeDescription,
        this.userOccupation,
        this.genderOfService,
        this.childrenMeasure,
        this.customerId,
        this.userSearchRadiusDistance,
        this.isShop,
        this.createdAt,
        this.updatedAt,
        this.storeServiceTimes,
    });

    int id;
    String userId;
    String email;
    int phoneNumber;
    dynamic fcmToken;
    dynamic lineBotUserId;
    dynamic appleUserId;
    String userName;
    DateTime dob;
    int age;
    String gender;
    bool isTherapist;
    bool isVerified;
    bool isActive;
    int isAccepted;
    dynamic rejectReason;
    dynamic updatedUser;
    dynamic uploadProfileImgUrl;
    String proofOfIdentityType;
    dynamic proofOfIdentityImgUrl;
    dynamic qulaificationCertImgUrl;
    String businessForm;
    int numberOfEmp;
    bool businessTrip;
    bool coronaMeasure;
    String storeName;
    String storeType;
    int storePhone;
    dynamic storeDescription;
    dynamic userOccupation;
    String genderOfService;
    String childrenMeasure;
    dynamic customerId;
    dynamic userSearchRadiusDistance;
    bool isShop;
    DateTime createdAt;
    DateTime updatedAt;
    List<StoreServiceTime> storeServiceTimes;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["userId"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        fcmToken: json["fcmToken"],
        lineBotUserId: json["lineBotUserId"],
        appleUserId: json["appleUserId"],
        userName: json["userName"],
        dob: DateTime.parse(json["dob"]),
        age: json["age"],
        gender: json["gender"],
        isTherapist: json["isTherapist"],
        isVerified: json["isVerified"],
        isActive: json["isActive"],
        isAccepted: json["isAccepted"],
        rejectReason: json["rejectReason"],
        updatedUser: json["updatedUser"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
        proofOfIdentityType: json["proofOfIdentityType"],
        proofOfIdentityImgUrl: json["proofOfIdentityImgUrl"],
        qulaificationCertImgUrl: json["qulaificationCertImgUrl"],
        businessForm: json["businessForm"],
        numberOfEmp: json["numberOfEmp"],
        businessTrip: json["businessTrip"],
        coronaMeasure: json["coronaMeasure"],
        storeName: json["storeName"],
        storeType: json["storeType"],
        storePhone: json["storePhone"],
        storeDescription: json["storeDescription"],
        userOccupation: json["userOccupation"],
        genderOfService: json["genderOfService"],
        childrenMeasure: json["childrenMeasure"],
        customerId: json["customerId"],
        userSearchRadiusDistance: json["userSearchRadiusDistance"],
        isShop: json["isShop"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        storeServiceTimes: List<StoreServiceTime>.from(json["storeServiceTimes"].map((x) => StoreServiceTime.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "email": email,
        "phoneNumber": phoneNumber,
        "fcmToken": fcmToken,
        "lineBotUserId": lineBotUserId,
        "appleUserId": appleUserId,
        "userName": userName,
        "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "age": age,
        "gender": gender,
        "isTherapist": isTherapist,
        "isVerified": isVerified,
        "isActive": isActive,
        "isAccepted": isAccepted,
        "rejectReason": rejectReason,
        "updatedUser": updatedUser,
        "uploadProfileImgUrl": uploadProfileImgUrl,
        "proofOfIdentityType": proofOfIdentityType,
        "proofOfIdentityImgUrl": proofOfIdentityImgUrl,
        "qulaificationCertImgUrl": qulaificationCertImgUrl,
        "businessForm": businessForm,
        "numberOfEmp": numberOfEmp,
        "businessTrip": businessTrip,
        "coronaMeasure": coronaMeasure,
        "storeName": storeName,
        "storeType": storeType,
        "storePhone": storePhone,
        "storeDescription": storeDescription,
        "userOccupation": userOccupation,
        "genderOfService": genderOfService,
        "childrenMeasure": childrenMeasure,
        "customerId": customerId,
        "userSearchRadiusDistance": userSearchRadiusDistance,
        "isShop": isShop,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "storeServiceTimes": List<dynamic>.from(storeServiceTimes.map((x) => x.toJson())),
    };
}

class StoreServiceTime {
    StoreServiceTime({
        this.id,
        this.userId,
        this.weekDay,
        this.dayInNumber,
        this.startTime,
        this.endTime,
        this.shopOpen,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int userId;
    String weekDay;
    int dayInNumber;
    DateTime startTime;
    DateTime endTime;
    bool shopOpen;
    DateTime createdAt;
    DateTime updatedAt;

    factory StoreServiceTime.fromJson(Map<String, dynamic> json) => StoreServiceTime(
        id: json["id"],
        userId: json["userId"],
        weekDay: json["weekDay"],
        dayInNumber: json["dayInNumber"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        shopOpen: json["shopOpen"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "weekDay": weekDay,
        "dayInNumber": dayInNumber,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "shopOpen": shopOpen,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
