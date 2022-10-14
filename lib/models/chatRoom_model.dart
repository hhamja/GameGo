import 'package:mannergamer/utilites/index.dart';

class ChatRoomModel {
  final String id; //채팅방의 id
  final List userIdList;
  final String? postingUserId; //보내는 사람 id
  final String? peerUserId; //받는사람 id
  final String? lastContent; //마지막 채팅내용
  final String? updatedAt; //가장 최근 주고받은 일시

  ChatRoomModel({
    required this.id,
    required this.userIdList,
    this.postingUserId,
    this.peerUserId,
    this.lastContent,
    this.updatedAt,
  });

  /* 파이어스토어 DB로 부터 데이터를 받는 인스턴스 생성 */
  factory ChatRoomModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return ChatRoomModel(
      id: snapshot['id'],
      userIdList: snapshot['userIdList'],
      postingUserId: snapshot['postingUserId'],
      peerUserId: snapshot['peerUserId'],
      lastContent: snapshot['lastContent'],
      updatedAt: snapshot['updatedAt'],
    );
  }
}
