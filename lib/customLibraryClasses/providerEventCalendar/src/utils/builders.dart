import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:googleapis/calendar/v3.dart' as Calendar;
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/flutter_week_view.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/event.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/styles/day_bar.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/styles/day_view.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/utils/hour_minute.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/utils/utils.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/widgets/day_view.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/widgets/zoomable_header_widget.dart';

/// Contains default builders and formatters.
class DefaultBuilders {
  /// Formats a day in YYYY-MM-DD format, e.g., 2020-01-15.
  static String defaultDateFormatter(int year, int month, int day) =>
      year.toString() +
      '-' +
      Utils.addLeadingZero(month) +
      '-' +
      Utils.addLeadingZero(day);

  /// Formats a hour in 24-hour HH:MM format, e.g., 15:00.
  static String defaultTimeFormatter(HourMinute time) =>
      Utils.addLeadingZero(time.hour) + ':' + Utils.addLeadingZero(time.minute);

  /// Allows to calculate a top offset according to the specified hour row height.
  static double defaultTopOffsetCalculator(HourMinute time,
      {HourMinute minimumTime = HourMinute.MIN, double hourRowHeight = 60}) {
    HourMinute relative = time.subtract(minimumTime);
    return (relative.hour + (relative.minute / 60)) * hourRowHeight;
  }

  /// Builds an event text widget in order to put it in a week view.
  static Widget defaultEventTextBuilder(FlutterWeekViewEvent event,
      BuildContext context, DayView dayView, double height, double width) {
    /* List<TextSpan> text = [
      TextSpan(
        text: event.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text: ' ' +
            dayView.hoursColumnStyle
                .timeFormatter(HourMinute.fromDateTime(dateTime: event.start)) +
            ' - ' +
            dayView.hoursColumnStyle
                .timeFormatter(HourMinute.fromDateTime(dateTime: event.end)) +
            '\n\n',
      ),
      TextSpan(
        text: event.description,
      ),
    ];

    bool exceedHeight;
    while (exceedHeight ?? true) {
      exceedHeight = _exceedHeight(text, event.textStyle, height, width);
      if (exceedHeight == null || !exceedHeight) {
        if (exceedHeight == null) {
          text.clear();
        }
        break;
      }

      if (!_ellipsize(text)) {
        break;
      }
    } */
    Calendar.Event googleApiEvent = event.events;
    var split = googleApiEvent.summary.split(',');

    return Container(
        padding: EdgeInsets.all(2.0),
        width: MediaQuery.of(context).size.width - 120.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  HealingMatchConstants.isProvider ? split[3] : split[1],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                googleApiEvent.status == 'tentative'
                    ? Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images_gps/processing.svg",
                            height: 20.0,
                            width: 20.0,
                          ),
                          /*  Icon(
                Icons.hourglass_top_outlined,
                color: Color.fromRGBO(255, 193, 7, 1),
              ), */
                          Text("承認待ち",
                              style: TextStyle(
                                color: Color.fromRGBO(255, 193, 7, 1),
                              ))
                        ],
                      )
                    : Row(
                        children: [
                          Text("承認済み", style: TextStyle(color: Colors.black))
                        ],
                      )
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/images_gps/clock.svg",
                  height: 14.77,
                  width: 16.0,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '${event.start.hour}:${event.start.minute} ~ ${event.end.hour}: ${event.end.minute}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' 60分 ',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color.fromRGBO(102, 102, 102, 1),
                  ),
                ),
              ],
            ),
          ],
        ));

    /*  return RichText(
      text: TextSpan(
        children: text,
        style: event.textStyle,
      ),
    );
 */
  }

  /// Builds a date according to a list.
  static DateTime defaultDateCreator(List<DateTime> dates, int index) =>
      dates[index];

  /// Builds the current time indicator builder.
  static Widget defaultCurrentTimeIndicatorBuilder(DayViewStyle dayViewStyle,
      TopOffsetCalculator topOffsetCalculator, double hoursColumnWidth) {
    List<Widget> children = [
      if (dayViewStyle.currentTimeRuleHeight > 0 &&
          dayViewStyle.currentTimeRuleColor != null)
        Expanded(
          child: Container(
            height: dayViewStyle.currentTimeRuleHeight,
            color: dayViewStyle.currentTimeRuleColor,
          ),
        ),
      if (dayViewStyle.currentTimeCircleRadius > 0 &&
          dayViewStyle.currentTimeCircleColor != null)
        Container(
          height: dayViewStyle.currentTimeCircleRadius * 2,
          width: dayViewStyle.currentTimeCircleRadius * 2,
          decoration: BoxDecoration(
            color: dayViewStyle.currentTimeCircleColor,
            shape: BoxShape.circle,
          ),
        ),
    ];

    if (dayViewStyle.currentTimeCirclePosition ==
        CurrentTimeCirclePosition.left) {
      children = children.reversed.toList();
    }

    return Positioned(
      top: topOffsetCalculator(HourMinute.now()),
      left: hoursColumnWidth,
      right: 0,
      child: Row(children: children),
    );
  }

  /// Builds the time displayed on the side border.
  static Widget defaultHoursColumnTimeBuilder(
      HoursColumnStyle hoursColumnStyle, HourMinute time) {
    return Text(
      hoursColumnStyle.timeFormatter(time),
      style: hoursColumnStyle.textStyle,
    );
  }

  /// The default day view style builder.
  static DayViewStyle defaultDayViewStyleBuilder(DateTime date) =>
      DayViewStyle.fromDate(date: date);

  /// The default day view style builder.
  static DayBarStyle defaultDayBarStyleBuilder(DateTime date) =>
      DayBarStyle.fromDate(date: date);

  /// Returns whether this input exceeds the specified height.
  static bool _exceedHeight(
      List<TextSpan> input, TextStyle textStyle, double height, double width) {
    double fontSize = textStyle?.fontSize ?? 14;
    int maxLines = height ~/ ((textStyle?.height ?? 1.2) * fontSize);
    if (maxLines == 0) {
      return null;
    }

    TextPainter painter = TextPainter(
      text: TextSpan(
        children: input,
        style: textStyle,
      ),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    );
    painter.layout(maxWidth: width);
    return painter.didExceedMaxLines;
  }

  /// Ellipsizes the input.
  static bool _ellipsize(List<TextSpan> input, [String ellipse = '…']) {
    if (input.isEmpty) {
      return false;
    }

    TextSpan last = input.last;
    String text = last.text;
    if (text.isEmpty || text == ellipse) {
      input.removeLast();

      if (text == ellipse) {
        _ellipsize(input, ellipse);
      }
      return true;
    }

    String truncatedText;
    if (text.endsWith('\n')) {
      truncatedText = text.substring(0, text.length - 1) + ellipse;
    } else {
      truncatedText = Utils.removeLastWord(text);
      truncatedText =
          truncatedText.substring(0, math.max(0, truncatedText.length - 2)) +
              ellipse;
    }

    input[input.length - 1] = TextSpan(
      text: truncatedText,
      style: last.style,
    );

    return true;
  }
}
