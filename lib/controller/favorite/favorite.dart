import 'package:mannergamer/utilites/index/index.dart';

class FavoriteController extends GetxController {
  static FavoriteController get to => Get.find<FavoriteController>();
  /* 파이어스토어 user 컬렉션 참조 instance */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* 파이어스토어 post 컬렉션 참조 instance */
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('user');
  /* 게시물 좋아요 버튼 클릭하면 on/off 되는 bool 값 */
  RxBool isFavorite = false.obs;
  /* 나의 관심 게시물 리스트 */
  RxList<PostModel> favoriteList = <PostModel>[].obs;

  /* 해당 게시물이 관심 게시물인지 여부를 bool값으로 리턴하기 */
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

  /* 관심게시물 추가/제거하기 */
  favoritePost(uid, postId) async {
    final ref = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('favorite')
        .doc(postId)
        .get(); //게시물 존재여부를 얻기위한 변수
    /* 관심 게시물이 아니라면? */
    if (!ref.exists) {
      FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .collection('favorite')
          .doc(postId)
          .set({'isFavorite': true, 'updatedAt': Timestamp.now()}); //나의 관심에 추가
      FirebaseFirestore.instance
          .collection('post')
          .doc(postId)
          .update({'like': FieldValue.increment(1)}); //해당 게시물의 like값 +1
    } else {
      FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .collection('favorite')
          .doc(postId)
          .delete(); //나의 관심목록에서 제거
      FirebaseFirestore.instance
          .collection('post')
          .doc(postId)
          .update({'like': FieldValue.increment(-1)}); //해당 게시물 like값 -1
    }
    isFavorite.value = !isFavorite.value; //토글버튼
  }

  /* DB에서 관심 게시글 받기 */
  Future getFavoriteList(uid) async {
    List postIdList = [];
    final ref = _userDB.doc(uid).collection('favorite');
    await ref.orderBy('updatedAt', descending: true).get().then(
        (value) => postIdList.assignAll(value.docs.map((e) => e.reference.id)));
    print(postIdList);
    for (var id in postIdList) {
      final doc = _postDB.doc(id).get();
      print(doc);
    }
  }
}
  