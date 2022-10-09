import 'package:mannergamer/utilites/index.dart';

class PostModel {
  final String? postId;
  final String? uid;
  final String? username;
  final String title;
  final String maintext;
  final String gamemode;
  final String? position;
  final String? tear;
  final Timestamp? createdAt;

  PostModel({
    this.postId,
    this.uid,
    this.username,
    required this.title,
    required this.maintext,
    required this.gamemode,
    this.position,
    this.tear,
    this.createdAt,
  });

  factory PostModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return PostModel(
      postId: doc['postId'],
      uid: doc['uid'],
      username: doc['username'],
      title: doc['title'],
      maintext: doc['maintext'],
      gamemode: doc['gamemode'],
      position: doc['position'],
      tear: doc['tear'],
      createdAt: doc['createdAt'],
    );
  }
}
