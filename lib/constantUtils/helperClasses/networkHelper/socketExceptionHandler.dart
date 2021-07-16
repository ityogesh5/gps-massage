import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class SocketExceptionHandler extends StatefulWidget {
  @override
  State createState() {
    return _SocketExceptionHandlerState();
  }
}

class _SocketExceptionHandlerState extends State<SocketExceptionHandler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              splashColor: Colors.deepOrangeAccent,
              highlightColor: Colors.limeAccent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Color.fromRGBO(255, 255, 255, 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      AntDesign.disconnect,
                      color: Colors.deepOrangeAccent,
                      size: 50,
                    ),
                    Text('インターネット接続を確認してください。',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    InkWell(
                      splashColor: Colors.deepOrangeAccent,
                      highlightColor: Colors.limeAccent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(MaterialIcons.refresh),
                            onPressed: () {
                              print("a");
                              if (HealingMatchConstants.isInternetAvailable) {
                                HealingMatchConstants.isLoggedin &&
                                        HealingMatchConstants.isProvider
                                    ? NavigationRouter
                                        .switchToServiceProviderBottomBar(
                                            context)
                                    : HealingMatchConstants.isLoggedin &&
                                            !HealingMatchConstants.isProvider
                                        ? NavigationRouter
                                            .switchToServiceUserBottomBar(
                                                context)
                                        : Navigator.pop(context);
                              }
                            },
                          ),
                          Text(
                            'もう一度試してください。',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
