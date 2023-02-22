import 'package:gamegoapp/utilites/index/index.dart';

class ChatRoomModel {
  final String chatRoomId;
  final String postId;

  //[postingUid, contactUid] 순서로 넣기, 나의 채팅 리스트 쿼리할 때 활용
  final List members;

  //게시자 uid, 프로필, 닉네임
  final String postingUid;
  final String postingUserProfileUrl;
  final String postingUserName;

  //비게시자 uid, 프로필, 닉네임
  final String contactUid;
  final String contactUserProfileUrl;
  final String contactUserName;

  //안읽은 메시지의 수
  //데이터 구조 ->
  //{postingUser의 uid : 받은 수(보낸 수 X), contact유저의 uid : 받은 수(보낸 수 X)}
  //메시지 보내면 -> 받는 uid의 값 +1
  //Get할 때 -> currentUid로 안읽은 메시지 수 받기
  //유저가 메시지 페이지에 들어간다면? -> 나의 uid에 해당하는 값 '0'으로 업데이트
  final Map unReadCount;

  //마지막 채팅 내용, 메시지 보낼 때 마다 업데이트
  final String lastContent;

  //채팅 비활성화
  //맴버 중 한명이라도 탈퇴한 유저가 있을 경우 :  true
  final bool isActive;

  //게임 같이 하는 약속 잡을 경우
  //가장 최근 주고받은 일시, 메시지 보낼 때 마다 업데이트
  final Timestamp updatedAt;

  ChatRoomModel({
    required this.chatRoomId,
    required this.postId,
    required this.members,
    required this.postingUid,
    required this.postingUserProfileUrl,
    required this.postingUserName,
    required this.contactUid,
    required this.contactUserProfileUrl,
    required this.contactUserName,
    required this.unReadCount,
    required this.lastContent,
    required this.isActive,
    required this.updatedAt,
  });

  //파이어스토어 DB로 부터 데이터를 받는 인스턴스 생성
  factory ChatRoomModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return ChatRoomModel(
      chatRoomId: snapshot['chatRoomId'],
      postId: snapshot['postId'],
      members: snapshot['members'],
      postingUid: snapshot['postingUid'],
      postingUserProfileUrl: snapshot['postingUserProfileUrl'],
      postingUserName: snapshot['postingUserName'],
      contactUid: snapshot['contactUid'],
      contactUserProfileUrl: snapshot['contactUserProfileUrl'],
      contactUserName: snapshot['contactUserName'],
      unReadCount: snapshot['unReadCount'],
      lastContent: snapshot['lastContent'],
      isActive: snapshot['isActive'],
      updatedAt: snapshot['updatedAt'],
    );
  }
}
