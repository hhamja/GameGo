import 'package:mannergamer/utilites/index/index.dart';

class NtfSettingController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* 유저의 알림 on/off에 대한 bool 변수 
  * chatPushNtf, activityPushNtf, noticePushNtf, marketingConsent */
  RxMap<String, dynamic> userNtfBool = Map<String, dynamic>().obs;

  @override
  void onInit() {
    super.onInit();
    getUserPushNtf();
    print(userNtfBool);
  }

  Future getUserPushNtf() async {
    await _userDB.doc(CurrentUser.uid).get().then(
          (value) => userNtfBool.value =
              NotificationSettingModel.fromDocumentSnapshot(value)
                  as Map<String, dynamic>,
        );
  }

  Future updateUserPushNtf() async {
    await _userDB.doc(CurrentUser.uid).update(
      {},
    );
  }
}
