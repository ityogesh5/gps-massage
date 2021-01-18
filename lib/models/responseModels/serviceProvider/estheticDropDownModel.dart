class EstheticDropDownModel {
  String _status;
  List<Data> _data;

  EstheticDropDownModel({String status, List<Data> data}) {
    this._status = status;
    this._data = data;
  }

  String get status => _status;
  set status(String status) => _status = status;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  EstheticDropDownModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = new List<Data>();
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int _id;
  String _value;

  Data({int id, String value}) {
    this._id = id;
    this._value = value;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get value => _value;
  set value(String value) => _value = value;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['value'] = this._value;
    return data;
  }
}
