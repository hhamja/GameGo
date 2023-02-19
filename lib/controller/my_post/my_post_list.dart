import 'package:gamego/utilites/index/index.dart';

class MyPostListController extends GetxController
    with StateMixin<RxList<PostModel>> {
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxList<PostModel> myPostList = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMyPostList();
  }

  // 나의 게시글 받기
  Future getMyPostList() async {
    change(myPostList, status: RxStatus.loading());
    await _postDB
        .where('uid', isEqualTo: _auth.currentUser!.uid)
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
    // 데이터 상태 change
    if (myPostList.isNotEmpty || myPostList.length > 0) {
      // 값을 성공적으로 받은 경우
      change(myPostList, status: RxStatus.success());
    } else {
      // 빈 값인 경우
      change(myPostList, status: RxStatus.empty());
    }
  }
}
