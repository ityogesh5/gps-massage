import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/serviceProvider/APIProviderCalls/ServiceProviderApi.dart';

class AdminNotification extends StatefulWidget {
  @override
  _AdminNotificationState createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
  @override
  void initState() {
    ServiceProviderApi.updateNotificationStatus(
        HealingMatchConstants.notificationId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            padding:
                EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'お知らせ',
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 30, left: 8.0, right: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ClipOval(
                      child: CircleAvatar(
                        radius: 28.0,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          'assets/images_gps/logo.png',
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '管理者',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "${HealingMatchConstants.adminMessage}",
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
