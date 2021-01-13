import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class ViewUserProfile extends StatefulWidget {
  @override
  State createState() {
    return _ViewUserProfileState();
  }
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            NavigationRouter.switchToServiceUserBottomBar(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'マイアカウント',
          style: TextStyle(
              fontFamily: 'Oxygen',
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[popupMenuButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: new BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: new AssetImage(
                                  'assets/images_gps/usernew.png'),
                            ),
                          )),
                      CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        radius: 15,
                        child: IconButton(
                            icon: Icon(
                              Icons.edit_rounded,
                              size: 15,
                              color: Colors.grey[400],
                            ),
                            onPressed: () {}),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  new Text(
                    'お名前',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.bold),
                  ),
                  Chip(
                      avatar:
                          Icon(Icons.phone_rounded, color: Colors.grey[400]),
                      backgroundColor: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      label: Text(
                        "電話番号",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      )),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white, Colors.white]),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.grey[100],
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyRow(
                                Icon(Icons.mail_outline_rounded,
                                    size: 30, color: Colors.grey[500]),
                                Text('メールアドレス',
                                    style: TextStyle(
                                        fontFamily: 'Oxygen', fontSize: 14.0)),
                                SizedBox(width: 0)),
                            Divider(color: Colors.grey[300], height: 1),
                            MyRow(
                                Icon(Icons.calendar_today_rounded,
                                    size: 30, color: Colors.grey[500]),
                                Text('生年月日',
                                    style: TextStyle(
                                        fontFamily: 'Oxygen', fontSize: 14.0)),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey[200],
                                  child: Text(
                                    '23',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Oxygen',
                                        color: Colors.black),
                                  ),
                                )),
                            Divider(color: Colors.grey[300], height: 1),
                            MyRow(
                                Icon(Icons.person_outline_sharp,
                                    size: 30, color: Colors.grey[500]),
                                Text('性別',
                                    style: TextStyle(
                                        fontFamily: 'Oxygen', fontSize: 14.0)),
                                SizedBox(width: 0)),
                            Divider(color: Colors.grey[300], height: 1),
                            MyRow(
                                Icon(Icons.shopping_bag,
                                    size: 30, color: Colors.grey[500]),
                                Text('職業',
                                    style: TextStyle(
                                        fontFamily: 'Oxygen', fontSize: 14.0)),
                                SizedBox(width: 0)),
                            Divider(color: Colors.grey[300], height: 1),
                            MyRow(
                                Icon(Icons.location_on_outlined,
                                    size: 30, color: Colors.grey[500]),
                                Text(
                                  '436-C鉄道地区ウィンターペットアラコナム。',
                                  style: TextStyle(
                                      fontFamily: 'Oxygen', fontSize: 14.0),
                                ),
                                SizedBox(width: 0)),
                            Divider(color: Colors.grey[300], height: 1),
                            MyRow(
                                Icon(Icons.settings_input_antenna_rounded,
                                    size: 30, color: Colors.grey[500]),
                                Text('セラピスト検索範囲5.0Km距離。',
                                    style: TextStyle(
                                        fontFamily: 'Oxygen', fontSize: 14.0)),
                                SizedBox(width: 0))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyRow(Widget image, Widget text, Widget circleAvatar) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: image,
          ),
          Flexible(
              child: Padding(padding: const EdgeInsets.all(10.0), child: text)),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: circleAvatar,
          )
        ],
      ),
    );
  }

  Widget popupMenuButton() {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
        size: 30.0,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: "one_val",
          child: Text(
            'プロフィール編集',
            style: TextStyle(fontFamily: 'Oxygen'),
          ),
        ),
        /*PopupMenuItem<String>(
          value: "sec_val",
          child: Text(
            'アカウントを無効化',
            style: TextStyle(fontFamily: 'Oxygen'),
          ),
        ),*/
      ],
      onSelected: (retVal) {
        if (retVal == "one_val") {
          print('Editing screen not there!!');
        } else if (retVal == "sec_val") {}
      },
    );
  }
}
