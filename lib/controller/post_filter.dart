import 'package:mannergamer/utilites/index.dart';

class FilterPostController extends GetxController {
  /* FireStore Instance */
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  /* Gamemode 결과 값 담을 RxList */
  RxList<PostModel> gamemodeResultList = <PostModel>[].obs;
  /* Position 결과 값 담을 RxList */
  RxList<PostModel> positionResultList = <PostModel>[].obs;
  /* Tear 결과 값 담을 RxList */
  RxList<PostModel> tearResultList = <PostModel>[].obs;

  /* Lifecycle */
  @override
  void onInit() {
    super.onInit();
    gamemodeResultList.bindStream(readPostData());
    positionResultList.bindStream(readPostData());
    tearResultList.bindStream(readPostData());
  }

  @override
  void onClose() {
    super.onClose();
  }

  /* Stream Read Post */
  Stream<List<PostModel>> readPostData() {
    return firestore
        .collection('post')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<PostModel> posts = [];
      for (var post in query.docs) {
        final todoModel = PostModel.fromDocumentSnapshot(post);
        posts.add(todoModel);
      }
      return posts;
    });
  }

  /* 게임모드 필터 */
  filterGamemode() async {
    try {
      await firestore
          .collection('post')
          .where('gamemode', isEqualTo: true)
          .get();
    } catch (e) {
      print('Gamemode Filter Error : ${e}');
    }
  }

  /* 포지션 필터 */
  filterPosition() async {
    try {
      await firestore
          .collection('post')
          .where('position', isEqualTo: true)
          .get();
    } catch (e) {
      print('Position Filter Error : ${e}');
    }
  }

  /* 티어 필터 */
  filterTear() async {
    try {
      await firestore.collection('post').where('tear', isEqualTo: true).get();
    } catch (e) {
      print('Gamemode Filter Error : ${e}');
    }
  }
}
