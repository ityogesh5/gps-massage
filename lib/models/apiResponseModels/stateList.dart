class StatesList {
  String status;
  List<PrefectureJpData> prefectureJpData;

  StatesList({this.status, this.prefectureJpData});

  StatesList.fromJson(Map<String, dynamic> json) {
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

  PrefectureJpData(
      {this.id, this.prefectureId, this.prefectureEn, this.prefectureJa});

  PrefectureJpData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prefectureId = json['prefecture_id'];
    prefectureEn = json['prefecture_en'];
    prefectureJa = json['prefecture_ja'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prefecture_id'] = this.prefectureId;
    data['prefecture_en'] = this.prefectureEn;
    data['prefecture_ja'] = this.prefectureJa;
    return data;
  }
}
