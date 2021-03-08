import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:gps_massageapp/customLibraryClasses/cusTomChatBubbles/CustomChatBubbles.dart';
import 'package:gps_massageapp/customLibraryClasses/cusTomChatBubbles/customChatBubbleReceiver.dart';
import 'package:gps_massageapp/customLibraryClasses/cusTomChatBubbles/customChatBubbleSender.dart';

void main() => runApp(ChatUserScreen());
GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
bool userIsOnline = true;
final _chatMessagesController = new TextEditingController();

class ChatUserScreen extends StatefulWidget {
  @override
  _ChatUserScreenState createState() => _ChatUserScreenState();
}

class _ChatUserScreenState extends State<ChatUserScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: MainChatScreen(),
      ),
    );
  }
}

class MainChatScreen extends StatefulWidget {
  @override
  State createState() {
    return _MainChatScreenState();
  }
}

class _MainChatScreenState extends State<MainChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(context);
                },
                color: Colors.black,
              ),
              Stack(
                overflow: Overflow.visible,
                children: [
                  InkWell(
                    onTap: () {},
                    child: new Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: new AssetImage('assets/images_gps/logo.png'),
                          ),
                        )),
                  ),
                  userIsOnline
                      ? Visibility(
                          visible: userIsOnline,
                          child: Positioned(
                            right: -20.0,
                            top: 35,
                            left: 10.0,
                            child: InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 8,
                                child: CircleAvatar(
                                  backgroundColor: Colors.green[400],
                                  radius: 6,
                                  child: Container(),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Visibility(
                          visible: false,
                          child: Positioned(
                            right: -30.0,
                            top: 45,
                            left: 10.0,
                            child: InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[500],
                                radius: 6,
                                child: CircleAvatar(
                                  backgroundColor: Colors.green[400],
                                  radius: 5,
                                  child: Container(),
                                ),
                              ),
                            ),
                          ),
                        )
                ],
              ),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "店舗名",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 3),
                  Text("オンライン",
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      textAlign: TextAlign.left),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          getSenderView(
                              ChatBubbleSender(type: BubbleType.sendBubble),
                              context),
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '昨日14:38時',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'NotoSansJP'),
                              ),
                              Text('')
                            ],
                          ),
                          getReceiverView(
                              ChatBubbleReceiver(
                                  type: BubbleType.receiverBubble),
                              context),
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '昨日14:38時',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'NotoSansJP'),
                              ),
                              Text('')
                            ],
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: _bottomChatArea(),
            ),
          ),
        ],
      ),
    );
  }

  _bottomChatArea() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          _chatTextArea(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new CircleAvatar(
              backgroundColor: Colors.lime,
              radius: 25,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: IconButton(
                  icon: Icon(Icons.send, size: 30, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _chatTextArea() {
    return Expanded(
      child: TextField(
        controller: _chatMessagesController,
        autofocus: false,
        textInputAction: TextInputAction.done,
        decoration: new InputDecoration(
            filled: false,
            fillColor: Colors.white,
            hintText: 'メッセージを入カしてください。',
            prefixIcon: IconButton(
              icon: Icon(Icons.attachment_outlined, color: Colors.grey[300]),
              onPressed: () {},
            ),
            hintStyle: TextStyle(color: Colors.grey[300]),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(25.7),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30.0),
            )),
      ),
    );
  }

  getSenderView(CustomClipper clipper, BuildContext context) =>
      CustomChatBubble(
        clipper: clipper,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Colors.lime,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            "元気！リクエストを受け入れてくれてありがとうございます。このバッケージ価値が大丈夫です。また会いましょう！",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  getReceiverView(CustomClipper clipper, BuildContext context) =>
      CustomChatBubble(
        clipper: clipper,
        backGroundColor: Colors.grey[100],
        elevation: 0.1,
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            "音声をやめて画像をアップできるようにする且つ費用の増減なし!",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}
