import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/serviceUser/APIProviderCalls/ServiceUserAPIProvider.dart';

final flutterWebViewPlugin = FlutterWebviewPlugin();
// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print('JS Message : ${message.message}');
      }),
].toSet();

// On destroy stream
StreamSubscription _onDestroy;

// On urlChanged stream
StreamSubscription<String> _onUrlChanged;

// On urlChanged stream
StreamSubscription<WebViewStateChanged> _onStateChanged;

StreamSubscription<WebViewHttpError> _onHttpError;

StreamSubscription<double> _onProgressChanged;

final _scaffoldKey = GlobalKey<ScaffoldState>();

final _history = [];

class DeepLinkTestFlutter extends StatefulWidget {
  @override
  State createState() {
    return _DeepLinkTestFlutterState();
  }
}

class _DeepLinkTestFlutterState extends State<DeepLinkTestFlutter> {
  final _key = UniqueKey();
  var redirectUrl;

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        /*ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Webview Destroyed')));*/
        print('Webview destroyed..!!');
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          _history.add('onUrlChanged: $url');
        });
      }
    });

    _onProgressChanged =
        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
      if (mounted) {
        setState(() {
          _history.add('onProgressChanged: $progress');
        });
      }
    });

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        setState(() {
          _history.add('onStateChanged: ${state.type} ${state.url}');
        });
      }
    });

    _onHttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
      if (mounted) {
        setState(() {
          _history.add('onHttpError: ${error.code} ${error.url}');
        });
      }
    });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onProgressChanged.cancel();

    flutterWebViewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Click me !!'),
            onPressed: () {
              _getStripeRegisterURL(context);
            },
          ),
        ),
      ),
    );
  }

  void _getStripeRegisterURL(BuildContext context) async {
    ProgressDialogBuilder.showOverlayLoader(context);
    try {
      ServiceUserAPIProvider.getStripeRegisterURL(context).then((value) {
        if (value.status == 'success') {
          HealingMatchConstants.stripeRedirectURL = value.message.url;
          ProgressDialogBuilder.hideLoader(context);
        }
      }).catchError((onError) {
        print('Stripe register error : ${onError.toString()}');
        ProgressDialogBuilder.hideLoader(context);
      });
    } catch (e) {
      print('Stripe redirect URL Exception : ${e.toString()}');
      ProgressDialogBuilder.hideLoader(context);
    }
  }
}

class WebViewContainer extends StatefulWidget {
  @override
  createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: HealingMatchConstants.stripeRedirectURL,
      javascriptChannels: jsChannels,
      mediaPlaybackRequiresUserGesture: false,
      withJavascript: true,
      enableAppScheme: true,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
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
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                flutterWebViewPlugin.goBack();
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                flutterWebViewPlugin.goForward();
              },
            ),
            IconButton(
              icon: const Icon(Icons.autorenew),
              onPressed: () {
                flutterWebViewPlugin.reload();
              },
            ),
          ],
        ),
      ),
    );
  }
}
