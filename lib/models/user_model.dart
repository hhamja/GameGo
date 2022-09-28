import 'package:mannergamer/utilites/index.dart';

class UserModel {
  final userid;
  String username;
  String? profileUrl;
  var mannerAge; //초기값 20.0세
  Timestamp createdAt;

  UserModel({
    this.userid,
    required this.username,
    this.profileUrl,
    required this.mannerAge,
    required this.createdAt,
  });

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return UserModel(
      userid: doc.id,
      username: doc['username'],
      profileUrl: doc['profileUrl'],
      mannerAge: doc['mannerAge'],
      createdAt: doc['createdAt'],
    );
  }
}
