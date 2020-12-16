import 'package:flutter/material.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ヒーリングマッチ',
      home: RegisterSecondScreen(),
    );
  }
}

class RegisterSecondScreen extends StatefulWidget {
  @override
  _RegisterSecondScreenState createState() => _RegisterSecondScreenState();
}

class _RegisterSecondScreenState extends State<RegisterSecondScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('ヒーリングマッチ'),
      ),
    );
  }
}