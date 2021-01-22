import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// The hove page which hosts the calendar
class Calendar extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  //const MyHomePage({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Meeting> meetings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[300],
              border: Border.all(
                color: Colors.transparent,
              )),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    color: Colors.grey,
                    border: Border.all(
                      color: Colors.transparent,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("09:00 ~ 17:00")),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SfCalendar(
                    backgroundColor: Colors.grey[300],
                    view: CalendarView.day,
                    dataSource: MeetingDataSource(_getDataSource()),
                    timeSlotViewSettings: TimeSlotViewSettings(
                      timeFormat: 'hh: mm',
                      startHour: 8,
                      endHour: 17,
                      timeIntervalHeight: 100.0,
                      timelineAppointmentHeight: 130.0,
                    ),
                    headerHeight: 0,
                    viewHeaderHeight: 0,
                    timeRegionBuilder: (context, timdeDetails) {
                      return Text('abc');
                    },
                    onTap: (a) {},
                    cellBorderColor: Colors.grey[300],
                    appointmentBuilder: (context, calendarDetails) {
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.grey.shade200, width: 0.5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  "日付を選",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      ' 日付を選択し日付を選択し ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    )),
                                Row(
                                  children: [
                                    Icon(Icons.access_time_rounded,
                                        size: 20, color: Colors.yellow),
                                    Text(
                                      '今月',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                Text(
                                  '日付を選日付を選',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Text(
                                    '日付を選日付を選',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  '日付を選日付を選',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black12,
                                    ),
                                    child: Text(
                                      ' 日付を選 ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(width: 10),
                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black12,
                                    ),
                                    child: Text(
                                      ' 日付を選 ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(width: 10),
                                Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.black12,
                                    ),
                                    child: Text(
                                      ' 日付を選 ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                    // by default the month appointment display mode set as Indicator, we can
                    // change the display mode as appointment using the appointment display
                    // mode property
                    monthViewSettings: MonthViewSettings(
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.appointment),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  List<Meeting> _getDataSource() {
    meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
