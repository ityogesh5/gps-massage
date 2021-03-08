import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/favorite.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/pastReservations.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/reservationStatus.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class ReservationAndFavourite extends StatefulWidget {
  @override
  _ReservationAndFavouriteState createState() =>
      _ReservationAndFavouriteState();
}

class _ReservationAndFavouriteState extends State<ReservationAndFavourite>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
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
            fontFamily: 'Oxygen',
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
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          padding:
              EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            NavigationRouter.switchToServiceUserBottomBar(context);
          },
        ),
        title: Text(
          '予約 & お気に入り',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Oxygen',
              fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),

        // backgroundColor: Color.fromRGBO(243, 249, 250, 1),

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
                        "予約状況",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : buildUnSelectedTabBar("予約状況"),
            ),
            Tab(
              child: _tabIndex == 1
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("過去の予約",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.bold)),
                    )
                  : buildUnSelectedTabBar("過去の予約"),
            ),
            Tab(
              child: _tabIndex == 2
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("お気に入り",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontFamily: 'Oxygen',
                              fontWeight: FontWeight.bold)),
                    )
                  : buildUnSelectedTabBar("お気に入り"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(), //Disable Horizontal Swipe
        controller: _tabController,
        children: [
          ReservationStatus(),
          PastReservations(),
          Favorite(),
        ],
      ),
    );
  }
}
