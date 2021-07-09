import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/utils/StripeTest/model/PayoutModel.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../WebViewStripeTest.dart';

class DeepLinkTestFlutter extends StatefulWidget {
  @override
  State createState() {
    return _DeepLinkTestFlutterState();
  }
}

class _DeepLinkTestFlutterState extends State<DeepLinkTestFlutter> {
  final _key = UniqueKey();
  var redirectUrl;
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Click me !!'),
            onPressed: () {
              _getLink();
            },
          ),
        ),
      ),
    );
  }

  Future<StripePayOutVerifyFieldsModel> _getLink() async {
    StripePayOutVerifyFieldsModel _stripePayoutModel;
    ProgressDialogBuilder.showOverlayLoader(context);
    try {
      final url = 'http://106.51.49.160:9094/api/user/paymentOutAccounts';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2MTMwNTkyODZ9.vbtFi4s8AJiysPLNvyk-y8hrGWadZh7PMpD6Ab9Q3bA'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "email": 'anistan@nexware-global.com',
            "refresh_url": 'http://106.51.49.160:9094/reauth',
            "return_url": 'http://106.51.49.160:9094/return'
          }));
      final getTherapists = json.decode(response.body);
      _stripePayoutModel =
          StripePayOutVerifyFieldsModel.fromJson(getTherapists);
      print('More Response body : ${response.body}');
      if (response.statusCode == 200) {
        redirectUrl = _stripePayoutModel.message.url;
        print('Stripe redirect URL : $redirectUrl');
        HealingMatchConstants.stripeRedirectURL = redirectUrl;
        ProgressDialogBuilder.hideLoader(context);
        //launchStripe(redirectUrl);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => WebviewStripeTest()));

        /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewContainer(redirectUrl)));*/
      }
    } catch (e) {
      print('Stripe redirect URL : ${e.toString()}');
      ProgressDialogBuilder.hideLoader(context);
    }

    return _stripePayoutModel;
  }

  void launchStripe(var _launchUrl) {
    launch(_launchUrl.toString());
  }
}

class WebViewContainer extends StatefulWidget {
  final url;

  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();

// Reference to webview controller
  WebViewController _controller;

  _WebViewContainerState(this._url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Stripe Details Flow'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    gestureNavigationEnabled: true,
                    onWebViewCreated: (WebViewController webViewController) {
                      // Get reference to WebView controller to access it globally
                      _controller = webViewController;
                    },
                    javascriptChannels: <JavascriptChannel>[
                      // Set Javascript Channel to WebView
                      _extractDataJSChannel(context),
                    ].toSet(),
                    onPageStarted: (String url) {
                      print('Page started loading: $url');
                    },
                    onPageFinished: (String url) {
                      print('Page finished loading: $url');
                      // In the final result page we check the url to make sure  it is the last page.
                      if (url.contains('/return')) {
                        _controller.evaluateJavascript(
                            "(function(){Flutter.postMessage(window.document.body.outerHTML)})();");
                      }
                    },
                    initialUrl: _url)),
            /*Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Return to App'),
                ),
              ],
            ),*/
          ],
        ));
  }

  _keepRunning() {
    print('Web view started !!');
  }

  _keepStop() {
    print('Web view stopped !!');
  }

  JavascriptChannel _extractDataJSChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Flutter',
      onMessageReceived: (JavascriptMessage message) {
        String pageBody = message.message;
        print('page body: $pageBody');
      },
    );
  }
}
