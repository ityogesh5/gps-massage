import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class BookingCancelTherapistResponseScreen extends StatefulWidget {
  @override
  State createState() {
    return _BookingCancelTherapistResponseScreenState();
  }
}

class _BookingCancelTherapistResponseScreenState
    extends State<BookingCancelTherapistResponseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            NavigationRouter.switchToServiceUserBottomBar(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: new Text(
          'お知らせ',
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Oxygen',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BookingCancelResponseFromTherapist(),
    );
  }
}

class BookingCancelResponseFromTherapist extends StatefulWidget {
  @override
  State createState() {
    return _BookingCancelResponseFromTherapistState();
  }
}

class _BookingCancelResponseFromTherapistState
    extends State<BookingCancelResponseFromTherapist> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DottedBorder(
                    dashPattern: [2, 2],
                    strokeWidth: 1,
                    color: Color.fromRGBO(232, 232, 232, 1),
                    strokeCap: StrokeCap.round,
                    borderType: BorderType.Circle,
                    radius: Radius.circular(5),
                    child: CircleAvatar(
                        maxRadius: 50,
                        backgroundColor: Color.fromRGBO(232, 232, 232, 1),
                        child: DottedBorder(
                          dashPattern: [3, 3],
                          strokeWidth: 1,
                          color: Color.fromRGBO(232, 232, 232, 1),
                          strokeCap: StrokeCap.round,
                          borderType: BorderType.Circle,
                          radius: Radius.circular(5),
                          child: CircleAvatar(
                            maxRadius: 50,
                            backgroundColor: Color.fromRGBO(232, 232, 232, 1),
                            child: SvgPicture.asset(
                                'assets/images_gps/calendar.svg',
                                height: 45,
                                width: 45,
                                color: Color.fromRGBO(255, 0, 0, 1)),
                          ),
                        ))),
                SizedBox(height: 10),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '${HealingMatchConstants.therapistResponseText}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'Oxygen'),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(242, 242, 242, 1),
                            Color.fromRGBO(242, 242, 242, 1)
                          ]),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.grey[100],
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey[100]),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      new Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          new Container(
                              width: 35.0,
                              height: 35.0,
                              decoration: new BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new AssetImage(
                                      'assets/images_gps/profile.png'),
                                ),
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Text(
                            'お名前',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Oxygen'),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          Image.asset('assets/images_gps/calendar.png',
                              height: 25, width: 25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Text(
                            '10月17',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Oxygen'),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          Text(
                            '月曜日出張',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[400],
                                fontFamily: 'Oxygen'),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          SvgPicture.asset('assets/images_gps/clock.svg',
                              height: 25, width: 25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          new Text(
                            '09:  00～10:  00',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Oxygen'),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          new Text(
                            '60分',
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontFamily: 'Oxygen'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          SvgPicture.asset('assets/images_gps/cost.svg',
                              height: 25, width: 25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Chip(
                            label: Text('足つぼ'),
                            backgroundColor: Colors.grey[200],
                          ),
                          Text(
                            "\t\t¥4,500",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01),
                          Text(
                            '(交通費込み-1,000)',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                                fontFamily: 'Oxygen'),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Divider(),
                            )),
                          ]),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03),
                          SvgPicture.asset('assets/images_gps/gps.svg',
                              height: 25, width: 25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Text(
                            '施術を受ける場所',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Oxygen'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.03),
                            Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(255, 255, 255, 1),
                                          Color.fromRGBO(255, 255, 255, 1)
                                        ]),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Colors.grey[300],
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.grey[200]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '店舗',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Oxygen'),
                                  ),
                                )),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.02),
                            Flexible(
                              child: Text(
                                '埼玉県浦和区高砂4丁目4',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[500],
                                    fontFamily: 'Oxygen'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
