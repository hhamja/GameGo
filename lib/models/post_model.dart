import 'package:mannergamer/utilites/index.dart';

class PostModel {
  final String postId;
  final String uid; //게시물 작성 유저 id
  final UserModel? user;
  final String title;
  final String maintext;
  final String gamemode;
  final String? position;
  final String? tear;
  final Timestamp createdAt;

  PostModel({
    required this.postId,
    required this.uid,
    this.user,
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
      user: usermodel,
      title: snapshot['title'],
      maintext: snapshot['maintext'],
      gamemode: snapshot['gamemode'],
      position: snapshot['position'],
      tear: snapshot['tear'],
      createdAt: snapshot['createdAt'],
    );
  }
}
