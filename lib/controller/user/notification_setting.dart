import 'package:gamego/utilites/index/index.dart';

class NtfSettingController extends GetxController with WidgetsBindingObserver {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // 알림 권한 설정 값
  var isGrantedNtf = true.obs;

  // 앱 내의 알림 설정 값
  // 채팅, 활동, 이벤트 및 소식, 야간 알림 순
  var isChatNtf = true.obs;
  var isActivitNtf = true.obs;
  var isMarketingConsent = true.obs;
  var isNightNtf = true.obs;

  @override
  void onInit() {
    super.onInit();
    // 위젯 관찰자 추가
    WidgetsBinding.instance.addObserver(this);
    // 알림 상태 값 받기
    getUserPushNtf();
  }

  // 위젯 관찰자 제거
  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  // 세팅 페이지에서 권한 설정 후 변경된 값을 위젯에 반영
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      getUserPushNtf();
    }
  }

  // 채팅, 활동, 앱 공지, 마케팅 수신 동의에 대한 유저의 값 받기
  Future getUserPushNtf() async {
    isGrantedNtf.value = await Permission.notification.status.isGranted;
    _userDB.doc(_auth.currentUser!.uid).get().then(
      (value) {
        var snapshot = value.data() as Map<String, dynamic>;
        isChatNtf.value = snapshot['chatPushNtf'];
        isActivitNtf.value = snapshot['activityPushNtf'];
        isNightNtf.value = snapshot['nightPushNtf'];
        isMarketingConsent.value = snapshot['marketingConsent'];
      },
    );
  }

  // 채팅알림 토글 버튼 클릭 시 업데이트
  Future updateChatPushNtf(chatPushNtf) async {
    return _userDB.doc(_auth.currentUser!.uid).update(
      {
        'chatPushNtf': chatPushNtf,
      },
    );
  }

  // 활동알림 토글 버튼 클릭 시 업데이트
  Future updateActivityPushNtf(activityPushNtf) async {
    return _userDB.doc(_auth.currentUser!.uid).update(
      {
        'activityPushNtf': activityPushNtf,
      },
    );
  }

  // 앱 소식 및 공지 알림 토글 버튼 클릭 시 업데이트
  Future updateNightPushNtf(nightPushNtf) async {
    return _userDB.doc(_auth.currentUser!.uid).update(
      {
        'nightPushNtf': nightPushNtf,
      },
    );
  }

  // 마케팅 수신 동의 토글 버튼 클릭 시 업데이트
  Future updateMarketingConsent(marketingConsent) async {
    return _userDB.doc(_auth.currentUser!.uid).update(
      {
        'marketingConsent': marketingConsent,
      },
    );
  }

  // 알림 권한 요청
  // 알림권한 false인 상태에서 설정에서 버튼을 눌러 on으로 바꾸려고 할 때 선언
  Future requestNotificationPermission() async {
    // 권한 요청
    PermissionStatus status = await Permission.notification.request();
    // 결과 확인
    if (status.isGranted) {
      // 승인된 경우
      null;
    } else {
      // 거절된 경우
      Get.dialog(
        // 다이어로그 띄우기
        CustomSmallDialog(
          '기기 알림 설정 변경을 위해\n시스템 설정으로 이동합니다.',
          '취소',
          '확인',
          () => Get.back(),
          () {
            Get.back();
            // 앱 설정으로 이동,
            openAppSettings();
          },
        ),
      );
    }
  }
}
