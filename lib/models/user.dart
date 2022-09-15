import 'package:mannergamer/utilites/index.dart';

class UserModel {
  final userid;
  String phonenumber;
  String username;
  CircleAvatar? avatar;
  String? email;
  double mannerAge; //초기값 20.0세
  Timestamp createdAt;

  UserModel({
    this.userid,
    required this.phonenumber,
    required this.username,
    this.avatar,
    this.email,
    required this.mannerAge,
    required this.createdAt,
  });

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return UserModel(
      userid: doc.id,
      phonenumber: doc['phonenumber'],
      username: doc['username'],
      avatar: doc['avatar'],
      email: doc['email'],
      mannerAge: doc['mannerAge'],
      createdAt: doc['createdAt'],
    );
  }
}
