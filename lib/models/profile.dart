import 'package:mannergamer/utilites/index.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Profile {
  String userid;
  String phonenumber;
  String username;
  String createdAt;

  Profile({
    required this.userid,
    required this.phonenumber,
    required this.username,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userid': userid,
      'phonenumber': phonenumber,
      'username': username,
      'createdAt': createdAt,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      userid: map['userid'] as String,
      phonenumber: map['phonenumber'] as String,
      username: map['username'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  Profile copyWith({
    String? userid,
    String? phonenumber,
    String? username,
    String? createdAt,
  }) {
    return Profile(
      userid: userid ?? this.userid,
      phonenumber: phonenumber ?? this.phonenumber,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(userid: $userid, phonenumber: $phonenumber, username: $username, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;

    return other.userid == userid &&
        other.phonenumber == phonenumber &&
        other.username == username &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return userid.hashCode ^
        phonenumber.hashCode ^
        username.hashCode ^
        createdAt.hashCode;
  }
}
