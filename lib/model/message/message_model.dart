import 'package:mannergamer/utilites/index/index.dart';

class MessageModel {
  final id; // 메시지 id
  final String content; // 메시지내용
  final String idFrom; // 메시지 보내는 사람 id
  final String idTo; // 메시지 받는 사람 id
  final String type;
  // 메세지 타입
  // 약속설정 : 'appoint'
  // 게임 후기 : 'review'
  // 채팅 메시지 : 'message'
  final Timestamp timestamp;
  // 메시지 보낸 시간
  //FieldValue.serverTimestamp() -> DB서버시간

  MessageModel({
    this.id,
    required this.content,
    required this.idFrom,
    required this.idTo,
    required this.type,
    required this.timestamp,
  });

  /* 파이어스토어 DB로 부터 데이터를 받는 인스턴스 생성 */
  factory MessageModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: doc.id,
      content: snapshot['content'],
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      type: snapshot['type'],
      timestamp: snapshot['timestamp'],
    );
  }
}
