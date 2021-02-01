class AddUserAddress {
  String _addressKey;
  String _address;
  String _lat;
  String _lng;
  String _addressType;

  AddUserAddress(this._addressKey, this._address,this._lat,this._lng,this._addressType);

  String get addressKey => _addressKey;
  String get subAddress => _address;
  String get lat=> _lat;
  String get lng=> _lng;
  String get addressType => _addressType;

  set addressKey(String addressKey) {
    this._addressKey = addressKey;
  }
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


  @override
  String toString() {
    return '{ ${this._addressKey} : ${this._address} , ${this._lat} , ${this._lng} , addressType : ${this._addressType} }';
  }


  AddUserAddress.fromJson(Map<String, dynamic> json) {
    //_addressKey = json['addressKey'];
    _address = json['subAddress'];
    _lat = json['lat'];
    _lng = json['lng'];
    _addressType = json['addressType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['addressKey'] = this._addressKey;
    data['subAddress'] = this._address;
    data['lat'] = this._lat;
    data['lng'] = this._lng;
    data['addressType'] = this._addressType;
    return data;
  }
}
