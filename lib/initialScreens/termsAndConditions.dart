import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class IntroTermsAndPolicy extends StatefulWidget {
  @override
  _IntroTermsAndPolicyState createState() => _IntroTermsAndPolicyState();
}

class _IntroTermsAndPolicyState extends State<IntroTermsAndPolicy>
    with SingleTickerProviderStateMixin {
  bool _value = false;
  int _tabIndex = 0;
  int _state = 0;
  TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Text(
        "$title",
        style: TextStyle(
            color: Colors.black,
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

  validateTermsAcceptStatus() {
    if (_value) {
      NavigationRouter.switchToUserDefineScreen(context);
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: ColorConstants.snackBarColor,
        content: Text('利用規約とプライバシーポリシーに同意してください。',
            style: TextStyle(fontFamily: 'NotoSansJP')),
        action: SnackBarAction(
            onPressed: () {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            },
            label: 'はい',
            textColor: Colors.white),
      ));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_state == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        _state = 1;
        DialogHelper.showNotificationDialog(context);
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Color.fromRGBO(243, 249, 250, 1),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5.0,
        automaticallyImplyLeading: false,
        title: Text(
          '利用規約とプライバシーポリシー',
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
                      "サービス利用者",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.bold),
                    )
                  : buildUnSelectedTabBar("サービス利用者"),
            ),
            Tab(
              child: _tabIndex == 1
                  ? Text("セラピスト",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.bold))
                  : buildUnSelectedTabBar("セラピスト"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(), //Disable Horizontal Swipe
        controller: _tabController,
        children: [
          //Service User Tab Bar
          Container(
            child: FutureBuilder(
                future: rootBundle
                    .loadString("assets/privacy_policy/service_user.md"),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Markdown(
                        data: snapshot.data,
                        styleSheet:
                            MarkdownStyleSheet.fromTheme(Theme.of(context))
                                .copyWith(
                                    p: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                            fontSize: 14.0,
                                            fontFamily: 'NotoSansJP')));
                  }
                  return Center(
                    child: SpinKitDoubleBounce(color: Colors.limeAccent),
                  );
                }),
          ),
          //Service Provider Tab Bar
          Container(
            child: FutureBuilder(
                future: rootBundle
                    .loadString("assets/privacy_policy/service_provider.md"),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Markdown(
                        data: snapshot.data,
                        styleSheet:
                            MarkdownStyleSheet.fromTheme(Theme.of(context))
                                .copyWith(
                                    p: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                            fontSize: 14.0,
                                            fontFamily: 'NotoSansJP')));
                  }
                  return Center(
                    child: SpinKitDoubleBounce(color: Colors.limeAccent),
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  Widget buildBottomBar() {
    return Container(
      height: 120,
      color: Colors.white,
      // color: Color.fromRGBO(243, 249, 250, 1),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: _value
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              _value = false;
                            });
                          },
                          child: Container(
                            height: 20.0,
                            width: 20.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorConstants.buttonColor,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstants.buttonColor,
                                    shape: BoxShape.circle,
                                  ),
                                )),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              _value = true;
                            });
                          },
                          child: Container(
                            height: 20.0,
                            width: 20.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey[400],
                              ),
                              // borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  '上記の利用規約に同意する',
                  style: TextStyle(fontSize: 14, fontFamily: 'NotoSansJP'),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.90,
            child: RaisedButton(
              elevation: 0.0,
              textColor: Colors.white60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: _value
                  ? ColorConstants.buttonColor
                  : Color.fromRGBO(217, 217, 217, 1),
              onPressed: () {
                validateTermsAcceptStatus();
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '同意',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'NotoSansJP',
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
