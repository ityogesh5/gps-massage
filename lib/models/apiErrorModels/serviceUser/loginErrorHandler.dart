class LoginErrorHandler {
  String status;
  String accessToken;
  String message;

  LoginErrorHandler({this.status, this.accessToken, this.message});

  LoginErrorHandler.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['accessToken'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['accessToken'] = this.accessToken;
    data['message'] = this.message;
    return data;
  }
}
