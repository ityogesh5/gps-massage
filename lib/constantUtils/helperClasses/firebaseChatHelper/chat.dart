import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/db.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/chatData.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/message.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';

class Chat with ChangeNotifier {
  String _userId = HealingMatchConstants.fbUserId;
  final db = DB();

  User _user;
  UserDetail _userDetails;
  List<String> _contacts = [];
  List<ChatData> _chats = [];

  String _imageUrl;
  bool _isLoading = true;

  bool get isLoading {
    return _isLoading;
  }

  User get getUser {
    return _user;
  }

  UserDetail get userDetails {
    return _userDetails;
  }

  String get imageUrl {
    return _imageUrl;
  }

  void setImageUrl(String url) {
    _imageUrl = url;
  }

  String get getUserId {
    return _userId;
  }

  List<dynamic> get getContacts {
    return _contacts;
  }

  List<ChatData> get chats {
    return _chats;
  }

  String getGroupId(String contact) {
    String groupId;
    if (_userId.hashCode <= contact.hashCode)
      groupId = '$_userId-$contact';
    else
      groupId = '$contact-$_userId';

    return groupId;
  }

  Future<List<ChatData>> fetchChats(List<UserDetail> _contacts) async {
    List<ChatData> _chats = List<ChatData>();
    await Future.forEach(_contacts, (contact) async {
      final chatData = await getChatData(contact.id, contact);
      _chats.add(chatData);
    }).then((value) {});
    return _chats;
  }

  Future<ChatData> getChatData(String peerId, UserDetail userDetail) async {
    String groupId = getGroupId(peerId);
    final messagesData = await db.getChatItem(groupId);

    int unreadCount = 0;
    List<Message> messages = [];
    List<String> messageId = [];
    for (int i = 0; i < messagesData.docs.length; i++) {
      var tmp = Message.fromMap(
          Map<String, dynamic>.from(messagesData.docs[i].data()));
      messages.add(tmp);
      messageId.add(tmp.fromId + tmp.timeStamp);
      if (tmp.fromId == peerId && !tmp.isSeen) unreadCount++;
    }

    var lastDoc;
    if (messagesData.docs.isNotEmpty)
      lastDoc = messagesData.docs[messagesData.docs.length - 1];

    ChatData chatData = ChatData(
      userId: _userId,
      peerId: userDetail.id,
      groupId: groupId,
      peer: userDetail,
      messages: messages,
      lastDoc: lastDoc,
      unreadCount: unreadCount,
      messageId: messageId,
    );
    return chatData;
  }

  // updates the order of chats when a new message is recieved
  void bringChatToTop(
    String groupId,
  ) {
    if (_chats.isNotEmpty && _chats[0].groupId != groupId) {
      // bring latest interacted contact and chat to top
      var ids = groupId.split('-');
      var peerId = ids.firstWhere((element) => element != _user.uid);

      var cIndex = _contacts.indexWhere((element) => element == peerId);
      _contacts.removeAt(cIndex);
      _contacts.insert(0, peerId);

      db.updateUserInfo(_user.uid, {'contacts': _contacts});

      var index = _chats.indexWhere((element) => element.groupId == groupId);
      var temp = _chats[index];
      _chats.removeAt(index);
      _chats.insert(0, temp);
      notifyListeners();
    }
  }

  void addToInitChats(ChatData chatData) {
    if (_chats.contains(chatData)) return;
    _chats.insert(0, chatData);
    notifyListeners();
  }

  void addToContacts(String uid) {
    _contacts.add(uid);
    notifyListeners();
  }
}
