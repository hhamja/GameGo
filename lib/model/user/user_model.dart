import 'package:mannergamer/utilites/index/index.dart';

class UserModel {
  final String uid; //문서의 id도 uid 필드랑 같게하기
  final String userName;
  final String phoneNumber;
  final String profileUrl;
  final String mannerAge; //초기값 20.0세
  final String? chattingWith; //현재 채팅하고 있는 유저 uid
  final String? pushToken; //fcm의 장치 토큰
  final Timestamp createdAt;

  UserModel({
    required this.uid,
    required this.userName,
    required this.phoneNumber,
    required this.profileUrl,
    required this.mannerAge,
    this.chattingWith,
    this.pushToken,
    required this.createdAt,
  });

  factory UserModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'],
      phoneNumber: snapshot['phoneNumber'],
      userName: snapshot['userName'],
      profileUrl: snapshot['profileUrl'],
      mannerAge: snapshot['mannerAge'],
      chattingWith: snapshot['chattingWith'],
      pushToken: snapshot['pushToken'],
      createdAt: snapshot['createdAt'],
    );
  }
}
