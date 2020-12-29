class TreatmentDropDownModel {
  String status;
  List<OsteopathicData> osteopathicData;

  TreatmentDropDownModel({this.status, this.osteopathicData});

  TreatmentDropDownModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['osteopathicData'] != null) {
      osteopathicData = new List<OsteopathicData>();
      json['osteopathicData'].forEach((v) {
        osteopathicData.add(new OsteopathicData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.osteopathicData != null) {
      data['osteopathicData'] =
          this.osteopathicData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OsteopathicData {
  int id;
  String value;
  String createdAt;
  String updatedAt;

  OsteopathicData({this.id, this.value, this.createdAt, this.updatedAt});

  OsteopathicData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
