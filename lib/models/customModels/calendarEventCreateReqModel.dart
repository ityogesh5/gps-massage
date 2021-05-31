
class CalendarEventCreateReqModel {
  String userId;
  int therapistId;
  String userName;
  String therapistName;
  String eventLocationType;
  String eventLocation;
  int priceOfService;
  String nameOfService;
  DateTime startTime;
  DateTime endTime;

  CalendarEventCreateReqModel(
      this.userId,
      this.therapistId,
      this.userName,
      this.therapistName,
      this.eventLocationType,
      this.eventLocation,
      this.priceOfService,
      this.nameOfService,
      this.startTime,
      this.endTime);
}
