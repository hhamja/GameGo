import 'package:mannergamer/utilites/index/index.dart';

class UserModel {
  final String uid;
  final String userName;
  final String phoneNumber;
  final String profileUrl;

  // 초기값 20.0세
  final num mannerAge;

  // 현재 채팅하고 있는 유저 uid
  final String? chattingWith;

  // fcm의 장치 토큰 값
  // 푸시 알림 수신시 필요하며, 유저 로그아웃시 null로 update하기 위해 nullable
  final String? pushToken;

  // 채팅 메시지 알림
  // 활동 알림(관심게시글, 약속설정, 매너후기)
  // 마케팅 정보 수집 동의
  // 야간 시간 알림
  final bool chatPushNtf;
  final bool activityPushNtf;
  final bool marketingConsent;
  final bool nightPushNtf;

  // 탈퇴유저 플래그
  // 탈퇴유저의 경우 true, 비탈퇴유저의 경우 false
  final bool isWithdrawn;

  // 탈퇴 시간
  // 계정 복구 및 일정기간 재가입 못하게 하기 위함
  final Timestamp? withdrawnAt;

  final Timestamp updatedAt;
  final Timestamp createdAt;

  UserModel({
    required this.uid,
    required this.userName,
    required this.phoneNumber,
    required this.profileUrl,
    required this.mannerAge,
    this.chattingWith,
    this.pushToken,
    required this.chatPushNtf,
    required this.activityPushNtf,
    required this.marketingConsent,
    required this.nightPushNtf,
    required this.isWithdrawn,
    this.withdrawnAt,
    required this.updatedAt,
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
      chatPushNtf: snapshot['chatPushNtf'],
      activityPushNtf: snapshot['activityPushNtf'],
      marketingConsent: snapshot['marketingConsent'],
      nightPushNtf: snapshot['nightPushNtf'],
      isWithdrawn: snapshot['isWithdrawn'],
      withdrawnAt: snapshot['withdrawnAt'],
      updatedAt: snapshot['updatedAt'],
      createdAt: snapshot['createdAt'],
    );
  }
}
