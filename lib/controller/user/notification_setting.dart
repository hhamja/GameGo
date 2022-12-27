import 'package:mannergamer/utilites/index/index.dart';

class NtfSettingController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* 유저의 알림 on/off에 대한 bool 변수 
  * chatPushNtf, activityPushNtf, noticePushNtf, marketingConsent */
  RxMap<String, dynamic> userNtfBool = Map<String, dynamic>().obs;
  // var userNtfBool = NotificationSettingModel().obs;

  var isChatNtf = true.obs;
  var isActivitNtf = true.obs;
  var isNoticeNtf = true.obs;
  var isMarketingConsent = true.obs;

  @override
  void onInit() {
    super.onInit();
    getUserPushNtf();
  }

  Future getUserPushNtf() async {
    await _userDB.doc(CurrentUser.uid).get().then((value) {
      var snapshot = value.data() as Map<String, dynamic>;
      isChatNtf.value = snapshot['chatPushNtf']; //채팅알림
      isActivitNtf.value = snapshot['chatPushNtf']; //활동알림
      isNoticeNtf.value = snapshot['chatPushNtf']; //앱 공지 및 소식 알림
      isMarketingConsent.value = snapshot['chatPushNtf']; //마켓팅 수신 동의
    });
  }

  /* 알림 설정 페이지 나갈 때 최종 토글버튼 값 반영하여 업데이트 */
  Future updateChatPushNtf(NotificationSettingModel model) async {
    return _userDB.doc(CurrentUser.uid).update(
      {
        'chatPushNtf': model.chatPushNtf,
        'activityPushNtf': model.activityPushNtf,
        'noticePushNtf': model.noticePushNtf,
        'marketingConsent': model.marketingConsent,
      },
    );
  }
}
