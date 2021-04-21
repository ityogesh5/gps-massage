class DeleteSubAddressModel {
  String status;
  String message;
  int userData;

  DeleteSubAddressModel({this.status, this.message, this.userData});

  DeleteSubAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userData = json['userData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['userData'] = this.userData;
    return data;
  }
}
