import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gps_massageapp/commonScreens/chat/chatUserList.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/notificatioHistory.dart';

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
  int _state = 0;
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
    if (_state == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _state = 1;
        if (HealingMatchConstants.isActive != null &&
            HealingMatchConstants.isActive == false) {
          DialogHelper.showUserBlockDialog(context);
        } else {
          return;
        }
      });
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.13),
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
              elevation: 2.0,
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
          // Notification User Screen
          NotificationHistoryScreen(),

          // Chat List User Screen
          ChatUserList(),
        ],
      ),
    );
  }
}
