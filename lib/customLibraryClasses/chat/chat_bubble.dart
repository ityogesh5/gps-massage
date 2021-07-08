import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/message.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';
import 'package:gps_massageapp/customLibraryClasses/chat/chat_reply_bubble.dart';
import 'package:gps_massageapp/customLibraryClasses/chat/dismissible_bubble.dart';
import 'package:gps_massageapp/customLibraryClasses/chat/media_bubble.dart';
import 'package:gps_massageapp/customLibraryClasses/chat/seen_status.dart';
import 'package:gps_massageapp/customLibraryClasses/cusTomChatBubbles/CustomChatBubbles.dart';
import 'package:gps_massageapp/customLibraryClasses/cusTomChatBubbles/customChatBubbleReceiver.dart';
import 'package:gps_massageapp/customLibraryClasses/cusTomChatBubbles/customChatBubbleSender.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isMe;
  final UserDetail peer;
  final bool withoutAvatar;
  final Function onReply;
  ChatBubble({
    @required this.message,
    @required this.isMe,
    @required this.peer,
    @required this.withoutAvatar,
    this.onReply,
  }) : super();

  Widget chatItem(BuildContext context) {
    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          if (message.type == MessageType.Text) {
            return !isMe
                ? _PeerMessage(
                    peer: peer,
                    isMe: isMe,
                    message: message,
                    onReplyPressed: onReply,
                    constraints: constraints,
                    withoutAvatar: withoutAvatar,
                  )
                : _WithoutAvatar(
                    isMe: isMe,
                    message: message,
                    onReplyPressed: onReply,
                    peer: peer,
                    constraints: constraints,
                  );
          } else {
            return MediaBubble(
              message: message,
              onReplied: onReply,
              avatarImageUrl: peer.imageUrl,
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return chatItem(context);
  }
}

class _PeerMessage extends StatelessWidget {
  const _PeerMessage({
    Key key,
    @required this.peer,
    @required this.isMe,
    @required this.message,
    @required this.onReplyPressed,
    @required this.constraints,
    this.withoutAvatar,
  }) : super(key: key);

  final UserDetail peer;
  final bool isMe;
  final Message message;
  final Function onReplyPressed;
  final BoxConstraints constraints;
  final bool withoutAvatar;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //withoutAvatar ? SizedBox(width: 30) : Avatar(imageUrl: peer.imageUrl),
        SizedBox(width: 5),
        _WithoutAvatar(
          isMe: isMe,
          message: message,
          onReplyPressed: onReplyPressed,
          peer: peer,
          constraints: constraints,
        ),
      ],
    );
  }
}

class _WithoutAvatar extends StatelessWidget {
  const _WithoutAvatar({
    Key key,
    @required this.isMe,
    @required this.message,
    @required this.onReplyPressed,
    @required this.peer,
    @required this.constraints,
  }) : super(key: key);

  final bool isMe;
  final Message message;
  final Function onReplyPressed;
  final UserDetail peer;
  final BoxConstraints constraints;

  BorderRadius _replyMsgRadius() {
    if (message.reply != null) {
      if (isMe)
        return BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        );
      return BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(20),
      );
    }

    return BorderRadius.circular(20);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DismssibleBubble(
      isMe: isMe,
      message: message,
      onDismissed: onReplyPressed,
      child: Wrap(
        spacing: 20,
        children: [
          Stack(
            children: [
              if (message.reply != null)
                Align(
                  alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                  child: ReplyMessageBubble(
                    message: message,
                    peer: peer,
                    color: Colors.blue,
                  ),
                ),
              isMe
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: message.reply != null
                            ? EdgeInsets.only(
                                top: (message.reply != null &&
                                        message.reply.type == MessageType.Text)
                                    ? 50
                                    : size.height * 0.25 - 5,
                              )
                            : const EdgeInsets.all(0),
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth * 0.8,
                        ),
                        child: getSenderView(
                            ChatBubbleSender(type: BubbleType.sendBubble),
                            context),
                      ),
                    )
                  : Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: message.reply != null
                            ? EdgeInsets.only(
                                top: (message.reply != null &&
                                        message.reply.type == MessageType.Text)
                                    ? 20
                                    : size.height * 0.25 - 5,
                              )
                            : const EdgeInsets.all(0),
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth * 0.8,
                        ),
                        child: getReceiverView(
                            ChatBubbleReceiver(type: BubbleType.receiverBubble),
                            context),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getSenderView(CustomClipper clipper, BuildContext context) => Column(
        children: [
          CustomChatBubble(
            clipper: clipper,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 20),
            backGroundColor: Colors.lime,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Text(
                '${message.content}',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'NotoSansJP'),
              ),
            ),
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SeenStatus(
                isMe: isMe,
                isSeen: message.isSeen,
                timestamp: message.sendDate,
              ),
              Text('')
            ],
          ),
        ],
      );

  Widget getReceiverView(CustomClipper clipper, BuildContext context) => Column(
        children: [
          CustomChatBubble(
            clipper: clipper,
            backGroundColor: Color.fromRGBO(255, 255, 255, 1),
            elevation: 0.1,
            margin: EdgeInsets.only(top: 20),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Text(
                '${message.content}',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'NotoSansJP',
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SeenStatus(
                isMe: isMe,
                isSeen: message.isSeen,
                timestamp: message.sendDate,
              ),
              Text('')
            ],
          ),
        ],
      );

  String getTime(DateTime timestamp) {
    int hour = timestamp.hour;
    int min = timestamp.minute;
    String hRes = hour <= 9 ? '0$hour' : hour.toString();
    String mRes = min <= 9 ? '0$min' : min.toString();

    return '$hRes:$mRes時';
  }
}
