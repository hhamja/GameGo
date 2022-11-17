import 'package:mannergamer/utilites/index/index.dart';

class MyPostListController extends GetxController {
  /* Post DB */
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  final _currentUid = FirebaseAuth.instance.currentUser!.uid; //현재유저 UID

  /* 모든 나의 게시글 리스트 담는 RxList 변수 */
  RxList<PostModel> myPostList = <PostModel>[].obs;

  Future getMyPostList() async {
    await _postDB
        .where('uid', isEqualTo: _currentUid) //현재유저가 만든 게시글만 쿼리
        .orderBy('createdAt', descending: true) //최신일수록 맨위에 오도록 정렬
        .get()
        .then(
          (snapshot) => myPostList.assignAll(snapshot.docs.map(
            (e) => PostModel.fromDocumentSnapshot(e),
          )),
        );
  }
}
