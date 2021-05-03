import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as Calendar;
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/utils/builders.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/utils/utils.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/widgets/day_view.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/calendar/calendarDetailPopup.dart';

/// Builds an event text widget.
typedef EventTextBuilder = Widget Function(FlutterWeekViewEvent event,
    BuildContext context, DayView dayView, double height, double width);

/// Represents a flutter week view event.
class FlutterWeekViewEvent extends Comparable<FlutterWeekViewEvent> {
  /// Google Calendar Event
  final Calendar.Event events;

  /// The event title.
  final String title;

  /// The event description.
  final String description;

  /// The event start date & time.
  final DateTime start;

  /// The event end date & time.
  final DateTime end;

  /// The event widget background color.
  final Color backgroundColor;

  /// The event widget decoration.
  final BoxDecoration decoration;

  /// The event text widget text style.
  final TextStyle textStyle;

  /// The event widget padding.
  final EdgeInsets padding;

  /// The event widget margin.
  final EdgeInsets margin;

  /// The event widget tap event.
  final VoidCallback onTap;

  /// The event widget long press event.
  final VoidCallback onLongPress;

  /// The event text builder.
  final EventTextBuilder eventTextBuilder;

  /// Creates a new flutter week view event instance.
  FlutterWeekViewEvent({
    this.title,
    this.description,
    DateTime start,
    DateTime end,
    this.events,
    this.backgroundColor = const Color(0xCC2196F3),
    this.decoration,
    this.textStyle = const TextStyle(color: Colors.white),
    this.padding = const EdgeInsets.all(10),
    this.margin,
    this.onTap,
    this.onLongPress,
    this.eventTextBuilder,
  })  : start = start.yearMonthDayHourMinute,
        end = end.yearMonthDayHourMinute
  /*   assert(title != null),
        assert(description != null),
        assert(start != null),
        assert(end != null) */
  ;

  /// Builds the event widget.
  Widget build(
      BuildContext context, DayView dayView, double height, double width) {
    height = height - (padding?.top ?? 0.0) - (padding?.bottom ?? 0.0);
    width = width - (padding?.left ?? 0.0) - (padding?.right ?? 0.0);

    return GestureDetector(
      onTap: () {
        HealingMatchConstants.isProviderHomePage
            ? NavigationRouter.switchToWeeklySchedule(context)
            : ProviderCalendarDetailPopup.showBookingDetail(
                context, events, start, end);
      },
      onLongPress: onLongPress,
      child: Container(
        /* decoration: decoration ??
            (backgroundColor != null
                ? BoxDecoration(color: backgroundColor)
                : null), */
        decoration: BoxDecoration(
          color: HealingMatchConstants.isProviderHomePage
              ? Colors.white
              : Color.fromRGBO(242, 242, 242, 1),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.all(4.0),
        padding: padding,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: (eventTextBuilder ?? DefaultBuilders.defaultEventTextBuilder)(
            this,
            context,
            dayView,
            math.max(0.0, height),
            math.max(0.0, width),
          ),
        ),
      ),
    );
  }

  @override
  int compareTo(FlutterWeekViewEvent other) {
    int result = start.compareTo(other.start);
    if (result != 0) {
      return result;
    }
    return end.compareTo(other.end);
  }
}
