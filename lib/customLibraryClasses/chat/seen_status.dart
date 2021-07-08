import 'package:flutter/material.dart';

class SeenStatus extends StatelessWidget {
  final bool isMe;
  final bool isSeen;
  final DateTime timestamp;
  const SeenStatus({
    this.isSeen,
    this.isMe,
    this.timestamp,
    Key key,
  }) : super(key: key);

  String getTime() {
    DateTime currentDate = DateTime.now();
    int hour = timestamp.hour;
    int min = timestamp.minute;
    String hRes = hour <= 9 ? '0$hour' : hour.toString();
    String mRes = min <= 9 ? '0$min' : min.toString();

    String dayChange = (currentDate.day == timestamp.day &&
            currentDate.month == timestamp.month)
        ? "今日"
        : (currentDate.day - 1 == timestamp.day &&
                currentDate.month == timestamp.month)
            ? "昨日"
            : "${timestamp.day}/${timestamp.month}/${timestamp.year}";

    return '$dayChange $hRes時$mRes分';
  }

  Widget _buildStatus(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            getTime(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[400],
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        if (isMe)
          Icon(
            Icons.done_all,
            color: isSeen ? Colors.blue : Colors.grey[500],
            size: 15,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: _buildStatus(context),
    );
  }
}
