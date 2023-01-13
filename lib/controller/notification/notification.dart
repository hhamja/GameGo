import 'package:mannergamer/utilites/index/index.dart';

class NtfController extends GetxController {
  final CollectionReference _ntfDB =
      FirebaseFirestore.instance.collection('notification');
  /* 알림 목록 받을 RXList */
  RxList<NotificationModel> ntfList = <NotificationModel>[].obs;
  /* 게시글 제목 */
  Rx<String> postTitle = ''.obs;
  /* idFrom으로 받은 유저이름 */
  Rx<String> userName = ''.obs;

  /* notification에 추가하기 */
  Future addNotification(NotificationModel model) async {
    await _ntfDB.add(
      {
        'idFrom': model.idFrom,
        'idTo': model.idTo,
        'postId': model.postId,
        'content': model.content,
        'postTitle': model.postTitle,
        'userName': model.userName,
        'type': model.type,
        'createdAt': model.createdAt,
      },
    );
  }

  /* 나의 알림 목록 받기 */
  Future getNtfList() async {
    await _ntfDB
        .orderBy('createdAt', descending: true)
        .where('idTo', whereIn: [CurrentUser.uid, 'ALL']) //나에게 + 앱 공지
        .get()
        .then(
          (snapshot) => ntfList.assignAll(
            snapshot.docs.map((e) {
              return NotificationModel.fromDocumentSnapshot(e);
            }),
          ),
        );
  }

  // /* ntfList의 postId를 이용하여 게시글 제목 받기 */
  // Future<String> getPostTitle(postId) async {
  //   return await FirebaseFirestore.instance
  //       .collection('post')
  //       .doc(postId)
  //       .get()
  //       .then((value) {
  //     var snapshot = value.data() as Map<String, dynamic>;
  //     return snapshot['title'];
  //   });
  // }

  // /* ntfList의 idFrom 이용하여 ntf 보낸 유저이름 받기 */
  // void getUserName(uid) async {
  //   await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(uid)
  //       .get()
  //       .then((value) {
  //     var snapshot = value.data() as Map<String, dynamic>;
  //     return userName.value = snapshot['userName'];
  //   });
  // }
}
