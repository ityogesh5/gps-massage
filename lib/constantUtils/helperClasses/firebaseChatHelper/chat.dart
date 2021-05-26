import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/db.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/chatData.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/message.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';

class Chat {
  String _userId = "3MFwceiZ47ZujApwRAdOvMN1BOD2";
  final db = DB();

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

  Future<ChatData> getChatData(String peerId, UserDetail user) async {
    String groupId = getGroupId(peerId);
    final messagesData = await db.getChatItem(groupId);

    int unreadCount = 0;
    List<Message> messages = [];
    for (int i = 0; i < messagesData.docs.length; i++) {
      var tmp = Message.fromMap(
          Map<String, dynamic>.from(messagesData.docs[i].data()));
      messages.add(tmp);
      if (tmp.fromId == peerId && !tmp.isSeen) unreadCount++;
    }

    var lastDoc;
    if (messagesData.docs.isNotEmpty)
      lastDoc = messagesData.docs[messagesData.docs.length - 1];

    ChatData chatData = ChatData(
      userId: _userId,
      peerId: user.id,
      groupId: groupId,
      peer: user,
      messages: messages,
      lastDoc: lastDoc,
      unreadCount: unreadCount,
    );
    return chatData;
  }
}
