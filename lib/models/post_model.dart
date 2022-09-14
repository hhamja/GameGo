import 'package:mannergamer/utilites/index.dart';

class PostModel {
  final postid;
  String? username;
  String title;
  String maintext;
  String gamemode;
  String? position;
  String? tear;
  Timestamp? createdAt;

  PostModel({
    this.postid,
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
      postid: doc.id,
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
