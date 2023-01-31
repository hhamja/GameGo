import 'package:mannergamer/utilites/index/index.dart';

class NtfController extends GetxController {
  final CollectionReference _ntfDB =
      FirebaseFirestore.instance.collection('notification');
  // 알림 목록 받을 RXList
  RxList<NotificationModel> ntfList = <NotificationModel>[].obs;
  // 게시글 제목
  Rx<String> postTitle = ''.obs;
  // idFrom으로 받은 유저이름
  Rx<String> userName = ''.obs;

  // notification에 추가하기
  Future addNotification(NotificationModel model) async {
    await _ntfDB.add(
      {
        'idFrom': model.idFrom,
        'idTo': model.idTo,
        'postId': model.postId,
        'chatRoomId': model.chatRoomId,
        'content': model.content,
        'postTitle': model.postTitle,
        'userName': model.userName,
        'type': model.type,
        'createdAt': model.createdAt,
      },
    );
  }

  // 나의 알림 목록 받기
  Future getNtfList() async {
    await _ntfDB
        .orderBy('createdAt', descending: true)
        // 나에게 + 앱 공지
        .where('idTo', whereIn: [CurrentUser.uid, 'ALL'])
        .get()
        .then(
          (snapshot) => ntfList.assignAll(
            snapshot.docs.map((e) {
              return NotificationModel.fromDocumentSnapshot(e);
            }),
          ),
        );
  }
}
