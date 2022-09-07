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

  factory PostModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final map = doc.data();
    return PostModel(
      postid: doc.id,
      username: map?['username'],
      title: map?['title'],
      maintext: map?['maintext'],
      gamemode: map?['gamemode'],
      position: map?['position'],
      tear: map?['tear'],
      createdAt: map?['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (username != null) 'username': username,
      if (title != null) 'title': title,
      if (maintext != null) 'maintext': maintext,
      if (gamemode != null) 'gamemode': gamemode,
      if (tear != null) 'tear': tear,
      if (createdAt != null) 'createdAt': createdAt,
    };
  }
}
