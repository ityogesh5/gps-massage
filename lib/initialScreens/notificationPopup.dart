import 'package:flutter/material.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPopup extends StatefulWidget {
  @override
  _NotificationPopupState createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<NotificationPopup> {
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.98,
      decoration: BoxDecoration(
        color: Colors.white,
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
              'Healing Matchは通知を送信します。\nよろしいでしょうか？',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
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
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Open Sans'),
            ),
          ),
          FittedBox(
            child: Text(
              '"設定"で指定できます。',
              style: TextStyle(fontSize: 14, fontFamily: 'Open Sans'),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  //putting boolean as de activate
                  _sharedPreferences.then((value) {
                    value.setBool('fcmStatus', false);
                    bool fcmStatus = value.getBool('fcmStatus');
                    //print('fcmStatus is false : $fcmStatus');
                  });
                  //NavigationRouter.switchToUserDefineScreen(context);
                  NavigationRouter.switchToTermsAndConditions(context);
                  // Navigator.pop(context);
                },
                minWidth: MediaQuery.of(context).size.width * 0.28,
                // splashColor: Colors.grey,
                color: Colors.grey[400],
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  '許可しない',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Open Sans',
                    color: Colors.white,
                  ),
                ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  //putting boolean as activate
                  _sharedPreferences.then((value) {
                    value.setBool('fcmStatus', true);
                    bool fcmStatus = value.getBool('fcmStatus');
                    //print('fcmStatus is true : $fcmStatus');
                  });
                  //NavigationRouter.switchToUserDefineScreen(context);
                  NavigationRouter.switchToTermsAndConditions(context);
                  // Navigator.pop(context);
                },
                minWidth: MediaQuery.of(context).size.width * 0.28,
                splashColor: Colors.pinkAccent[600],
                color: Colors.lime,
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  'OK',
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      fontFamily: 'Open Sans'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
