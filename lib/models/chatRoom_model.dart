import 'package:mannergamer/utilites/index.dart';

class ChatRoomModel {
  final String id; //채팅방의 id
  final List userIdList; //채팅대상 유저 리스트 -> 채팅리스트 불러오는 쿼리에 쓰임
  final String postingUserId; //게시글 올린 유저 ID
  final String peerUserId; //게시글 보고 채팅 보낸 유저 id
  final String lastContent; //마지막 채팅내용
  final Timestamp updatedAt; //가장 최근 주고받은 일시

  ChatRoomModel({
    required this.id,
    required this.userIdList,
    required this.postingUserId,
    required this.peerUserId,
    required this.lastContent,
    required this.updatedAt,
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
