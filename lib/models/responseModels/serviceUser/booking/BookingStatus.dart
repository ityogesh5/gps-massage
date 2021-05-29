class BookingStatusModel {
  String status;
  Data data;

  BookingStatusModel({this.status, this.data});

  BookingStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int count;
  List<BookingDetailsList> bookingDetailsList;
  int totalPages;
  int pageNumber;

  Data({this.count, this.bookingDetailsList, this.totalPages, this.pageNumber});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['BookingDetailsList'] != null) {
      bookingDetailsList = new List<BookingDetailsList>();
      json['BookingDetailsList'].forEach((v) {
        bookingDetailsList.add(new BookingDetailsList.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    pageNumber = json['pageNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.bookingDetailsList != null) {
      data['BookingDetailsList'] =
          this.bookingDetailsList.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['pageNumber'] = this.pageNumber;
    return data;
  }
}

class BookingDetailsList {
  int favouriteToTherapist;
  int id;
  int userId;
  int therapistId;
  dynamic eventId;
  String startTime;
  String endTime;
  String monthOfBooking;
  String yearOfBooking;
  String newStartTime;
  String newEndTime;
  dynamic paymentId;
  int paymentStatus;
  dynamic paymentRefId;
  int subCategoryId;
  int categoryId;
  String nameOfService;
  int totalMinOfService;
  int priceOfService;
  String addedPrice;
  int bookingStatus;
  String statusUpdatedAt;
  int travelAmount;
  String locationType;
  String location;
  dynamic locationDistance;
  int totalCost;
  int userReviewStatus;
  dynamic therapistReviewStatus;
  String therapistComments;
  dynamic userComments;
  dynamic cancellationReason;
  dynamic cancellationFee;
  dynamic cancelledUserId;
  dynamic orderCompletion;
  String createdUser;
  String updatedUser;
  String createdAt;
  String updatedAt;
  BookingTherapistId bookingTherapistId;

  BookingDetailsList(
      {this.favouriteToTherapist,
      this.id,
      this.userId,
      this.therapistId,
      this.eventId,
      this.startTime,
      this.endTime,
      this.monthOfBooking,
      this.yearOfBooking,
      this.newStartTime,
      this.newEndTime,
      this.paymentId,
      this.paymentStatus,
      this.paymentRefId,
      this.subCategoryId,
      this.categoryId,
      this.nameOfService,
      this.totalMinOfService,
      this.priceOfService,
      this.addedPrice,
      this.bookingStatus,
      this.statusUpdatedAt,
      this.travelAmount,
      this.locationType,
      this.location,
      this.locationDistance,
      this.totalCost,
      this.userReviewStatus,
      this.therapistReviewStatus,
      this.therapistComments,
      this.userComments,
      this.cancellationReason,
      this.cancellationFee,
      this.cancelledUserId,
      this.orderCompletion,
      this.createdUser,
      this.updatedUser,
      this.createdAt,
      this.updatedAt,
      this.bookingTherapistId});

  BookingDetailsList.fromJson(Map<String, dynamic> json) {
    favouriteToTherapist = json['favouriteToTherapist'];
    id = json['id'];
    userId = json['userId'];
    therapistId = json['therapistId'];
    eventId = json['eventId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    monthOfBooking = json['monthOfBooking'];
    yearOfBooking = json['yearOfBooking'];
    newStartTime = json['newStartTime'];
    newEndTime = json['newEndTime'];
    paymentId = json['paymentId'];
    paymentStatus = json['paymentStatus'];
    paymentRefId = json['paymentRefId'];
    subCategoryId = json['subCategoryId'];
    categoryId = json['categoryId'];
    nameOfService = json['nameOfService'];
    totalMinOfService = json['totalMinOfService'];
    priceOfService = json['priceOfService'];
    addedPrice = json['addedPrice'];
    bookingStatus = json['bookingStatus'];
    statusUpdatedAt = json['statusUpdatedAt'];
    travelAmount = json['travelAmount'];
    locationType = json['locationType'];
    location = json['location'];
    locationDistance = json['locationDistance'];
    totalCost = json['totalCost'];
    userReviewStatus = json['userReviewStatus'];
    therapistReviewStatus = json['therapistReviewStatus'];
    therapistComments = json['therapistComments'];
    userComments = json['userComments'];
    cancellationReason = json['cancellationReason'];
    cancellationFee = json['cancellationFee'];
    cancelledUserId = json['cancelledUserId'];
    orderCompletion = json['orderCompletion'];
    createdUser = json['createdUser'];
    updatedUser = json['updatedUser'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    bookingTherapistId = json['bookingTherapistId'] != null
        ? new BookingTherapistId.fromJson(json['bookingTherapistId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favouriteToTherapist'] = this.favouriteToTherapist;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['therapistId'] = this.therapistId;
    data['eventId'] = this.eventId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['monthOfBooking'] = this.monthOfBooking;
    data['yearOfBooking'] = this.yearOfBooking;
    data['newStartTime'] = this.newStartTime;
    data['newEndTime'] = this.newEndTime;
    data['paymentId'] = this.paymentId;
    data['paymentStatus'] = this.paymentStatus;
    data['paymentRefId'] = this.paymentRefId;
    data['subCategoryId'] = this.subCategoryId;
    data['categoryId'] = this.categoryId;
    data['nameOfService'] = this.nameOfService;
    data['totalMinOfService'] = this.totalMinOfService;
    data['priceOfService'] = this.priceOfService;
    data['addedPrice'] = this.addedPrice;
    data['bookingStatus'] = this.bookingStatus;
    data['statusUpdatedAt'] = this.statusUpdatedAt;
    data['travelAmount'] = this.travelAmount;
    data['locationType'] = this.locationType;
    data['location'] = this.location;
    data['locationDistance'] = this.locationDistance;
    data['totalCost'] = this.totalCost;
    data['userReviewStatus'] = this.userReviewStatus;
    data['therapistReviewStatus'] = this.therapistReviewStatus;
    data['therapistComments'] = this.therapistComments;
    data['userComments'] = this.userComments;
    data['cancellationReason'] = this.cancellationReason;
    data['cancellationFee'] = this.cancellationFee;
    data['cancelledUserId'] = this.cancelledUserId;
    data['orderCompletion'] = this.orderCompletion;
    data['createdUser'] = this.createdUser;
    data['updatedUser'] = this.updatedUser;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.bookingTherapistId != null) {
      data['bookingTherapistId'] = this.bookingTherapistId.toJson();
    }
    return data;
  }
}

class BookingTherapistId {
  int id;
  String userId;
  String userName;
  String uploadProfileImgUrl;
  String businessForm;
  bool businessTrip;
  bool coronaMeasure;
  String storeName;
  String storeType;
  bool isShop;
  String qulaificationCertImgUrl;
  List<CertificationUploads> certificationUploads;

  BookingTherapistId(
      {this.id,
      this.userId,
      this.userName,
      this.uploadProfileImgUrl,
      this.businessForm,
      this.businessTrip,
      this.coronaMeasure,
      this.storeName,
      this.storeType,
      this.isShop,
      this.qulaificationCertImgUrl,
      this.certificationUploads});

  BookingTherapistId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userName = json['userName'];
    uploadProfileImgUrl = json['uploadProfileImgUrl'];
    businessForm = json['businessForm'];
    businessTrip = json['businessTrip'];
    coronaMeasure = json['coronaMeasure'];
    storeName = json['storeName'];
    storeType = json['storeType'];
    isShop = json['isShop'];
    qulaificationCertImgUrl = json['qulaificationCertImgUrl'];
    if (json['certification_uploads'] != null) {
      certificationUploads = new List<CertificationUploads>();
      json['certification_uploads'].forEach((v) {
        certificationUploads.add(new CertificationUploads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['uploadProfileImgUrl'] = this.uploadProfileImgUrl;
    data['businessForm'] = this.businessForm;
    data['businessTrip'] = this.businessTrip;
    data['coronaMeasure'] = this.coronaMeasure;
    data['storeName'] = this.storeName;
    data['storeType'] = this.storeType;
    data['isShop'] = this.isShop;
    data['qulaificationCertImgUrl'] = this.qulaificationCertImgUrl;
    if (this.certificationUploads != null) {
      data['certification_uploads'] =
          this.certificationUploads.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CertificationUploads {
  int id;
  int userId;
  dynamic acupuncturist;
  String moxibutionist;
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
  String createdAt;
  String updatedAt;

  CertificationUploads(
      {this.id,
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
      this.updatedAt});

  CertificationUploads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    acupuncturist = json['acupuncturist'];
    moxibutionist = json['moxibutionist'];
    acupuncturistAndMoxibustion = json['acupuncturistAndMoxibustion'];
    anmaMassageShiatsushi = json['anmaMassageShiatsushi'];
    judoRehabilitationTeacher = json['judoRehabilitationTeacher'];
    physicalTherapist = json['physicalTherapist'];
    acquireNationalQualifications = json['acquireNationalQualifications'];
    privateQualification1 = json['privateQualification1'];
    privateQualification2 = json['privateQualification2'];
    privateQualification3 = json['privateQualification3'];
    privateQualification4 = json['privateQualification4'];
    privateQualification5 = json['privateQualification5'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['acupuncturist'] = this.acupuncturist;
    data['moxibutionist'] = this.moxibutionist;
    data['acupuncturistAndMoxibustion'] = this.acupuncturistAndMoxibustion;
    data['anmaMassageShiatsushi'] = this.anmaMassageShiatsushi;
    data['judoRehabilitationTeacher'] = this.judoRehabilitationTeacher;
    data['physicalTherapist'] = this.physicalTherapist;
    data['acquireNationalQualifications'] = this.acquireNationalQualifications;
    data['privateQualification1'] = this.privateQualification1;
    data['privateQualification2'] = this.privateQualification2;
    data['privateQualification3'] = this.privateQualification3;
    data['privateQualification4'] = this.privateQualification4;
    data['privateQualification5'] = this.privateQualification5;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
