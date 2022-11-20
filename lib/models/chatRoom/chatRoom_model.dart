import 'package:mannergamer/utilites/index/index.dart';

// /* 기본값 : true, 채팅방 들어와있는지 여부
// * 데이터구조 -> {user1 : true, user2 : true,}
// * 채팅리스트를 GEt ->  where('currentUid', 'true')로 쿼리
// * 채팅방 나가면? -> 해당Uid : false로 Update()
// * 둘다 false라면? -> DB데이터 삭제 */
// final Map<String, bool> isChatIn;
class ChatRoomModel {
  final String id;
  final String postId;
  final List members;
  /* List<Map<게시자, 상대유저>>형태의 유저정보
  * 'id' : 해당유저의 uid
  * 'userName': 유저이름 
  * 'profileUrl': 프로필 
  * 'mannerAge': 매너나이 */

  final List userList;
  /* 안읽은 메시지의 수
  * 데이터 구조 -> {user1 : <int>, user2 : <int>}
  * Get할 때 -> currentUid로 안읽은 메시지 수 받기 
  * 메시지 보내면 -> 보낸 유저의 값 +1 (★주의★ 메시지 읽는 유저X, 보내는 유저의 uid에 저장) 
  * 유저가 메시지 페이지에 들어간다면? -> 상대유저의 값을 0으로 스트림 업데이트 */
  final Map unReadCount;
  /* <Timestamp> 약속설정한 날짜 
  * 채팅방 만하고 약속은 안정할 수 있으므로 nullable */
  final String lastContent; //마지막 채팅 내용, 메시지 보낼 때 마다 업데이트
  final Timestamp updatedAt; //가장 최근 주고받은 일시, 메시지 보낼 때 마다 업데이트

  ChatRoomModel({
    required this.id,
    required this.postId,
    required this.members,
    required this.userList,
    required this.unReadCount,
    required this.lastContent,
    required this.updatedAt,
  });

  /* 파이어스토어 DB로 부터 데이터를 받는 인스턴스 생성 */
  factory ChatRoomModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return ChatRoomModel(
      id: snapshot['id'],
      postId: snapshot['postId'],
      members: snapshot['members'],
      userList: snapshot['userList'],
      unReadCount: snapshot['unReadCount'],
      lastContent: snapshot['lastContent'],
      updatedAt: snapshot['updatedAt'],
    );
  }
}
