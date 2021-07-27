import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:gps_massageapp/customLibraryClasses/customToggleButton/CustomToggleButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

class NotificationPopup extends StatefulWidget {
  @override
  _NotificationPopupState createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<NotificationPopup> {
  final fireBaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    FlutterStatusbarcolor.setStatusBarColor(Colors.grey[200]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.98,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 15.0, // soften the shadow
            spreadRadius: 5, //extend the shadow
            offset: Offset(
              0.0, // Move to right 10  horizontally
              10.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              'Healing Matchは通知を送信します。\nよろしいですか？',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color.fromRGBO(35, 24, 21, 1),
                  fontFamily: 'Open Sans'),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          FittedBox(
            child: Text(
              '通知方法は、テキスト、サウンド、\nアイコンバッジがあります。',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(35, 24, 21, 1),
                  fontFamily: 'Open Sans'),
            ),
          ),
          FittedBox(
            child: Text(
              '"設定"で指定できます。',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Open Sans',
                color: Color.fromRGBO(35, 24, 21, 1),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.30,
                child: CustomToggleButton(
                  elevation: 0,
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.30,
                  autoWidth: false,
                  buttonColor: Color.fromRGBO(217, 217, 217, 1),
                  enableShape: true,
                  customShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.transparent)),
                  buttonLables: ["許可しない", "OK"],
                  fontSize: 14.0,
                  buttonValues: [
                    "N",
                    "Y",
                  ],
                  radioButtonValue: (radioValue) {
                    _sharedPreferences.then((spValue) {
                      if (radioValue == 'Y') {
                        Navigator.pop(context);
                        print('Notification permission accepted!!');
                        fireBaseMessaging.setAutoInitEnabled(true);
                        //spValue.setBool('fcmStatus', true);
                        spValue.setString('notificationStatus', 'accepted');
                        //bool fcmStatus = spValue.getBool('fcmStatus');
                        print(
                            'fcmStatus is notification : ${spValue.getString('notificationStatus')}');
                      } else {
                        Navigator.pop(context);
                        fireBaseMessaging.setAutoInitEnabled(false);
                        print('Notification permission denied!!');
                        //spValue.setBool('fcmStatus', false);
                        spValue.setString('notificationStatus', 'denied');
                        //bool fcmStatus = spValue.getBool('fcmStatus');
                        print(
                            'fcmStatus is notification : ${spValue.getString('notificationStatus')}');
                        print('Notification permission rejected!!');
                      }
                    });
                    print('Radio value : $radioValue');
                  },
                  selectedColor: Color.fromRGBO(200, 217, 33, 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
