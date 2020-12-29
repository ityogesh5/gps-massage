class EstheticDropDownModel {
  String status;
  List<EstheticData> estheticData;

  EstheticDropDownModel({this.status, this.estheticData});

  EstheticDropDownModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['estheticData'] != null) {
      estheticData = new List<EstheticData>();
      json['estheticData'].forEach((v) {
        estheticData.add(new EstheticData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.estheticData != null) {
      data['estheticData'] = this.estheticData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EstheticData {
  int id;
  String value;
  String createdAt;
  String updatedAt;

  EstheticData({this.id, this.value, this.createdAt, this.updatedAt});

  EstheticData.fromJson(Map<String, dynamic> json) {
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
