import 'dart:async';


import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';

class CheckInternetConnection {
  static String _connectionStatus = 'Unknown';
  static final Connectivity _connectivity = Connectivity();
  static StreamSubscription<ConnectivityResult> _connectivitySubscription;

  static Future<void> checkConnectivity(BuildContext context) async {
    try {
      ConnectivityResult result = ConnectivityResult.none;
// Platform messages may fail, so we use a try/catch PlatformException.
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(checkStatus);

      result = await _connectivity.checkConnectivity();
      return checkStatus(result);
    } on PlatformException catch (e) {
      print('Platform Exception :  ${e.toString()}');
    } catch (e) {
      print('IllegalArgumentException Exception caught !!');
    }
  }

  static Future<void> checkStatus(ConnectivityResult result) async {
    try {
      switch (result) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
        case ConnectivityResult.none:
          _connectionStatus = result.toString();
// print('Internet state : $_connectionStatus');
          break;
        default:
          _connectionStatus = 'Failed to get connectivity.';
          break;
      }
      print('Internet state : $_connectionStatus');
      if (_connectionStatus.contains('ConnectivityResult.none')) {
        print('No Internet !!');
        HealingMatchConstants.isInternetAvailable = false;
      } else {
        print('Internet Available');
        HealingMatchConstants.isInternetAvailable = true;
      }
    } catch (IllegalArgumentException) {
      print('IllegalArgumentException caught..!!');
    }
    return false;
  }

  static void cancelSubscription() {
    _connectivitySubscription.cancel();
  }
}
