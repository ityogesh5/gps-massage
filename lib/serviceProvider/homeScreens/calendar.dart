import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/flutter_week_view.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<FlutterWeekViewEvent> events = [];
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return DayView(
      initialTime: const HourMinute(hour: 9),
      minimumTime: HourMinute(hour: 9),
      maximumTime: HourMinute(hour: 17),
      date: now,
      events: [
        FlutterWeekViewEvent(
          title: 'An event 1',
          description: 'A description 1',
          start: date.subtract(const Duration(hours: 9)),
          end: date.add(const Duration(hours: 11, minutes: 30)),
        ),
        FlutterWeekViewEvent(
          title: 'An event 2',
          description: 'A description 2',
          start: date.add(const Duration(hours: 13)),
          end: date.add(const Duration(hours: 14)),
        ),
        FlutterWeekViewEvent(
          title: 'An event 3',
          description: 'A description 3',
          start: date.add(const Duration(hours: 13, minutes: 30)),
          end: date.add(const Duration(hours: 15, minutes: 30)),
        ),
        FlutterWeekViewEvent(
          title: 'An event 4',
          description: 'A description 4',
          start: date.add(const Duration(hours: 15)),
          end: date.add(const Duration(hours: 16)),
        ),
        FlutterWeekViewEvent(
          title: 'An event 5',
          description: 'A description 5',
          start: date.add(const Duration(hours: 15)),
          end: date.add(const Duration(hours: 16)),
        ),
      ],
      style: DayViewStyle.fromDate(
        date: date,
        currentTimeCircleColor: Colors.pink,
      ),
    );
  }
}
