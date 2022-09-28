// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:mannergamer/utilites/index.dart';

class MessageModel {
  final String? messageText; //채팅내용
  final String? senderId; // 보내는 사람 id
  final String? recieverId; //받는사람 id
  final Timestamp? dateTime; //채팅 시간
  MessageModel({
    this.messageText,
    this.senderId,
    this.recieverId,
    this.dateTime,
  });

  MessageModel copyWith({
    String? messageText,
    String? senderId,
    String? recieverId,
    Timestamp? dateTime,
  }) {
    return MessageModel(
      messageText: messageText ?? this.messageText,
      senderId: senderId ?? this.senderId,
      recieverId: recieverId ?? this.recieverId,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  factory MessageModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return MessageModel(
      messageText: doc['messageText'],
      senderId: doc['senderId'],
      recieverId: doc['recieverId'],
      dateTime: doc['dateTime'],
    );
  }
}
