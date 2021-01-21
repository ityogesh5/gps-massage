class StatesList {
  String status;
  List<Data> data;

  StatesList({this.status, this.data});

  StatesList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String prefectureEn;
  String prefectureJa;

  Data({this.id, this.prefectureEn, this.prefectureJa});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prefectureEn = json['prefecture_en'];
    prefectureJa = json['prefecture_ja'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prefecture_en'] = this.prefectureEn;
    data['prefecture_ja'] = this.prefectureJa;
    return data;
  }
}
