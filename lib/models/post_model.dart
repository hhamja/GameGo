import 'package:mannergamer/utilites/index.dart';

class PostModel {
  final String postId;
  final String uid; //게시물 작성 유저 id
  final String? profileUrl; // 유저 프로필
  final String? userName; // 유저 이름
  final String? mannerAge; // 유저의 매너나이
  final String title;
  final String maintext;
  final String gamemode;
  final String? position;
  final String? tear;
  final Timestamp createdAt;

  PostModel({
    required this.postId,
    required this.uid,
    this.profileUrl,
    this.userName,
    this.mannerAge,
    required this.title,
    required this.maintext,
    required this.gamemode,
    this.position,
    this.tear,
    required this.createdAt,
  });

  factory PostModel.fromDocumentSnapshot(
      DocumentSnapshot doc, UserModel usermodel) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return PostModel(
      postId: snapshot['postId'],
      uid: snapshot['uid'],
      userName: usermodel.userName,
      mannerAge: usermodel.mannerAge,
      profileUrl: usermodel.profileUrl,
      title: snapshot['title'],
      maintext: snapshot['maintext'],
      gamemode: snapshot['gamemode'],
      position: snapshot['position'],
      tear: snapshot['tear'],
      createdAt: snapshot['createdAt'],
    );
  }
}
