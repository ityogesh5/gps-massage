import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/firebaseChatHelper/models/replyMessage.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  String content;
  String fromId;
  String toId;
  String timeStamp;
  DateTime sendDate;
  bool isSeen;
  MessageType type;
  MediaType mediaType;
  String mediaUrl;
  bool uploadFinished;
  ReplyMessage reply;

  Message({
    this.content,
    this.fromId,
    this.toId,
    this.timeStamp,
    this.sendDate,
    this.isSeen,
    this.type,
    this.mediaType,
    this.mediaUrl,
    this.uploadFinished,
    this.reply,
  });

  factory Message.fromMap(Map<String, dynamic> data) {
    return _$MessageFromJson(data);
  }

  static Map<String, dynamic> toMap(Message message) {
    return _$MessageToJson(message);
  }
}
