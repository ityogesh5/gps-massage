import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class ProviderInitialTutorial extends StatefulWidget {
  @override
  _ProviderInitialTutorialState createState() =>
      _ProviderInitialTutorialState();
}

class _ProviderInitialTutorialState extends State<ProviderInitialTutorial> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: tutorialBottomNavigationBar(),
        body: SafeArea(
          bottom: false,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                currentPage = page;
              });
            },
            controller: pageController,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images_gps/provider_tutorial_1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                //color: Colors.deepPurple,
                child: FutureBuilder(
                    future: rootBundle.loadString(
                        "assets/provider_tutorial/service_provider_page_1.md"),
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
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: 'NotoSansJP')));
                      }
                      return Center(
                        child: SpinKitDoubleBounce(color: Colors.limeAccent),
                      );
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images_gps/provider_tutorial_2.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              padding: EdgeInsets.all(0.0),
                              icon: new Icon(
                                Icons.navigate_before,
                                color: Colors.black,
                                size: 40.0,
                              ),
                              onPressed: () {
                                if (currentPage == 1) {
                                  pageController.animateToPage(0,
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.easeInOut);
                                }
                              }),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: rootBundle.loadString(
                              "assets/provider_tutorial/service_provider_page_2.md"),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return Markdown(
                                  data: snapshot.data,
                                  styleSheet: MarkdownStyleSheet.fromTheme(
                                          Theme.of(context))
                                      .copyWith(
                                          p: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontFamily: 'NotoSansJP')));
                            }
                            return Center(
                              child:
                                  SpinKitDoubleBounce(color: Colors.limeAccent),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  tutorialBottomNavigationBar() {
    return currentPage == 0
        ? Container(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.90,
            margin: EdgeInsets.all(8.0),
            color: Colors.transparent,
            child: RaisedButton(
              elevation: 0.0,
              textColor: Colors.white60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.lime,
              onPressed: () {
                pageController.animateToPage(1,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '次へ',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'NotoSansJP',
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
            ),
          )
        : Container(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.90,
            margin: EdgeInsets.all(8.0),
            color: Colors.transparent,
            child: RaisedButton(
              elevation: 0.0,
              textColor: Colors.white60,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.lime,
              onPressed: () {
                NavigationRouter.switchToProviderLogin(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'はじめる',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'NotoSansJP',
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
            ),
          );
  }
}
