import 'package:mannergamer/utilites/index.dart';

class PostModel {
  String? postid;
  String? username;
  String title;
  String maintext;
  String? gamemode;
  String? position;
  String? tear;
  Timestamp? createdAt;
  PostModel({
    this.postid,
    this.username,
    required this.title,
    required this.maintext,
    this.gamemode,
    this.position,
    this.tear,
    this.createdAt,
  });

  factory PostModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final map = doc.data();
    return PostModel(
      postid: doc.id,
      username: map?['username'] ?? null,
      title: map?['title'] as String,
      maintext: map?['maintext'] as String,
      gamemode: map?['gamemode'] ?? null,
      position: map?['position'] ?? null,
      tear: map?['tear'] ?? null,
      createdAt: map?['createdAt'] ?? null,
    );
  }
}
