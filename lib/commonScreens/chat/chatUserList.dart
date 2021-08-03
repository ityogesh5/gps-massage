import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gps_massageapp/commonScreens/chat/chat_item_screen.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/chat.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/db.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/chatData.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/message.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';
import 'package:gps_massageapp/customLibraryClasses/searchDelegateClass/CustomSearchPage.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUserList extends StatefulWidget {
  @override
  _ChatUserListState createState() => _ChatUserListState();
}

class _ChatUserListState extends State<ChatUserList>
    with WidgetsBindingObserver {
  bool _value = false;
  int _tabIndex = 0;
  TabController _tabController;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool userIsOnline = true;
  DB db = DB();
  UserDetail userDetail;
  List<UserDetail> contactList = List<UserDetail>();
  List<String> userContacts = List<String>();
  int status = 0;
  List<ChatData> chatData = List<ChatData>();
  var userName, userEmail, userChat;
  var isOnline = false;
  AppLifecycleState appState;
  int totalContactLength = 0;
  int initialLoadedPage = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getChatDetailsFromFirebase();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // contactList.clear();
      // chatData.clear();
      // getChatDetailsFromFirebase();
    }
  }

  getChatDetailsFromFirebase() {
    db.getContactsofUser(HealingMatchConstants.fbUserId).then((value) {
      userDetail = value;
      totalContactLength = value.contacts.length;
      if (value.contacts.length != 0) {
        if (value.contacts.length >= 10) {
          initialLoadedPage = 10;
          db
              .getUserDetilsOfContacts(userDetail.contacts.sublist(0, 10))
              .then((value) {
            fetchChatDetails(value);
          });
        } else {
          initialLoadedPage = totalContactLength;
          db.getUserDetilsOfContacts(userDetail.contacts).then((value) {
            fetchChatDetails(value);
          });
        }
      } else {
        setState(() {
          status = 1;
        });
      }
    });
  }

  void fetchChatDetails(List<UserDetail> value) {
    contactList.addAll(value);
    //final chats = Provider.of<Chat>(context).chats;

    Chat().fetchChats(value).then((value) {
      chatData.addAll(value);
      for (int i = 0; i < chatData.length; i++) {
        try {
          userName = chatData[i].peer.username;
          userEmail = chatData[i].peer.email;
          userChat = contactList[i];
        } catch (e) {
          print("exception in chatData");
        }
      }
      setState(() {
        status = 1;
      });
    });
    // chatData.sort((a,b)=>a.messages.)
  }

  void loadMoreChats() async {
    try {
      if (!isLoading) {
        setState(() {
          isLoading = true;
          if (totalContactLength != initialLoadedPage) {
            if (totalContactLength >= initialLoadedPage + 10) {
              db
                  .getUserDetilsOfContacts(userDetail.contacts
                      .sublist(initialLoadedPage, initialLoadedPage + 10))
                  .then((value) {
                setState(() {
                  isLoading = false;

                  if (this.mounted) {
                    initialLoadedPage = initialLoadedPage + 10;
                    fetchChatDetails(value);
                  }
                });
              });
            } else {
              db
                  .getUserDetilsOfContacts(
                      userDetail.contacts.sublist(initialLoadedPage))
                  .then((value) {
                setState(() {
                  isLoading = false;

                  if (this.mounted) {
                    initialLoadedPage = totalContactLength;
                    fetchChatDetails(value);
                  }
                });
              });
            }
          }
        });
      }
    } catch (e) {
      print('Exception more data' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return status == 0
        ? Center(child: CircularProgressIndicator())
        : LazyLoadScrollView(
            isLoading: isLoading,
            onEndOfPage: () => loadMoreChats(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: contactList.length == 0
                  ? Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0)),
                                  border: Border.all(
                                      color: Color.fromRGBO(217, 217, 217, 1)),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /* Row(
                              children: [
                                Text(
                                  'ユーザーチャットの情報！',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NotoSansJP',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),*/
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: new Container(
                                              width: 80.0,
                                              height: 80.0,
                                              decoration: new BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12),
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: new AssetImage(
                                                        'assets/images_gps/appIcon.png')),
                                              )),
                                        ),
                                        SizedBox(width: 20),
                                        Flexible(
                                          child: Text(
                                            HealingMatchConstants.isProvider
                                                ? "利用者からの予約リクエストを承認した後メッセージのやり取りができます。"
                                                : '予約が完了した後にメッセージの\nやり取りができます。',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'NotoSansJP',
                                                fontWeight:
                                                    FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                                onTap: () {
                                  print('On tap search filter');
                                  showSearch(
                                    context: context,
                                    delegate: CustomSearchPage<ChatData>(
                                      onQueryUpdate: (s) => print(s),
                                      items: chatData,
                                      barTheme: ThemeData(
                                          primaryColor:
                                              ColorConstants.buttonColor,
                                          buttonColor: Colors.white),
                                      searchLabel: 'チャットユーザーを検索',
                                      suggestion: Center(
                                        child: Text('ユーザー名で検索します。'),
                                      ),
                                      failure: Center(
                                        child: Text('ユーザーが見つかりません！'),
                                      ),
                                      filter: (chatData) => [
                                        chatData.peer.username,
                                      ],
                                      builder: (chatData) => ListTile(
                                        title: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatItemScreen(chatData,
                                                          bringChatToTop:
                                                              updateFromChatItemScreen),
                                                ),
                                              );
                                            },
                                            child:
                                                Text(chatData.peer.username)),
                                        subtitle: Text(""),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(6.0),
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    width: MediaQuery.of(context).size.height *
                                        0.85,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color.fromRGBO(255, 255, 255, 1),
                                            Color.fromRGBO(255, 255, 255, 1),
                                          ]),
                                      shape: BoxShape.rectangle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[400],
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 8.0,
                                        )
                                      ],
                                      border: Border.all(
                                        color: Colors.grey[500],
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color.fromRGBO(228, 228, 228, 1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '検索',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  225, 225, 225, 1),
                                              fontSize: 14,
                                              fontFamily: 'NotoSansJP'),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          child: Image.asset(
                                            "assets/images_gps/search.png",
                                            color: Color.fromRGBO(
                                                225, 225, 225, 1),
                                          ),
                                          onTap: () {},
                                        ),
                                      ],
                                    ))),
                            SizedBox(height: 15),
                          ],
                        ),
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: chatData.length,
                              itemBuilder: (context, index) {
                                //  isOnline = contactList[index].isOnline;
                                HealingMatchConstants.isUserOnline = isOnline;
                                return buildChatDetails(index);
                              }),
                        ),
                        totalContactLength > initialLoadedPage
                            ? isLoading
                                ? SpinKitPulse(
                                    color: ColorConstants.buttonColor,
                                  )
                                : InkWell(
                                    onTap: () {
                                      loadMoreChats();
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.grey[400]),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(Icons.add),
                                        )),
                                  )
                            : Container()
                      ],
                    ),
            ),
          );
  }

  InkWell buildChatDetails(int index) {
    String formatTime(Message message) {
      int hour = message.sendDate.hour;
      int min = message.sendDate.minute;
      String hRes = hour <= 9 ? '0$hour' : hour.toString();
      String mRes = min <= 9 ? '0$min' : min.toString();
      return '$hRes時$mRes分';
    }

    Stream<QuerySnapshot> _stream;
    Message lastMessage;
    DateTime lastMessageDate;
    if (chatData[index].messages.length != 0) {
      lastMessage = chatData[index].messages[0];
      lastMessageDate =
          DateTime.fromMillisecondsSinceEpoch(int.parse(lastMessage.timeStamp));
      //_stream = db.getSnapshotsWithLimit(chatData[index].groupId, 2);
    }

    return InkWell(
      onTap: () {
        if (chatData[index].unreadCount != 0) {
          setState(() {
            chatData[index].unreadCount = 0;
          });
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatItemScreen(chatData[index],
                    bringChatToTop: updateFromChatItemScreen)));
      },
      child: Card(
        elevation: 0.0,
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  ClipOval(
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.white,
                      child: (contactList[index].imageUrl != '' &&
                              contactList[index].imageUrl != null)
                          ? CachedNetworkImage(
                              width: 50.0,
                              height: 60.0,
                              fit: BoxFit.cover,
                              imageUrl: contactList[index].imageUrl,
                              placeholder: (context, url) => SpinKitWave(
                                  size: 20.0,
                                  color: ColorConstants.buttonColor),
                            )
                          : Image.asset(
                              'assets/images_gps/placeholder_image.png',
                              width: 50.0,
                              height: 60.0,
                              color: Colors.black,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('USERS')
                          .doc(contactList[index].id)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Container(height: 0, width: 0);
                        else if (snapshot.data['isOnline'] != null &&
                            snapshot.data['isOnline']) {
                          return Visibility(
                            visible: snapshot.data['isOnline'],
                            child: Positioned(
                              right: -20.0,
                              top: 35,
                              left: 10.0,
                              child: InkWell(
                                onTap: () {},
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 8,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green[400],
                                    radius: 6,
                                    child: Container(),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else
                          return Container();
                      }),

                  /*  Visibility(
                    visible: isOnline,
                    child: Positioned(
                      right: -20.0,
                      top: 35,
                      left: 10.0,
                      child: InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 8,
                          child: CircleAvatar(
                            backgroundColor: Colors.green[400],
                            radius: 6,
                            child: Container(),
                          ),
                        ),
                      ),
                    ),
                  ) */
                ],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        contactList[index].username.length > 15
                            ? contactList[index].username.substring(0, 14) +
                                "..."
                            : "${contactList[index].username}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Spacer(),
                      lastMessageDate != null
                          ? Text(formatTime(lastMessage),
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 12))
                          : Container()
                    ],
                  ),
                  SizedBox(height: 4),
                  StreamBuilder(
                    stream:
                        db.getSnapshotsWithLimit(chatData[index].groupId, 2),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState == ConnectionState.waiting)
                        return Container(height: 0, width: 0);
                      else {
                        if (snapshots.data.documents.isNotEmpty) {
                          if (snapshots.data.documents.length > 1) {
                            final snapshot1 = snapshots.data.documents[1];
                            Message newMsg1 = Message.fromMap(snapshot1.data());
                            _addNewMessages(newMsg1, chatData[index]);
                          }
                          final snapshot = snapshots.data.documents[0];
                          Message newMsg = Message.fromMap(snapshot.data());
                          _addNewMessages(newMsg, chatData[index]);

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              newMsg.type == MessageType.Media
                                  ? Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            newMsg.mediaType == MediaType.Photo
                                                ? Icons.photo_camera
                                                : Icons.videocam,
                                            size: newMsg.mediaType ==
                                                    MediaType.Photo
                                                ? 15
                                                : 20,
                                            color:
                                                Colors.white.withOpacity(0.45),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                              newMsg.mediaType ==
                                                      MediaType.Photo
                                                  ? 'Photo'
                                                  : 'Video',
                                              style: kChatItemSubtitleStyle)
                                        ],
                                      ),
                                    )
                                  : Text(
                                      newMsg.content.length < 20
                                          ? newMsg.content
                                          : newMsg.content.substring(0, 20) +
                                              "...",
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                          fontSize: 10),
                                      textAlign: TextAlign.left),
                              Spacer(),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    chatData[index].unreadCount != 0
                                        ? CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.lime,
                                            child: Text(
                                              '${chatData[index].unreadCount}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                        : Container()
                                    // : Container(),
                                  ],
                                ),
                              )
                            ],
                          );
                        } else
                          return Container(height: 0, width: 0);
                      }
                    },
                  )
                  /*  : Container() */
                  /* chatData[index].messages.length != 0
                      ? Text("${lastMessage.content}",
                          style: TextStyle(
                              color: Color.fromRGBO(153, 153, 153, 1),
                              fontSize: 10),
                          textAlign: TextAlign.left)
                      : Container(), */
                ],
              ),
            ),
            /*  lastMessageDate != null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(formatTime(lastMessage),
                          style:
                              TextStyle(color: Colors.grey[300], fontSize: 12)),
                      SizedBox(height: 8),
                      chatData[index].unreadCount != 0
                          ? CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.lime,
                              child: Text(
                                '${chatData[index].unreadCount}',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))
                          : Container(),
                      SizedBox(height: 20),
                    ],
                  )
                : Container() */
          ],
        ),
      ),
    );
  }

  // add new messages to ChatData and update unread count
  void _addNewMessages(Message newMsg, ChatData chatData) {
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;
    if ((chatData.messages.isEmpty ||
            newMsg.sendDate.isAfter(chatData.messages[0].sendDate)) &&
        !chatData.messageId.contains(newMsg.fromId + newMsg.timeStamp)) {
      chatData.addMessage(newMsg);
      chatData.messageId.add(newMsg.fromId + newMsg.timeStamp);

      if (newMsg.fromId != chatData.userId) {
        chatData.unreadCount++;

        // play notification sound
        // if(widget.initChatData.messages.isNotEmpty && widget.initChatData.messages[0].sendDate != newMsg.sendDate)
        // if(isIos)
        //   Utils.playSound('mp3/notificationIphone.mp3');
        // else Utils.playSound('mp3/notificationAndroid.mp3');

      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        /*   Provider.of<Chat>(context, listen: false)
              .bringChatToTop(chatData.groupId); */
        bringChatToTop(chatData.groupId);
        setState(() {});
      });
    } else if (!chatData.messageId.contains(newMsg.fromId + newMsg.timeStamp) &&
        newMsg.fromId != HealingMatchConstants.fbUserId) {
      //  chatData.addMessage(newMsg);
      chatData.messages.insert(1, newMsg);
      chatData.messageId.add(newMsg.fromId + newMsg.timeStamp);

      if (newMsg.fromId != chatData.userId) {
        chatData.unreadCount++;
        bringChatToTop(chatData.groupId);
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        /*  Provider.of<Chat>(context, listen: false)
              .bringChatToTop(chatData.groupId); */
        bringChatToTop(chatData.groupId);
        setState(() {});
      });
    }
  }

  updateFromChatItemScreen(String groupId) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /*  Provider.of<Chat>(context, listen: false)
              .bringChatToTop(chatData.groupId); */
      bringChatToTop(groupId);
      setState(() {});
    });
  }

  // updates the order of chats when a new message is recieved
  void bringChatToTop(String groupId) {
    if (chatData.isNotEmpty && chatData[0].groupId != groupId) {
      // bring latest interacted contact and chat to top
      var ids = groupId.split('-');
      var peerId = ids
          .firstWhere((element) => element != HealingMatchConstants.fbUserId);

      var cIndex = contactList.indexWhere((element) => element.id == peerId);
      var userDetail = contactList[cIndex];
      contactList.removeAt(cIndex);
      contactList.insert(0, userDetail);

      db.updateUserInfoViaTransactions(HealingMatchConstants.fbUserId, peerId);

      var index = chatData.indexWhere((element) => element.groupId == groupId);
      var temp = chatData[index];
      chatData.removeAt(index);
      chatData.insert(0, temp);
      //setState(() {});
    }
  }
}
