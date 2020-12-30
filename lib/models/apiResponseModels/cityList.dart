class CityList {
  String status;
  List<CityJpData> cityJpData;

  CityList({this.status, this.cityJpData});

  CityList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['cityJpData'] != null) {
      cityJpData = new List<CityJpData>();
      json['cityJpData'].forEach((v) {
        cityJpData.add(new CityJpData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.cityJpData != null) {
      data['cityJpData'] = this.cityJpData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityJpData {
  int id;
  int prefectureId;
  String cityEn;
  String cityJa;
  Null specialDistrictJa;
  Null createdAt;
  Null updatedAt;

  CityJpData(
      {this.id,
      this.prefectureId,
      this.cityEn,
      this.cityJa,
      this.specialDistrictJa,
      this.createdAt,
      this.updatedAt});

  CityJpData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prefectureId = json['prefecture_id'];
    cityEn = json['city_en'];
    cityJa = json['city_ja'];
    specialDistrictJa = json['special_district_ja'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prefecture_id'] = this.prefectureId;
    data['city_en'] = this.cityEn;
    data['city_ja'] = this.cityJa;
    data['special_district_ja'] = this.specialDistrictJa;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
