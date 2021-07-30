class EventScheduleModel {
  int _day;
  String _eventId;

  EventScheduleModel(int day, String eventId) {
    this._day = day;
    this._eventId = eventId;
  }

  int get day => _day;

  set day(int day) => _day = day;

  String get eventId => _eventId;

  set eventId(String eventId) => _eventId = eventId;

  EventScheduleModel.fromJson(Map<String, dynamic> json) {
    _day = json['day'];
    _eventId = json['eventId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this._day;
    data['eventId'] = this._eventId;
    return data;
  }
}
