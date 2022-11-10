import 'package:mannergamer/utilites/index/index.dart';

class ChatRoomModel {
  final String id; //채팅방의 id
  final String postId;
  final List userIdList; //채팅대상 유저 리스트 -> 채팅리스트 불러오는 쿼리에 쓰임
  final List userList; //uid, 이름, 매너나이, 프로필url을 Map형식으로 담음
  final String lastContent; //마지막 채팅내용
  final Timestamp updatedAt; //가장 최근 주고받은 일시

  ChatRoomModel({
    required this.id,
    required this.postId,
    required this.userIdList,
    required this.userList,
    required this.lastContent,
    required this.updatedAt,
  });

  /* 파이어스토어 DB로 부터 데이터를 받는 인스턴스 생성 */
  factory ChatRoomModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return ChatRoomModel(
      id: snapshot['id'],
      postId: snapshot['postId'],
      userIdList: snapshot['userIdList'],
      userList: snapshot['userList'],
      lastContent: snapshot['lastContent'],
      updatedAt: snapshot['updatedAt'],
    );
  }
}
