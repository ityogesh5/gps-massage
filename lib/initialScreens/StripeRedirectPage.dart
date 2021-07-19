import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

final flutterWebViewPlugin = FlutterWebviewPlugin();
// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print('JScriptWeb Message : ${message.message}');
      }),
].toSet();

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

final _scaffoldKey = GlobalKey<ScaffoldState>();

class StripeRegisterPage extends StatefulWidget {
  @override
  createState() => _StripeRegisterPageState();
}

class _StripeRegisterPageState extends State<StripeRegisterPage> {
  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.close();
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _canGoBackStripe,
      child: WebviewScaffold(
        key: _scaffoldKey,
        url: HealingMatchConstants.stripeRedirectURL,
        javascriptChannels: null,
        mediaPlaybackRequiresUserGesture: false,
        userAgent: kAndroidUserAgent,
        clearCache: true,
        clearCookies: true,
        withJavascript: true,
        enableAppScheme: true,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              flutterWebViewPlugin.close();
              NavigationRouter.switchToServiceProviderBottomBar(context);
            },
          ),
          centerTitle: true,
          title: const Text(
            'ストライプ登録',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
                onPressed: () {
                  flutterWebViewPlugin.close();
                  NavigationRouter.switchToServiceProviderBottomBar(context);
                },
              ),
              InkWell(
                onTap: () {
                  flutterWebViewPlugin.close();
                  NavigationRouter.switchToServiceProviderBottomBar(context);
                },
                child: new Text(
                  'アプリに戻る',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSansJP',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _canGoBackStripe() async {
    flutterWebViewPlugin.canGoBack().then((value) {
      if (value) {
        flutterWebViewPlugin.goBack();
        print('Can go back !!');
        return true;
      } else {
        flutterWebViewPlugin.goBack();
        print('Can go back !!');
        return true;
      }
    });
    return false;
  }
}
