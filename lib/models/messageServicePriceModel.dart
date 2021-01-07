class ServicePriceModel {
  String _name;
  int _sixtyMin;
  int _nintyMin;
  int _oneTwentyMin;
  int _oneFifityMin;
  int _oneEightyMin;
  int _id;

  ServicePriceModel(this._name, this._sixtyMin, this._nintyMin,
      this._oneTwentyMin, this._oneFifityMin, this._oneEightyMin, this._id);

  String get name => _name;

  int get sixtyMin => _sixtyMin;

  int get nintyMin => _nintyMin;

  int get oneTwentyMin => _oneTwentyMin;

  int get oneFiftyMin => _oneFifityMin;

  int get oneEightyMin => _oneEightyMin;

  int get id => _id;

  set name(String name) {
    this._name = name;
  }

  set sixtyMin(int price) {
    this._sixtyMin = price;
  }

  set nintyMin(int price) {
    this._nintyMin = price;
  }

  set oneTwentyMin(int price) {
    this._oneTwentyMin = price;
  }

  set oneFiftyMin(int price) {
    this._oneFifityMin = price;
  }

  set oneEightyMin(int price) {
    this._oneEightyMin = price;
  }

  set id(int id) {
    this._id = id;
  }

  ServicePriceModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _sixtyMin = json['sixtyMin'];
    _nintyMin = json['nintyMin'];
    _oneTwentyMin = json['oneTwentyMin'];
    _oneFifityMin = json['oneFifityMin'];
    _oneEightyMin = json['oneEightyMin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['sixtyMin'] = this._sixtyMin;
    data['nintyMin'] = this._nintyMin;
    data['oneTwentyMin'] = this._oneTwentyMin;
    data['oneFifityMin'] = this._oneFifityMin;
    data['oneEightyMin'] = this._oneEightyMin;
    return data;
  }
}
