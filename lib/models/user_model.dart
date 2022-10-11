// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mannergamer/utilites/index.dart';

class UserModel {
  final String? uid; //문서의 id도 uid 필드랑 같게하기
  final String? userName;
  final String? phoneNumber;
  final String? profileUrl;
  final String? mannerAge; //초기값 20.0세
  final Timestamp? createdAt;

  UserModel({
    this.uid,
    this.userName,
    this.phoneNumber,
    this.profileUrl,
    this.mannerAge,
    this.createdAt,
  });

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'],
      phoneNumber: snapshot['phoneNumber'],
      userName: snapshot['userName'],
      profileUrl: snapshot['profileUrl'],
      mannerAge: snapshot['mannerAge'],
      createdAt: snapshot['createdAt'],
    );
  }

  UserModel copyWith({
    String? uid,
    String? userName,
    String? phoneNumber,
    String? profileUrl,
    String? mannerAge,
    Timestamp? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileUrl: profileUrl ?? this.profileUrl,
      mannerAge: mannerAge ?? this.mannerAge,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
