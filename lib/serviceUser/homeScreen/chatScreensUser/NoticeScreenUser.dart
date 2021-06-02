import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/commonScreens/chat/chatUserList.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class NotifyScreenUser extends StatefulWidget {
  @override
  _NoticeScreenUserState createState() => _NoticeScreenUserState();
}

class _NoticeScreenUserState extends State<NotifyScreenUser>
    with SingleTickerProviderStateMixin {
  bool _value = false;
  int _tabIndex = 0;
  TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool userIsOnline = true;
  List<dynamic> notificationUsersList = new List();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
  }

  buildUnSelectedTabBar(String title) {
    return Container(
      height: 30.0,
      margin: EdgeInsets.all(0.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0, bottom: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Color.fromRGBO(225, 225, 225, 1),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Text(
        "$title",
        style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            fontFamily: 'NotoSansJP',
            fontWeight: FontWeight.bold),
      ),
    );
  }

  void _handleTabSelection() {
    setState(() {
      _tabIndex = _tabController.index;
      print("Tab Index : $_tabIndex");
      if (_tabIndex == 1) {
        Loader.show(context,
            progressIndicator: SpinKitThreeBounce(color: Colors.lime));
        Future.delayed(Duration(seconds: 2), () {
          Loader.hide();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 1),
                offset: Offset(0, 0.0),
                blurRadius: 8.0,
              )
            ]),
            child: AppBar(
              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              elevation: 5.0,
              automaticallyImplyLeading: false,
              title: Text(
                'メッセージ',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
                onPressed: () {
                  NavigationRouter.switchToServiceUserBottomBar(context);
                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),

              // backgroundColor: Color.fromRGBO(243, 249, 250, 1),
              centerTitle: true,
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                indicator: new BubbleTabIndicator(
                  indicatorHeight: 30.0,
                  indicatorColor: Colors.lime,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                ),
                onTap: (index) {},
                dragStartBehavior: DragStartBehavior.start,
                tabs: [
                  Tab(
                    child: _tabIndex == 0
                        ? Text(
                            "お知らせ",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'NotoSansJP',
                                fontWeight: FontWeight.bold),
                          )
                        : buildUnSelectedTabBar("お知らせ"),
                  ),
                  Tab(
                    child: _tabIndex == 1
                        ? Text("チャット",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'NotoSansJP',
                                fontWeight: FontWeight.bold))
                        : buildUnSelectedTabBar("チャット"),
                  ),
                ],
              ),
            ),
          )),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          // Notice User Screen
          notificationUsersList != null && notificationUsersList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        child: new ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: notificationUsersList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  print('Row on tap');
                                  print('Item index : $index');
                                },
                                splashColor: Colors.lime,
                                child: Card(
                                  elevation: 0.0,
                                  color: Color.fromRGBO(251, 251, 251, 1),
                                  semanticContainer: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 2,
                                            ),
                                            new Container(
                                                width: 60.0,
                                                height: 60.0,
                                                decoration: new BoxDecoration(
                                                  border: Border.all(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                  ),
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                    fit: BoxFit.fitHeight,
                                                    image: new AssetImage(
                                                        'assets/images_gps/logo.png'),
                                                  ),
                                                )),
                                            Text(
                                              '9時',
                                              style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 14,
                                                  fontFamily: 'NotoSansJP'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "店舗名",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.left,
                                                ),
                                                SizedBox(height: 10),
                                                Flexible(
                                                  child: Text(
                                                      "セラピストが予定を承認しました。",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[400],
                                                          fontSize: 12),
                                                      textAlign: TextAlign.left,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/images_gps/calendar.svg',
                                                    height: 15,
                                                    width: 15),
                                                Text(
                                                  "\t10月17\t",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                  "月曜日",
                                                  style: TextStyle(
                                                      color: Colors.grey[400],
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.left,
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/images_gps/cost.svg',
                                                      height: 15,
                                                      width: 15),
                                                  //SizedBox(width: 5),
                                                  Chip(
                                                    label: Text('足つぼ'),
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                  ),
                                                  Text(
                                                    "¥4,500",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                        "（交通費込み-¥乳、000）。",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[400],
                                                            fontSize: 12)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ))
              : Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            height: MediaQuery.of(context).size.height * 0.22,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              border: Border.all(
                                  color: Color.fromRGBO(217, 217, 217, 1)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: new Container(
                                          width: 80.0,
                                          height: 80.0,
                                          decoration: new BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12),
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new AssetImage(
                                                    'assets/images_gps/appIcon.png')),
                                          )),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            'お知らせはありません。',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'NotoSansJP',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

          // Chat List User Screen
          ChatUserList(),
        ],
      ),
    );
  }
}
