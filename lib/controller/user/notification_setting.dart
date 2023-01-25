import 'package:mannergamer/utilites/index/index.dart';

class NtfSettingController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* 유저의 알림 on/off에 대한 bool 변수 
  * chatPushNtf, activityPushNtf, nightPushNtf, marketingConsent */
  RxMap<String, dynamic> userNtfBool = Map<String, dynamic>().obs;
  // var userNtfBool = NotificationSettingModel().obs;

  var isChatNtf = true.obs;
  var isActivitNtf = true.obs;
  var isMarketingConsent = true.obs;
  var isNightNtf = true.obs;

  @override
  void onInit() {
    super.onInit();
    getUserPushNtf();
  }

  /* 채팅, 활동, 앱 공지, 마케팅 수신 동의에 대한 유저의 값 받기 */
  Future getUserPushNtf() async {
    await _userDB.doc(CurrentUser.uid).get().then((value) {
      var snapshot = value.data() as Map<String, dynamic>;
      isChatNtf.value = snapshot['chatPushNtf']; //채팅알림
      isActivitNtf.value = snapshot['activityPushNtf']; //활동알림
      isNightNtf.value = snapshot['nightPushNtf']; //앱 공지 및 소식 알림
      isMarketingConsent.value = snapshot['marketingConsent']; //마켓팅 수신 동의
    });
  }

  /* 채팅알림 토글 버튼 클릭 시 업데이트 */
  Future updateChatPushNtf(chatPushNtf) async {
    return _userDB.doc(CurrentUser.uid).update(
      {
        'chatPushNtf': chatPushNtf,
      },
    );
  }

  /* 활동알림 토글 버튼 클릭 시 업데이트 */
  Future updateActivityPushNtf(activityPushNtf) async {
    return _userDB.doc(CurrentUser.uid).update(
      {
        'activityPushNtf': activityPushNtf,
      },
    );
  }

  /* 앱 소식 및 공지 알림 토글 버튼 클릭 시 업데이트 */
  Future updateNightPushNtf(nightPushNtf) async {
    return _userDB.doc(CurrentUser.uid).update(
      {
        'nightPushNtf': nightPushNtf,
      },
    );
  }

  /* 마케팅 수신 동의 토글 버튼 클릭 시 업데이트*/
  Future updateMarketingConsent(marketingConsent) async {
    return _userDB.doc(CurrentUser.uid).update(
      {
        'marketingConsent': marketingConsent,
      },
    );
  }
}
