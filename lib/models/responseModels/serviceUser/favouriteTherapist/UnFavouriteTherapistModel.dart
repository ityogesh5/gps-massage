class UnFavouriteTherapist {
  String status;
  String message;
  List<int> data;

  UnFavouriteTherapist({this.status, this.message, this.data});

  UnFavouriteTherapist.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
