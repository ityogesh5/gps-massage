import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class IntroTermsAndPolicy extends StatefulWidget {
  @override
  _IntroTermsAndPolicyState createState() => _IntroTermsAndPolicyState();
}

class _IntroTermsAndPolicyState extends State<IntroTermsAndPolicy> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(243, 249, 250, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            '利用規約とプライバシーポリシー',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.lime,
            onTap: (index) {},
            tabs: [
              Tab(
                child: Text(
                  "セラピスト",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  "サービス利用者",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            //First Tab Bar
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
                                          .copyWith(fontSize: 12.0)));
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
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
                                          .copyWith(fontSize: 12.0)));
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ),
        bottomNavigationBar: buildBottomBar(),
      ),
    );
  }

  Widget buildBottomBar() {
    return Container(
      height: 120,
      color: Color.fromRGBO(243, 249, 250, 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  child: Checkbox(
                    activeColor: Colors.lime,
                    checkColor: Colors.lime,
                    value: _value,
                    onChanged: (bool newValue) {
                      setState(() {
                        _value = newValue;
                      });
                    },
                  ),
                ),
              ),
              Text(
                '上記の利用規約に同意する',
                style: TextStyle(fontSize: 14, fontFamily: 'Open Sans'),
              )
            ],
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.90,
            child: RaisedButton(
              textColor: Colors.white60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: _value ? Colors.lime : Colors.lime[200],
              onPressed: () {
                if (_value) {
                  NavigationRouter.switchToUserDefineScreen(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('同意',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(255, 255, 255, 1))),
              ),
            ),
          ),
        ],
      ),
    );
  }

/* Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');

    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }

    return Color(int.parse(hexColor, radix: 16));
  }*/
}
