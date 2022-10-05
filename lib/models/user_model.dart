import 'package:mannergamer/utilites/index.dart';

class UserModel {
  final id;
  final uid;
  final String userName;
  final String phoneNumber;
  final String? profileUrl;
  final String? mannerAge; //초기값 20.0세
  final Timestamp createdAt;

  UserModel({
    this.id,
    required this.uid,
    required this.userName,
    required this.phoneNumber,
    this.profileUrl,
    required this.mannerAge,
    required this.createdAt,
  });

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      uid: doc['uid'],
      phoneNumber: doc['phoneNumber'],
      userName: doc['userName'],
      profileUrl: doc['profileUrl'],
      mannerAge: doc['mannerAge'],
      createdAt: doc['createdAt'],
    );
  }
}
