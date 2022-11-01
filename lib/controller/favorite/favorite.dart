import 'package:mannergamer/utilites/index/index.dart';

class FavoriteController extends GetxController {
  /* 파이어스토어 like 컬렉션 참조 instance */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* 나의 관심 게시물 리스트 */
  RxList<FavoriteModel> favoriteList = <FavoriteModel>[].obs;
  /* 게시물 좋아요 버튼 클릭하면 on/off 되는 bool 값 */
  bool isFavorite = false;

  /* 나의 관심 게시물에 추가하기 */
  Future favoritePost(String uid, FavoriteModel favoriteModel) async {
    await _userDB
        .doc(uid)
        .collection('favorite')
        .doc(favoriteModel.id) //id는 favorited post의 id
        .set({
      'isFavorite': favoriteModel.isFavorite,
      'updatedAt': favoriteModel.updatedAt, //관심목록에 추가된 시간
    });
    isFavorite = !isFavorite;
    update();
  }

  /* 나의 관심 게시물에 추가하기 */
  Future unfavoritePost(String uid, String postId) async {
    await _userDB
        .doc(uid)
        .collection('favorite')
        .doc(postId) //id는 favorited post의 id
        .delete();
    isFavorite = !isFavorite;
    update();
  }

  /* 나의 관심 게시물 목록 리스트로 받기 */
  Future getFavoritePost(uid) async {
    try {
      await _userDB
          .doc(uid)
          .collection('favorite')
          .orderBy('updatedAt', descending: true)
          .get()
          .then(
            (snapshot) => favoriteList.assignAll(snapshot.docs
                .map((e) => FavoriteModel.fromDocumentSnapshot(e))),
          );
    } catch (e) {
      print(e);
    }
  }
}
