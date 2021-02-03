class UserAddressAdd {
  String _address;
  String _lat;
  String _lng;
  String _addressType;
  String _city;
  String _prefecture;
  String _roomNumber;
  String _buildingName;
  String _area;

  UserAddressAdd(
      this._address,
      this._lat,
      this._lng,
      this._addressType,
      this._city,
      this._prefecture,
      this._roomNumber,
      this._buildingName,
      this._area);

  //userAddressAdd.fromAddress(this._lat, this._lng, this._addressType);

  String get subAddress => _address;

  String get lat => _lat;

  String get lng => _lng;

  String get addressType => _addressType;

  String get city => _city;

  String get prefecture => _prefecture;

  String get roomNumber => _roomNumber;

  String get buildingName => _buildingName;

  String get area => _area;

  set subAddress(String subAddress) {
    this._address = subAddress;
  }

  set lat(String lat) {
    this._lat = lat;
  }

  set lng(String lang) {
    this._lng = lang;
  }

  set addressType(String addressType) {
    this._addressType = addressType;
  }

  set city(String city) {
    this._city = city;
  }

  set prefecture(String prefecture) {
    this._prefecture = prefecture;
  }

  set roomNumber(String roomNumber) {
    this._roomNumber = roomNumber;
  }

  set buildingName(String buildingName) {
    this._buildingName = buildingName;
  }

  set area(String area) {
    this._area = area;
  }

  /*  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _addressKey;
    map['subAddress'] = _address;
    map['latitude'] = _lat;
    map['longitude'] = _lng;
    map['addressType'] = _addressType;

    return map;
  }

  UserAddressAdd.fromMapObject(Map<String, dynamic> map) {
    this._addressKey = map['id'];
    this._address = map['subAddress'];
    this._lat = map['latitude'];
    this._lng = map['longitude'];
    this._addressType = map['addressType'];
  } */

  UserAddressAdd.fromJson(Map<String, dynamic> json) {
    //_addressKey = json['addressKey'];
    _address = json['subAddress'];
    _lat = json['lat'];
    _lng = json['lng'];
    _addressType = json['addressTypeSelection'];
    _city = json['cityName'];
    _prefecture = json['capitalAndPrefecture'];
    _roomNumber = json['roomNumber'];
    _buildingName = json['buildingName'];
    _area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['addressKey'] = this._addressKey;
    data['subAddress'] = this._address;
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    data['addressTypeSelection'] = this._addressType;
    data['cityName'] = this._city;
    data['capitalAndPrefecture'] = this._prefecture;
    data['roomNumber'] = this._roomNumber;
    data['buildingName'] = this._buildingName;
    data['area'] = this._area;
    return data;
  }
}
