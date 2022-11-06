import 'package:mannergamer/utilites/index/index.dart';

class MessageModel {
  final id; // 메시지 id
  final String content; // 메시지내용
  final String senderId; // 메시지 보내는 사람 id
  final bool isRead;
  final Timestamp timestamp; // 메시지 보낸 시간

  MessageModel({
    this.id,
    required this.content,
    required this.senderId,
    required this.isRead,
    required this.timestamp,
  });

  /* 파이어스토어 DB로 부터 데이터를 받는 인스턴스 생성 */
  factory MessageModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: doc.id,
      content: snapshot['content'],
      senderId: snapshot['senderId'],
      isRead: snapshot['isRead'],
      timestamp: snapshot['timestamp'],
    );
  }
}
