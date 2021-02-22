/* import 'package:flutter/material.dart';
import 'package:gps_massageapp/models/customModels/Global.dart';
import 'package:gps_massageapp/models/customModels/User.dart';

void main() => runApp(MySocketApp());

class MySocketApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MySocketApp> {
  bool _connectedToSocket;
  String _errorConnectMessage;
  List<User> _chatUsers;

  @override
  void initState() {
    super.initState();
//    _chatUsers = G.getUsersFor(G.loggedInUser);
    _connectedToSocket = false;
    _errorConnectMessage = 'Connecting...';
    _connectSocket();
  }

  _connectSocket() {
    Future.delayed(Duration(seconds: 2), () async {
      //print("Connecting Logged In User: ${G.loggedInUser.name}, ID: ${G.loggedInUser.id}");
      G.initSocket();
      //await G.socketUtils.initSocket(G.loggedInUser);
      G.socketUtils.connectToSocket();
      //G.socketUtils.setConnectListener(onConnect);
      //G.socketUtils.setOnDisconnectListener(onDisconnect);
      // G.socketUtils.setOnErrorListener(onError);
      //G.socketUtils.setOnConnectionErrorListener(onConnectError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: TextTheme(
            title: TextStyle(color: Colors.white),
            headline: TextStyle(color: Colors.white),
            subtitle: TextStyle(color: Colors.white),
            subhead: TextStyle(color: Colors.white),
            body1: TextStyle(color: Colors.white),
            body2: TextStyle(color: Colors.white),
            button: TextStyle(color: Colors.white),
            caption: TextStyle(color: Colors.white),
            overline: TextStyle(color: Colors.white),
            display1: TextStyle(color: Colors.white),
            display2: TextStyle(color: Colors.white),
            display3: TextStyle(color: Colors.white),
            display4: TextStyle(color: Colors.white),
          ),
          buttonTheme: ButtonThemeData(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              disabledColor: Colors.lightBlueAccent.withOpacity(0.5),
              buttonColor: Colors.lightBlue,
              splashColor: Colors.cyan)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Adhara Socket.IO example'),
          backgroundColor: Colors.black,
          elevation: 0.0,
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  "Default Connection",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onConnect(data) {
    print('Connected $data');
    setState(() {
      _connectedToSocket = true;
    });
  }

  onConnectError(data) {
    print('onConnectError $data');
    setState(() {
      _connectedToSocket = false;
      _errorConnectMessage = 'Failed to Connect';
    });
  }

  onConnectTimeout(data) {
    print('onConnectTimeout $data');
    setState(() {
      _connectedToSocket = false;
      _errorConnectMessage = 'Connection timedout';
    });
  }

  onError(data) {
    print('onError $data');
    setState(() {
      _connectedToSocket = false;
      _errorConnectMessage = 'Connection Failed';
    });
  }

  onDisconnect(data) {
    print('onDisconnect $data');
    setState(() {
      _connectedToSocket = false;
      _errorConnectMessage = 'Disconnected';
    });
  }
}
 */