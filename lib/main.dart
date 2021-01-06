import 'package:flutter/material.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

import 'initialScreens/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LineSDK.instance.setup('1620019587').then((_) {
    print('LineSDK Prepared');
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ヒーリングマッチ',
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
