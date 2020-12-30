class StatesListResponseModel {
  String status;
  List<PrefectureJpData> prefectureJpData;

  StatesListResponseModel({this.status, this.prefectureJpData});

  StatesListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['prefectureJpData'] != null) {
      prefectureJpData = new List<PrefectureJpData>();
      json['prefectureJpData'].forEach((v) {
        prefectureJpData.add(new PrefectureJpData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.prefectureJpData != null) {
      data['prefectureJpData'] =
          this.prefectureJpData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrefectureJpData {
  int id;
  int prefectureId;
  String prefectureEn;
  String prefectureJa;
  Null createdAt;
  Null updatedAt;

  PrefectureJpData(
      {this.id,
        this.prefectureId,
        this.prefectureEn,
        this.prefectureJa,
        this.createdAt,
        this.updatedAt});

  PrefectureJpData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prefectureId = json['prefecture_id'];
    prefectureEn = json['prefecture_en'];
    prefectureJa = json['prefecture_ja'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prefecture_id'] = this.prefectureId;
    data['prefecture_en'] = this.prefectureEn;
    data['prefecture_ja'] = this.prefectureJa;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
