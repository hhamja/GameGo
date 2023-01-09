class NotificationSettingModel {
  var chatPushNtf; //채팅 메시지 알림
  var activityPushNtf; //활동 알림(관심게시글, 약속설정, 매너후기)
  var noticePushNtf; //앱 공지 알림
  var marketingConsent; //마케팅 정보 수집 동의
  // final String uid; //문서의 id도 uid 필드랑 같게하기
  // final String userName;
  // final String phoneNumber;
  // final String profileUrl;
  // final num mannerAge; //초기값 20.0세
  // final String? chattingWith; //현재 채팅하고 있는 유저 uid
  // final String? pushToken; //fcm의 장치 토큰
  // final Timestamp createdAt;

  NotificationSettingModel({
    // required this.uid,
    // required this.userName,
    // required this.phoneNumber,
    // required this.profileUrl,
    // required this.mannerAge,
    // this.chattingWith,
    // this.pushToken,
    // required this.createdAt,
    this.chatPushNtf,
    this.activityPushNtf,
    this.noticePushNtf,
    this.marketingConsent,
  });

  factory NotificationSettingModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return NotificationSettingModel(
      // uid: snapshot['uid'],
      // phoneNumber: snapshot['phoneNumber'],
      // userName: snapshot['userName'],
      // profileUrl: snapshot['profileUrl'],
      // mannerAge: snapshot['mannerAge'],
      // chattingWith: snapshot['chattingWith'],
      // pushToken: snapshot['pushToken'],
      // createdAt: snapshot['createdAt'],
      chatPushNtf: snapshot['chatPushNtf'],
      activityPushNtf: snapshot['activityPushNtf'],
      noticePushNtf: snapshot['noticePushNtf'],
      marketingConsent: snapshot['marketingConsent'],
    );
  }
}
