import 'package:mannergamer/utilites/index/index.dart';

class PostModel {
  final String postId;

  /// 게시자 uid, 닉네임, 프로필 url
  final String uid;
  final String userName;
  final String profileUrl;

  /// 게시글 제목, 본문
  final String title;
  final String maintext;

  /// 게임모드 : 솔로, 자유, 일반, 칼바람, AI
  /// 포지션, 솔로·자유·일반게임만 값을 가짐
  /// 티어, 솔로·자유만 값을 가짐
  final String gamemode;
  final String? position;
  final String? tear;

  /// 게시물 하트 버튼 누룬 개수
  final int like;

  /// 게임종류 ex) 롤 = 'lol'
  final String gameType;

  /// 탈퇴한 유저의 게시글 플래그
  final bool isHidden;

  /// 게시글 삭제 시 플래그
  // final bool isDeleted;

  /// 만든 시간, 수정 시 이 시간은 업데이트
  final Timestamp updatedAt;

  PostModel({
    required this.postId,
    required this.uid,
    required this.userName,
    required this.profileUrl,
    required this.title,
    required this.maintext,
    required this.gamemode,
    this.position,
    this.tear,
    required this.like,
    required this.gameType,
    required this.isHidden,
    required this.updatedAt,
  });

  /// 파이어스토어 DB로 부터 데이터를 받는 인스턴스 생성
  factory PostModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return PostModel(
      postId: snapshot['postId'],
      uid: snapshot['uid'],
      userName: snapshot['userName'],
      profileUrl: snapshot['profileUrl'],
      title: snapshot['title'],
      maintext: snapshot['maintext'],
      gamemode: snapshot['gamemode'],
      position: snapshot['position'],
      tear: snapshot['tear'],
      like: snapshot['like'],
      gameType: snapshot['gamemode'],
      isHidden: snapshot['isHidden'],
      updatedAt: snapshot['updatedAt'],
    );
  }
}
