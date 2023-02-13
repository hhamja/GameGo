import 'package:mannergamer/utilites/index/index.dart';

class MessageModel {
  final id;
  final String content;
  final String idFrom;
  final String idTo;
  // 메세지 타입
  // 약속설정 : 'appoint'
  // 게임 후기 : 'review'
  // 채팅 메시지 : 'message'
  final String type;
  // 메시지 삭제 여부
  // 나중에 메시지 삭제 기능도 추가하게 될 가능성이 있으므로 넣음
  final bool isDeleted;
  final Timestamp timestamp;

  MessageModel({
    this.id,
    required this.content,
    required this.idFrom,
    required this.idTo,
    required this.type,
    required this.isDeleted,
    required this.timestamp,
  });

  factory MessageModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: doc.id,
      content: snapshot['content'],
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      type: snapshot['type'],
      isDeleted: snapshot['isDeleted'],
      timestamp: snapshot['timestamp'],
    );
  }
}
