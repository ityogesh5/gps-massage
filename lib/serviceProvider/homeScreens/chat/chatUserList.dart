import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:googleapis/servicemanagement/v1.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/chat.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/db.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/chatData.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/message.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/chat_item_screen.dart';
import 'package:provider/provider.dart';

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
  DB db = DB();
  UserDetail userDetail;
  List<UserDetail> contactList = List<UserDetail>();
  int status = 0;
  List<ChatData> chatData = List<ChatData>();
  Stream<QuerySnapshot> _stream;

  void initState() {
    super.initState();
    getChatDetailsFromFirebase();
  }

  getChatDetailsFromFirebase() {
    db.getContactsofUser("3MFwceiZ47ZujApwRAdOvMN1BOD2").then((value) {
      userDetail = value;
      db.getUserDetilsOfContacts(userDetail.contacts).then((value) {
        contactList.addAll(value);
        // final chats = Provider.of<Chat>(context).chats;
        Chat().fetchChats(contactList).then((value) {
          chatData.addAll(value);

          setState(() {
            status = 1;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return status == 0
        ? Center(child: CircularProgressIndicator())
        : Padding(
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
                                  color: Color.fromRGBO(225, 225, 225, 1),
                                  size: 30),
                              onPressed: () {},
                            ),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: contactList.length,
                      itemBuilder: (context, index) {
                        Message lastMessage = chatData[index].messages[0];
                        DateTime lastMessageDate =
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(lastMessage.timeStamp));
                        _stream = db.getSnapshotsWithLimit(
                            chatData[index].groupId, 1);
                        return buildChatDetails(
                            index, lastMessage, lastMessageDate, _stream);
                      }),
                ),
              ],
            ),
          );
  }

  InkWell buildChatDetails(
      int index, Message lastMessage, DateTime lastMessageDate, Stream stream) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatItemScreen(chatData[index])));
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
                      child: CachedNetworkImage(
                        width: 50.0,
                        height: 60.0,
                        fit: BoxFit.cover,
                        imageUrl: contactList[index].imageUrl,
                        placeholder: (context, url) => SpinKitWave(
                            size: 20.0, color: ColorConstants.buttonColor),
                      ),
                    ),
                  ),
                  contactList[index].isOnline
                      ? Positioned(
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
                        )
                      : Positioned(
                          right: -30.0,
                          top: 35,
                          left: 10.0,
                          child: InkWell(
                            onTap: () {},
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[500],
                              radius: 6,
                              child: CircleAvatar(
                                backgroundColor: Colors.green[400],
                                radius: 5,
                                child: Container(),
                              ),
                            ),
                          ),
                        )
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
                  Text(
                    "${contactList[index].username}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 4),
                  StreamBuilder(
                    stream: stream,
                    builder: (context, snapshots) {
                      if (snapshots.connectionState == ConnectionState.waiting)
                        return Container(height: 0, width: 0);
                      else {
                        if (snapshots.data.documents.isNotEmpty) {
                          final snapshot = snapshots.data.documents[0];
                          Message newMsg = Message.fromMap(snapshot.data());
                          _addNewMessages(newMsg, chatData[index]);
                          return Row(
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
                                  : Flexible(
                                      child: Text(newMsg.content,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  153, 153, 153, 1),
                                              fontSize: 10),
                                          textAlign: TextAlign.left),
                                    ),
                            ],
                          );
                        } else
                          return Container(height: 0, width: 0);
                      }
                    },
                  ),
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
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "${lastMessageDate.year}/${lastMessageDate.month}/${lastMessageDate.day}",
                    style: TextStyle(color: Colors.grey[300], fontSize: 12)),
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
            ),
          ],
        ),
      ),
    );
  }

  // add new messages to ChatData and update unread count
  void _addNewMessages(Message newMsg, ChatData chatData) {
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;
    if (chatData.messages.isEmpty ||
        newMsg.sendDate.isAfter(chatData.messages[0].sendDate)) {
      chatData.addMessage(newMsg);

      if (newMsg.fromId != chatData.userId) {
        chatData.unreadCount++;

        // play notification sound
        // if(widget.initChatData.messages.isNotEmpty && widget.initChatData.messages[0].sendDate != newMsg.sendDate)
        // if(isIos)
        //   Utils.playSound('mp3/notificationIphone.mp3');
        // else Utils.playSound('mp3/notificationAndroid.mp3');

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Provider.of<Chat>(context, listen: false)
              .bringChatToTop(chatData.groupId);
          setState(() {});
        });
      }
    }
  }
}
