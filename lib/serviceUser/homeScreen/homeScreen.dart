import 'package:flutter/material.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/carouselSliders.dart';

class ServiceUserHomeScreen extends StatefulWidget {
  @override
  _ServiceUserHomeScreenScreenState createState() =>
      _ServiceUserHomeScreenScreenState();
}

class _ServiceUserHomeScreenScreenState extends State<ServiceUserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ヒーリングマッチ',
      debugShowCheckedModeBanner: false,
      //home: HomeScreen(),
      home: CarouselDemo(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(),
      ),
    );
  }
}
