import 'package:mannergamer/utilites/index.dart';

class MessageModel {
  final id; // 메시지 id
  final String? content; // 메시지내용
  final String? senderId; // 메시지 보내는 사람 id
  final String? timestamp; // 메시지 보낸 시간

  MessageModel({
    this.id,
    this.content,
    this.senderId,
    this.timestamp,
  });

  factory MessageModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return MessageModel(
      id: doc.id,
      content: doc['content'],
      senderId: doc['senderId'],
      timestamp: doc['timestamp'],
    );
  }
}
