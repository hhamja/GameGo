import 'package:mannergamer/utilites/index/index.dart';

class NtfController extends GetxController {
  final CollectionReference _ntfDB =
      FirebaseFirestore.instance.collection('notification');
  /* 알림 목록 받을 RXList */
  RxList<NotificationModel> ntfList = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getNtfList();
    print(CurrentUser.uid);
  }

  /* 나의 알림 목록 받기 */
  Future getNtfList() async {
    await _ntfDB
        .orderBy('createdAt', descending: true)
        .where('idTo', whereIn: [CurrentUser.uid, 'ALL']) //나에게 온 모든 알림 쿼리
        .get()
        .then(
          (snapshot) => ntfList.assignAll(
            snapshot.docs.map(
              (e) => NotificationModel.fromDocumentSnapshot(e),
            ),
          ),
        );
  }
}
