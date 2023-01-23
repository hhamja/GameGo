import 'package:mannergamer/utilites/index/index.dart';

class GameReviewModel {
  final String idFrom; //리뷰 보낸 uid
  final String idTo; //리뷰 받는 uid
  final String chatRoomId; //해당되는 채팅방 id
  final String profileUrl; //리뷰 보낸 사람의 프로필
  final String userName; //리뷰 보낸 사람의 이름
  final String content; //직접 작성한 후기
  final String gameType; //어떤 게임인지? 지금은 : 'lol'  , 게임에 다른 게임 추가될 가능성
  final Timestamp createdAt; //후기 보낸 시간

  GameReviewModel({
    required this.idFrom,
    required this.idTo,
    required this.chatRoomId,
    required this.profileUrl,
    required this.userName,
    required this.content,
    required this.gameType,
    required this.createdAt,
  });

  factory GameReviewModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return GameReviewModel(
      idFrom: snapshot['idFrom'],
      idTo: snapshot['idTo'],
      chatRoomId: snapshot['chatRoomId'],
      profileUrl: snapshot['profileUrl'],
      userName: snapshot['userName'],
      content: snapshot['content'],
      gameType: snapshot['gameType'],
      createdAt: snapshot['createdAt'],
    );
  }
}
