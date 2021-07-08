import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/db.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/message.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';

class ChatData {
  final DB db = DB();

  final String groupId;
  final String userId;
  final String peerId;
  final UserDetail peer;
  final List<dynamic> messages;
  DocumentSnapshot lastDoc;
  int unreadCount;
  final List<String> messageId;
  ChatData({
    @required this.groupId,
    @required this.userId,
    @required this.peerId,
   @required this.peer,
    @required this.messages,
    this.lastDoc,
    this.unreadCount = 0,
    @required this.messageId
  });

  void setLastDoc(DocumentSnapshot doc) {
    lastDoc = doc;
  }

  void addMessage(Message newMsg) {
    if (messages.length > 20) {
      messages.removeLast();
    }

    messages.insert(0, newMsg);
  }

  Future<bool> fetchNewChats() async {
    final newData = await db.getNewChats(groupId, lastDoc);
    await Future.delayed(Duration.zero).then((value) {
      newData.docs.forEach((element) {
        // print('new message added -------------> ${element['content']}');
        messages.add(Message.fromMap(element.data()));
      });

      if (newData.docs.isNotEmpty) {
        lastDoc = newData.docs[newData.docs.length - 1];
      }
    }).then((value) => value);

    return true;
  }
}
