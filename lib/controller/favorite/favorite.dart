import 'package:mannergamer/model/favorite/favoriteList.model.dart';
import 'package:mannergamer/utilites/index/index.dart';

class FavoriteController extends GetxController
    with StateMixin<RxList<FavoriteListModel>> {
  static FavoriteController get to => Get.find<FavoriteController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  final CollectionReference _favoriteDB =
      FirebaseFirestore.instance.collection('favorite');

  // 나의 관심 게시물 리스트
  RxList<FavoriteListModel> favoriteList = <FavoriteListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFavoriteList();
  }

  @override
  void onClose() {
    // favoriteList.value = [];
    super.onClose();
  }

  // 나의 관심 게시글 리스트 받기
  Future getFavoriteList() async {
    final List _list = [];
    await _favoriteDB
        .doc('favorite')
        .collection(_auth.currentUser!.uid)
        .orderBy('createdAt', descending: true)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (e) => _list.add(e.reference.id),
          ),
        );
    change(favoriteList, status: RxStatus.loading());
    // 반복문
    for (var id in _list) {
      // 비삭제, 비탈퇴 게시글 쿼리
      final QuerySnapshot value = await _postDB
          .where('isDeleted', isEqualTo: false)
          .where('isHidden', isEqualTo: false)
          .where('postId', isEqualTo: id)
          .get();
      // 쿼리 조건을 만족하는 게시글 정보를 리스트에 add하기
      value.docs.forEach(
        (e) => favoriteList.add(FavoriteListModel.fromDocumentSnapshot(e)),
      );
    }
    // 데이터 상태에 다른 RxStatue 정의
    if (favoriteList.isNotEmpty || favoriteList.length > 0) {
      // 값이 존재
      return change(favoriteList, status: RxStatus.success());
    } else {
      // 값이 없음
      return change(favoriteList, status: RxStatus.empty());
    }
  }
}
