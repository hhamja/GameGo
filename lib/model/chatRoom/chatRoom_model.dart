import 'package:mannergamer/utilites/index/index.dart';

// /* 기본값 : true, 채팅방 들어와있는지 여부
// * 데이터구조 -> {user1 : true, user2 : true,}
// * 채팅리스트를 GEt ->  where('currentUid', 'true')로 쿼리
// * 채팅방 나가면? -> 해당Uid : false로 Update()
// * 둘다 false라면? -> DB데이터 삭제 */
// final Map<String, bool> isChatIn;
class ChatRoomModel {
  final String chatRoomId;
  final String postId;
  final List members;
  /* <List>[uid, profileUrl, userName,  mannerAge]의 유저정보 */
  final List postingUser; //게시자
  final List contactUser; //게시자가 아닌 상대유저

  /* 안읽은 메시지의 수
  * 데이터 구조 -> 
  {postingUser의 uid : 받은 수(보낸 수 X), contact유저의 uid : 받은 수(보낸 수 X)}
  * 메시지 보내면 -> 받는 uid의 값 +1  
  * Get할 때 -> currentUid로 안읽은 메시지 수 받기 
  * 유저가 메시지 페이지에 들어간다면? -> 나의 uid에 해당하는 값 '0'으로 업데이트 */
  final Map unReadCount;
  final String lastContent; //마지막 채팅 내용, 메시지 보낼 때 마다 업데이트
  final Timestamp updatedAt; //가장 최근 주고받은 일시, 메시지 보낼 때 마다 업데이트

  ChatRoomModel({
    required this.chatRoomId,
    required this.postId,
    required this.members,
    required this.postingUser,
    required this.contactUser,
    required this.unReadCount,
    required this.lastContent,
    required this.updatedAt,
  });

  /* 파이어스토어 DB로 부터 데이터를 받는 인스턴스 생성 */
  factory ChatRoomModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return ChatRoomModel(
      chatRoomId: snapshot['chatRoomId'],
      postId: snapshot['postId'],
      members: snapshot['members'],
      postingUser: snapshot['postingUser'],
      contactUser: snapshot['contactUser'],
      unReadCount: snapshot['unReadCount'],
      lastContent: snapshot['lastContent'],
      updatedAt: snapshot['updatedAt'],
    );
  }
}
