import 'package:flutter/material.dart';
import 'package:gps_massageapp/customLibraryClasses/customToggleButton/CustomToggleButton.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutServiceUser extends StatefulWidget {
  @override
  _LogOutServiceUserState createState() => _LogOutServiceUserState();
}

class _LogOutServiceUserState extends State<LogOutServiceUser> {
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
              'ログアウトしてもよろしいでしょうか？',
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
                  buttonLables: ["はい", "いいえ"],
                  fontSize: 16.0,
                  buttonValues: [
                    "Y",
                    "N",
                  ],
                  radioButtonValue: (value) {
                    if (value == 'Y') {
                      print('User Logged out!!');
                      _sharedPreferences.then((value) {
                        // value.remove('accessToken');
                        value.remove('addressData');
                        value.setBool('isUserLoggedOut', true);
                        value.setBool('isUserLoggedIn', false);
                        value.setBool('isProviderLoggedOut', false);
                        value.setBool('isUserRegister', false);
                        bool loggedOut = value.getBool('isUserLoggedOut');
                        print('userLogout is false : $loggedOut');

                        NavigationRouter.switchToUserLogin(context);
                      });
                    } else {
                      Navigator.pop(context);
                      _sharedPreferences.then((value) {
                        value.setBool('isUserLoggedOut', false);
                        bool loggedOut = value.getBool('isUserLoggedOut');
                        print('userLogout is false : $loggedOut');
                      });
                      print('Notification permission rejected!!');
                    }
                    print('Radio value : $value');
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
