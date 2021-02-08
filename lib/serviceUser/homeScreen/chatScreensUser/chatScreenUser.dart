import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class ChatScreenUser extends StatefulWidget {
  @override
  _ChatScreenUserState createState() => _ChatScreenUserState();
}

class _ChatScreenUserState extends State<ChatScreenUser>
    with SingleTickerProviderStateMixin {
  bool _value = false;
  int _tabIndex = 0;
  TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool userIsOnline = true;

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
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Text(
        "$title",
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Oxygen',
            fontWeight: FontWeight.bold),
      ),
    );
  }

  void _handleTabSelection() {
    setState(() {
      _tabIndex = _tabController.index;
      print("Tab Index : $_tabIndex");
      setState(() {
        switch (_tabIndex) {
          case 0:
            return NavigationRouter.switchToServiceUserNoticeScreen(
                context);
            break;
          case 1:
            return NavigationRouter.switchToServiceUserChatScreen(context);
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.11),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey[200],
                offset: Offset(0, 0.0),
                blurRadius: 8.0,
              )
            ]),
            child: AppBar(
              backgroundColor: Colors.grey[100],
              elevation: 0.0,
              automaticallyImplyLeading: false,
              title: Text(
                'メッセージ',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Oxygen',
                    fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  NavigationRouter.switchToServiceUserBottomBar(context);
                },
                color: Colors.black,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
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
                onTap: (index) {


                },
                dragStartBehavior: DragStartBehavior.start,
                tabs: [
                  Tab(
                    child: _tabIndex == 0
                        ? Text(
                            "お知らせ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Oxygen',
                                fontWeight: FontWeight.bold),
                          )
                        : buildUnSelectedTabBar("お知らせ"),
                  ),
                  Tab(
                    child: _tabIndex == 1
                        ? Text("チャット",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Oxygen',
                                fontWeight: FontWeight.bold))
                        : buildUnSelectedTabBar("チャット"),
                  ),
                ],
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400],
                      offset: Offset(2.0, 2.0),
                      blurRadius: 8.0,
                    )
                  ]),
                  child: TextFormField(
                    autofocus: false,
                    textInputAction: TextInputAction.search,
                    decoration: new InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'キーワードで検索',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search_rounded,
                              color: Colors.grey, size: 30),
                          onPressed: () {},
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
            Container(
              child: new ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print('Row on tap');
                        print('Item index : $index');
                        NavigationRouter.switchToServiceUserChatListScreen(
                            context);
                      },
                      splashColor: Colors.lime,
                      child: Card(
                        elevation: 0.0,
                        color: Colors.grey[100],
                        semanticContainer: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Stack(
                                overflow: Overflow.visible,
                                children: [
                                  new Container(
                                      width: 60.0,
                                      height: 60.0,
                                      decoration: new BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image: new AssetImage(
                                              'assets/images_gps/logo.png'),
                                        ),
                                      )),
                                  userIsOnline
                                      ? Visibility(
                                          visible: userIsOnline,
                                          child: Positioned(
                                            right: -20.0,
                                            top: 45,
                                            left: 10.0,
                                            child: InkWell(
                                              onTap: () {},
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 8,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.green[400],
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
                                                backgroundColor:
                                                    Colors.grey[500],
                                                radius: 6,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.green[400],
                                                  radius: 5,
                                                  child: Container(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "店舗名",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(height: 8),
                                  Text("SAR",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("3時午後",
                                      style: TextStyle(
                                          color: Colors.grey[300],
                                          fontSize: 12)),
                                  SizedBox(height: 8),
                                  CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.lime,
                                      child: Text(
                                        '0',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Oxygen',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(height: 20),
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
        ),
      ),
    );
  }
}
