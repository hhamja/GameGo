import 'package:mannergamer/model/favorite/favoriteList.model.dart';
import 'package:mannergamer/utilites/index/index.dart';

class FavoriteController extends GetxController {
  static FavoriteController get to => Get.find<FavoriteController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  final CollectionReference _favoriteDB =
      FirebaseFirestore.instance.collection('favorite');

  // 나의 관심 게시물 리스트
  RxList<FavoriteListModel> favoriteList = <FavoriteListModel>[].obs;

  // 나의 관심 게시글 리스트 받기
  Future getFavoriteList() async {
    // 관심게시글 id 리스트
    List _postIdList = [];
    // 관심게시글의 postId의 리스트를 받아서 넣기
    await _favoriteDB
        .doc('favorite')
        .collection(_auth.currentUser!.uid)
        .orderBy('createdAt', descending: true)
        .get()
        .then(
          // 반복문
          (snapshot) => _postIdList.assignAll(
            snapshot.docs.map((e) => e.reference.id).toList(),
          ),
        );
    // 반복문
    _postIdList.forEach(
      // postId을 루트 컬렉션 post에서 게시글 데이터 받기
      (id) => _postDB.doc(id).get().then(
        (e) {
          var snapshot = e.data() as Map<String, dynamic>;
          final bool isDeleted = snapshot['isDeleted'];
          final bool isHidden = snapshot['isDeleted'];
          // 삭제게시글, 탈퇴유저 게시글은 제외하여 GET
          if (isDeleted == false && isHidden == false) {
            favoriteList.add(
              FavoriteListModel.fromDocumentSnapshot(e),
            );
          }
        },
      ),
    );
    return favoriteList;
  }
}
