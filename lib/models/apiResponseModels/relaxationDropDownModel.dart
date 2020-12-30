class RelaxationDropDownModel {
  String status;
  List<RelaxationData> relaxationData;

  RelaxationDropDownModel({this.status, this.relaxationData});

  RelaxationDropDownModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['relaxationData'] != null) {
      relaxationData = new List<RelaxationData>();
      json['relaxationData'].forEach((v) {
        relaxationData.add(new RelaxationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.relaxationData != null) {
      data['relaxationData'] =
          this.relaxationData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RelaxationData {
  int id;
  String value;
  String createdAt;
  String updatedAt;

  RelaxationData({this.id, this.value, this.createdAt, this.updatedAt});

  RelaxationData.fromJson(Map<String, dynamic> json) {
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
