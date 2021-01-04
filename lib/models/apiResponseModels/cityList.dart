class CityList {
  String status;
  List<Data> data;

  CityList({this.status, this.data});

  CityList.fromJson(Map<String, dynamic> json) {
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
  int prefectureId;
  String cityEn;
  String cityJa;
  String specialDistrictJa;

  Data(
      {this.id,
      this.prefectureId,
      this.cityEn,
      this.cityJa,
      this.specialDistrictJa});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prefectureId = json['prefectureId'];
    cityEn = json['city_en'];
    cityJa = json['city_ja'];
    specialDistrictJa = json['special_district_ja'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prefectureId'] = this.prefectureId;
    data['city_en'] = this.cityEn;
    data['city_ja'] = this.cityJa;
    data['special_district_ja'] = this.specialDistrictJa;
    return data;
  }
}
