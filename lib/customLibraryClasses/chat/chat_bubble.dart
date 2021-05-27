import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/message.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/user.dart';
import 'package:gps_massageapp/customLibraryClasses/chat/avatar.dart';
import 'package:gps_massageapp/customLibraryClasses/chat/bubble_text.dart';
import 'package:gps_massageapp/customLibraryClasses/chat/chat_reply_bubble.dart';
import 'package:gps_massageapp/customLibraryClasses/chat/dismissible_bubble.dart';
import 'package:gps_massageapp/customLibraryClasses/chat/media_bubble.dart';
import 'package:gps_massageapp/customLibraryClasses/chat/seen_status.dart';

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
        withoutAvatar ? SizedBox(width: 30) : Avatar(imageUrl: peer.imageUrl),
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
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Stack(
                children: [
                  if (message.reply != null)
                    Align(
                      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                      child: ReplyMessageBubble(
                        message: message,
                        peer: peer,
                        color: isMe ? Colors.white : ColorConstants.buttonColor,
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      // key: key,
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
                      decoration: BoxDecoration(
                        borderRadius: _replyMsgRadius(),
                        border: isMe ? null : Border.all(color: kBorderColor3),
                        color: isMe ? ColorConstants.buttonColor : Colors.white,
                        /* kBlackColor3  : kBlackColor,*/
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(
                                  178, 180, 182, 1), //Colors.black54,
                              blurRadius: isMe ? 0.0 : 8.0,
                              offset: Offset(0.0, 0.75))
                        ],
                      ),
                      child: Padding(
                        key: key,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          runAlignment: WrapAlignment.end,
                          alignment: WrapAlignment.end,
                          spacing: 20,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 12),
                              child: BubbleText(
                                  text: message.content,
                                  color: isMe ? Colors.white : Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: SeenStatus(
                                isMe: isMe,
                                isSeen: message.isSeen,
                                timestamp: message.sendDate,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  getTime(message.sendDate),
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Color.fromRGBO(178, 180, 182, 1),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0)
        ],
      ),
    );
  }

  String getTime(DateTime timestamp) {
    int hour = timestamp.hour;
    int min = timestamp.minute;
    String hRes = hour <= 9 ? '0$hour' : hour.toString();
    String mRes = min <= 9 ? '0$min' : min.toString();

    return '$hRes:$mRes時';
  }
}
