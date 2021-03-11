import 'package:flutter/material.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class ChatUserList extends StatefulWidget {
  @override
  _ChatUserListState createState() => _ChatUserListState();
}

class _ChatUserListState extends State<ChatUserList> {
  bool _value = false;
  int _tabIndex = 0;
  TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool userIsOnline = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      hintText: '検索',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search_rounded,
                            color: Color.fromRGBO(225, 225, 225, 1), size: 30),
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
                      NavigationRouter.switchToServiceProviderChatHistoryScreen(
                          context);
                    },
                    splashColor: Colors.lime,
                    child: Card(
                      elevation: 0.0,
                    //  color: Colors.grey[100],
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
                                              backgroundColor: Colors.grey[500],
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
                                  "AKさん",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 4),
                                Text("無料で提供者とチャットすることが可能 。。。",
                                    style: TextStyle(
                                        color: Color.fromRGBO(153, 153, 153, 1),
                                        fontSize: 10),
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
                                        color: Colors.grey[300], fontSize: 12)),
                                SizedBox(height: 8),
                                CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.lime,
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                          fontSize: 12,
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
    );
  }
}
