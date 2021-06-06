import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/operationManagement/BannerImage.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/operationManagement/ShiftDescription.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/operationManagement/ShiftService.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/operationManagement/ShiftTiming.dart';

class OperationManagement extends StatefulWidget {
  final int tabindex;
  OperationManagement(this.tabindex);
  @override
  _OperationManagementState createState() => _OperationManagementState();
}

class _OperationManagementState extends State<OperationManagement>
    with SingleTickerProviderStateMixin {
  int _tabIndex;
  TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabIndex = widget.tabindex;
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
    _tabController.index = widget.tabindex;
  }

  buildUnSelectedTabBar(String title) {
    return Container(
      height: 30.0,
      margin: EdgeInsets.all(0.0),
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Text(
        "$title",
        style: TextStyle(
            color: Colors.black,
            fontSize: 12.0,
            fontFamily: 'NotoSansJP',
            fontWeight: FontWeight.bold),
      ),
    );
  }

  void _handleTabSelection() {
    print("a");
    setState(() {
      _tabIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 2.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          padding:
              EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () =>
              NavigationRouter.switchToServiceProviderBottomBar(context),
        ),
        title: Text(
          '運営管理',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.bold),
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
          labelPadding:
              EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
          indicator: new BubbleTabIndicator(
            padding: EdgeInsets.all(8.0),
            indicatorHeight: 30.0,
            indicatorColor: Colors.lime,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          onTap: (index) {},
          dragStartBehavior: DragStartBehavior.start,
          tabs: [
            Tab(
              child: _tabIndex == 0
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "掲載写真",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontFamily: 'NotoSansJP',
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : buildUnSelectedTabBar("掲載写真"),
            ),
            Tab(
              child: _tabIndex == 1
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("掲載コメント",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontFamily: 'NotoSansJP',
                              fontWeight: FontWeight.bold)),
                    )
                  : buildUnSelectedTabBar("掲載コメント"),
            ),
            Tab(
              child: _tabIndex == 2
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("サービス内容",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontFamily: 'NotoSansJP',
                              fontWeight: FontWeight.bold)),
                    )
                  : buildUnSelectedTabBar("サービス内容"),
            ),
            Tab(
              child: _tabIndex == 3
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("シフト",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontFamily: 'NotoSansJP',
                              fontWeight: FontWeight.bold)),
                    )
                  : buildUnSelectedTabBar("シフト"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(), //Disable Horizontal Swipe
        controller: _tabController,
        children: [
          BannerImage(), //Banner

          ShiftDescription(), //Shift Description

          ShiftService(), //Shift Service

          ShiftTiming(), //Shift Timing
        ],
      ),
    );
  }
}
