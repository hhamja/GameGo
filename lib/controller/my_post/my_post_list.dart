import 'package:mannergamer/utilites/index/index.dart';

class MyPostListController extends GetxController {
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');

  // 모든 나의 게시글 리스트 담는 RxList 변수
  RxList<PostModel> myPostList = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMyPostList();
  }

  // 나의 게시글 받기
  Future getMyPostList() async {
    return _postDB
        .where('uid', isEqualTo: CurrentUser.uid)
        .where('isDeleted', isEqualTo: false)
        .where('isHidden', isEqualTo: false)
        .orderBy('updatedAt', descending: true)
        .get()
        .then(
          (snapshot) => myPostList.assignAll(
            snapshot.docs
                .map(
                  (e) => PostModel.fromDocumentSnapshot(e),
                )
                .toList(),
          ),
        );
  }
}
