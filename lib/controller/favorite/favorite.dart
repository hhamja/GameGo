import 'package:mannergamer/model/favorite/favoriteList.model.dart';
import 'package:mannergamer/utilites/index/index.dart';

class FavoriteController extends GetxController {
  static FavoriteController get to => Get.find<FavoriteController>();

  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  final CollectionReference _favoriteDB =
      FirebaseFirestore.instance.collection('favorite');
  final NtfController _ntf = Get.put(NtfController());

  // 게시물 관심 버튼 클릭하면 on/off 되는 bool 값
  RxBool isFavorite = false.obs;
  // 나의 관심 게시물 리스트
  RxList<FavoriteListModel> favoriteList = <FavoriteListModel>[].obs;

  /* 관심게시글로 지정했는지 확인 */
  isFavoritePost(postId) async {
    // 나의 관심게시글 경로 참조
    final ref = await _favoriteDB
        .doc('favorite')
        .collection(CurrentUser.uid)
        .doc(postId)
        .get();
    // 해당 게시글이 나의 관심게시글인지 확인
    if (ref.exists) {
      // 나의 관심게시글인 경우
      isFavorite.value = true;
    } else {
      // 나의 관심게시글이 아닌 경우
      isFavorite.value = false;
    }
  }

  /* 관심 버튼 클릭 시 추가 및 제거 */
  Future clickfavoriteButton(
      FavoriteModel favoriteModel, NotificationModel ntfModel) async {
    if (isFavorite.value) {
      // 관심게시글인 경우
      print('이 게시글은 나의 관심게시글임');
      // 나의 관심목록에서 제거
      _favoriteDB
          .doc('favorite')
          .collection(CurrentUser.uid)
          .doc(favoriteModel.postId)
          .delete();
      // 해당 게시물 like값 -1
      _postDB.doc(favoriteModel.postId).update({
        'like': FieldValue.increment(-1),
      });
    } else {
      // 관심게시글 아닌 경우
      print('이 게시글은 나의 관심게시글이 아님');
      // 관심게시글로 추가
      _favoriteDB
          .doc('favorite')
          .collection(CurrentUser.uid)
          .doc(favoriteModel.postId)
          .set(
        {
          'postId': favoriteModel.postId,
          'idFrom': favoriteModel.idFrom,
          'idTo': favoriteModel.idTo,
          'createdAt': favoriteModel.createdAt,
        },
      );
      // 관심게시글 추가에 대해 알림 추가
      _ntf.addNotification(ntfModel);
      // 해당 게시물의 like값 +1
      _postDB.doc(favoriteModel.postId).update(
        {
          'like': FieldValue.increment(1),
        },
      );
    }
    // 관심버튼 상태를 나타내는 bool변수 토글화
    isFavorite.value = !isFavorite.value;
  }

  /* 나의 관심 게시글 리스트 받기 */
  Future getFavoriteList() async {
    // 관심게시글 id 리스트
    List _postIdList = [];
    // 관심게시글의 postId의 리스트를 받아서 넣기
    await _favoriteDB
        .doc('favorite')
        .collection(CurrentUser.uid)
        .orderBy('createdAt', descending: true)
        .get()
        .then(
          // 반복문
          (snapshot) => _postIdList.assignAll(
            snapshot.docs
                .map(
                  // id값을 리스트에 넣기
                  (e) => e.reference.id,
                )
                .toList(),
          ),
        );
    // 반복문
    return _postIdList.forEach(
      // postId을 루트 컬렉션 post에서 게시글 데이터 받기
      (id) => _postDB.doc(id).get().then(
            (e) => favoriteList.add(
              FavoriteListModel.fromDocumentSnapshot(e),
            ),
          ),
    );
  }
}
