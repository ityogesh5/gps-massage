import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProviderTutorial extends StatefulWidget {
  @override
  _ProviderTutorialState createState() => _ProviderTutorialState();
}

class _ProviderTutorialState extends State<ProviderTutorial> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: tutorialBottomNavigationBar(),
        floatingActionButton: tutorialBottomNavigationBar(),
        body: SafeArea(
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
                    image: AssetImage('assets/images_gps/provider_tutorial_1.png'),
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
                                                fontSize: 14.0,
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
                    image: AssetImage('assets/images_gps/provider_tutorial_2.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: FutureBuilder(
                    future: rootBundle.loadString(
                        "assets/provider_tutorial/service_provider_page_2.md"),
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
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: 'NotoSansJP')));
                      }
                      return Center(
                        child: SpinKitDoubleBounce(color: Colors.limeAccent),
                      );
                    }),
              ),
            ],
          ),
        ));
  }

  tutorialBottomNavigationBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50.0,
          width: 50.0,
          child: FloatingActionButton(
              elevation: 0.0,
              heroTag: 'back',
              child: new Icon(
                Icons.navigate_before,
                color: currentPage == 0 ? Colors.white : Colors.black,
                size: 40.0,
              ),
              backgroundColor: currentPage == 0
                  ? Colors.grey.withOpacity(0.75)
                  : Colors.white,
              onPressed: () {
                if (currentPage == 1) {
                  pageController.animateToPage(0,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                }
              }),
        ),
        SizedBox(width: 15.0),
        currentPage == 0
            ? Container(
                height: 50.0,
                width: 50.0,
                child: FloatingActionButton(
                    heroTag: 'next',
                    elevation: 0.0,
                    child: new Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                      size: 40.0,
                    ),
                    backgroundColor: Colors.white,
                    onPressed: () {
                      pageController.animateToPage(1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    }),
              )
            : Container(
                height: 50.0,
                width: 50.0,
                child: FloatingActionButton(
                    heroTag: 'ok',
                    elevation: 0.0,
                    child: new Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    backgroundColor: Colors.lime,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
      ],
    );
  }
}
