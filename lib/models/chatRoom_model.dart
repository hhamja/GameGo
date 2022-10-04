import 'package:mannergamer/utilites/index.dart';

class ChatRoomModel {
  final id; //채팅방의 id
  final String? lastContent; //마지막 채팅내용
  final String? postingUserId; //보내는 사람 id
  final String? peerUserId; //받는사람 id
  final String? updatedAt; //가장 최근 주고받은 일시

  ChatRoomModel({
    this.id,
    this.lastContent,
    this.postingUserId,
    this.peerUserId,
    this.updatedAt,
  });

  factory ChatRoomModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return ChatRoomModel(
      id: doc.id,
      lastContent: doc['lastContent'],
      postingUserId: doc['postingUserId'],
      peerUserId: doc['peerUserId'],
      updatedAt: doc['updatedAt'],
    );
  }
}
