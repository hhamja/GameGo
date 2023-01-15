import 'package:mannergamer/utilites/index/index.dart';

class PostModel {
  final String postId; //게시글 고유 id값
  final String uid; //유저의 id값, 본인의 게시물을 식별하는 조건에 필요
  final String userName; //유저의 닉네임
  final String profileUrl; //유저 프로필
  final String title; //게시글 제목
  final String maintext; //게시글 본문
  final String gamemode; //게임모드
  final String? position; //포지션, 솔로·자유·일반게임만 값을 가짐
  final String? tear; //티어, 솔로·자유만 값을 가짐
  final int like; //게시물 하트 버튼 누룬 개수
  final String gameType; //게임종류 ex) 롤 = 'lol'
  final Timestamp createdAt; //만든 시간, 수정 시 이 값은 업데이트 되므로 updatedAt도 됨

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
    required this.createdAt,
  });

  /* 파이어스토어 DB로 부터 데이터를 받는 인스턴스 생성 */
  factory PostModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    //Post DB의 문서 데이터로 변환
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
      createdAt: snapshot['createdAt'],
    );
  }
}
