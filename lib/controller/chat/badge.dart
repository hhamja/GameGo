import 'package:mannergamer/utilites/index/index.dart';

class BadgeController extends GetxController {
  final CollectionReference _chatDB =
      FirebaseFirestore.instance.collection('chat');
  /* 내가 인읽은 메시지가 있는 채팅방 리스트
  * 채팅 탭 아이콘의 빨간배지 표시할 때 사용 */
  RxList unReadList = [].obs;

  @override
  void onInit() {
    unReadList.bindStream(getUnReadCountList()); //채팅방리스트 스트림으로 받기
    super.onInit();
  }

  /* 나의 채팅리스트의 중 unReadCount의 수 리스트를 스트림으로 받기 */
  Stream<List> getUnReadCountList() {
    return _chatDB
        .where('members', arrayContains: CurrentUser.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              var snapshot = e.data() as Map<String, dynamic>;
              var unReadCount = snapshot['unReadCount']['${CurrentUser.uid}'];
              return unReadCount;
            }).toList());
  }
}
