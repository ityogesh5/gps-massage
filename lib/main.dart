import 'package:flutter/material.dart';

import 'initialScreens/splashScreen.dart';

void main() {
  runApp(HealingMatchApp());
}

class HealingMatchApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        /*theme: ThemeData(
            textTheme:
                GoogleFonts.oxygenTextTheme(Theme.of(context).textTheme)),*/
        title: 'Healing Match',
        debugShowCheckedModeBanner: false,
        home: SplashScreen()); //SplashScreen());
  }
}
