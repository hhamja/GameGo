class NotificationSettingModel {
  var chatPushNtf; //채팅 메시지 알림
  var activityPushNtf; //활동 알림(관심게시글, 약속설정, 매너후기)
  var nightPushNtf; //앱 공지 알림
  var marketingConsent; //마케팅 정보 수집 동의

  NotificationSettingModel({
    this.chatPushNtf,
    this.activityPushNtf,
    this.nightPushNtf,
    this.marketingConsent,
  });

  factory NotificationSettingModel.fromDocumentSnapshot(doc) {
    var snapshot = doc.data() as Map<String, dynamic>;
    return NotificationSettingModel(
      chatPushNtf: snapshot['chatPushNtf'],
      activityPushNtf: snapshot['activityPushNtf'],
      nightPushNtf: snapshot['nightPushNtf'],
      marketingConsent: snapshot['marketingConsent'],
    );
  }
}
