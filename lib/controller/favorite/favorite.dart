import 'package:mannergamer/utilites/index/index.dart';

class FavoriteController extends GetxController {
  static FavoriteController get to => Get.find<FavoriteController>();
  /* 파이어스토어 user 컬렉션 참조 instance */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* 파이어스토어 post 컬렉션 참조 instance */
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('user');
  /* 나의 관심 게시물 리스트 */
  RxList<FavoriteModel> favoriteList = <FavoriteModel>[].obs;
  /* 게시물 좋아요 버튼 클릭하면 on/off 되는 bool 값 */
  RxBool isFavorite = false.obs;

  changeColor() {
    isFavorite.value = !isFavorite.value;
  }

  isFavoritePost(uid, postId) async {
    final ref = await _userDB
        .doc(uid)
        .collection('favorite')
        .doc(postId)
        .get(); //게시물 존재여부를 얻기위한 변수
    if (ref.exists) {
      isFavorite.value = true;
    } else {
      isFavorite.value = false;
    } //해당 게시물이 관심목록에 존재한다면? true : false
  }

  /* 나의 관심 게시물에 추가하기 */
  Future favorite(String uid, postId) async {
    await _userDB.doc(uid).collection('favorite').doc(postId).set(
        {'isFavorite': true, 'updatedAt': Timestamp.now()}); //해당 게시물을 관심목록에 추가
    await _postDB
        .doc(postId)
        .update({'like': FieldValue.increment(1)}); //게시물의 like값 +1
  }

  /* 나의 관심 게시물에서 제거하기 */
  Future unfavorite(String uid, String postId) async {
    await _userDB
        .doc(uid)
        .collection('favorite')
        .doc(postId) //id는 favorited post의 id
        .delete();
    await _postDB
        .doc(postId)
        .update({'like': FieldValue.increment(-1)}); //게시물 like -1
  }

  /* 나의 관심 게시물 목록 리스트로 받기 */
  Future getFavoriteList(uid) async {
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

  /* 게시물 좋아요 수 +1 증가시키기 (하트 클릭 시 ) */
  Future increaseLike(postId, likeCount) async {
    try {} catch (e) {
      print(e);
    }
  }

  /* 게시물 좋아요 수 -1 감소시키기 (하트 클릭 시 ) */
  Future decreaseLike(postId, likeCount) async {
    try {} catch (e) {
      print(e);
    }
  }
}
