class LineIDTokenResponseModel {
  String iss;
  String sub;
  String aud;
  int exp;
  int iat;
  String nonce;
  List<String> amr;
  String name;
  String picture;
  String email;

  LineIDTokenResponseModel(
      {this.iss,
      this.sub,
      this.aud,
      this.exp,
      this.iat,
      this.nonce,
      this.amr,
      this.name,
      this.picture,
      this.email});

  LineIDTokenResponseModel.fromJson(Map<String, dynamic> json) {
    iss = json['iss'];
    sub = json['sub'];
    aud = json['aud'];
    exp = json['exp'];
    iat = json['iat'];
    nonce = json['nonce'];
    amr = json['amr'].cast<String>();
    name = json['name'];
    picture = json['picture'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iss'] = this.iss;
    data['sub'] = this.sub;
    data['aud'] = this.aud;
    data['exp'] = this.exp;
    data['iat'] = this.iat;
    data['nonce'] = this.nonce;
    data['amr'] = this.amr;
    data['name'] = this.name;
    data['picture'] = this.picture;
    data['email'] = this.email;
    return data;
  }
}
