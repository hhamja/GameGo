import 'package:mannergamer/utilites/index/index.dart';

class BadgeController extends GetxController {
  final CollectionReference _chatDB =
      FirebaseFirestore.instance.collection('chat');
  /* 현재 유저의 uid */
  final _currentUid = FirebaseAuth.instance.currentUser!.uid.toString();
  /* 내가 인읽은 메시지가 있는 채팅방 리스트
  * 채팅 탭 아이콘의 빨간배지 표시할 때 사용 */
  var unReadList = 0.obs;

  @override
  void onInit() {
    unReadList.bindStream(getUnReadCountList()); //채팅방리스트 스트림으로 받기
    print(unReadList);
    super.onInit();
  }

  /* 모든 '채팅' 리스트 스트림으로 받기 */
  Stream<int> getUnReadCountList() {
    return _chatDB
        .where('unReadCount.${_currentUid}', isNotEqualTo: 0)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((e) {
              var snapshot = e.data() as Map<String, dynamic>;
              var unReadCount = snapshot['unReadCount']['$_currentUid'];
              print(unReadCount);
              return unReadCount;
            })
            .toList()
            .length);
  }
}
