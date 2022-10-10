import 'package:mannergamer/utilites/index.dart';

class PostController extends GetxController {
  static PostController get to => Get.find<PostController>();
  /* 파이어스토어 Post 컬렉션 참조 instance */
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');

  /* 유저 컨트롤러 */
  final UserController _user = Get.put(UserController());
  /* RxList postList [] 선언 */
  RxList<PostModel> postList = <PostModel>[].obs;

  final userModel = UserModel().obs;

  /* Lifecycle */
  @override
  void onInit() {
    super.onInit();
    postList.bindStream(readPostData());
    userModel.bindStream(_user.getUserInfo('yCANOOvMIHaBLsllv8VkQEQ6DMr2'));
  }

  @override
  void onClose() {
    super.onClose();
  }

  /* Create Post */
  Future createPost(PostModel postModel) async {
    try {
      final res = await _postDB.doc(postModel.postId).set({
        'postId': postModel.postId,
        'uid': postModel.uid,
        'title': postModel.title,
        'maintext': postModel.maintext,
        'gamemode': postModel.gamemode,
        'position': postModel.position,
        'tear': postModel.tear,
        'createdAt': postModel.createdAt,
      });
      return res;
    } catch (e) {
      print('createPost error');
    }
  }

  /* 스트림으로 게시물 전체 받기 */
  Stream<List<PostModel>> readPostData() async* {
    try {
      await _postDB
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((e) {
                userModel.bindStream(_user.getUserInfo(e['uid']));
                return PostModel.fromDocumentSnapshot(e, userModel.value);
              }).toList());
    } catch (e) {}
  }

  /* 게시물 - 게임모드 필터링 */
  Stream<List<PostModel>> filterGamemode(gamemode) async* {
    postList.clear();
    await _postDB
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              userModel.bindStream(_user.getUserInfo(e['uid']));
              return PostModel.fromDocumentSnapshot(e, userModel.value);
            }).toList());
  }

  /* 게시물 - 포지션 필터링 */
  Stream<List<PostModel>> filterPosition(gamemode, position) async* {
    postList.clear();
    await _postDB
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .where('position', isEqualTo: position)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              userModel.bindStream(_user.getUserInfo(e['uid']));
              return PostModel.fromDocumentSnapshot(e, userModel.value);
            }).toList());
  }

  /* 게시물 - 티어 필터링 */
  Stream<List<PostModel>> filterTear(gamemode, position, tear) async* {
    postList.clear();
    await _postDB
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .where('position', isEqualTo: position)
        .where('tear', isEqualTo: tear)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              userModel.bindStream(_user.getUserInfo(e['uid']));
              return PostModel.fromDocumentSnapshot(e, userModel.value);
            }).toList());
  }

  /* 게시물 수정하기 */
  Future updatePost(
    postid,
    String title,
    String maintext,
    String gamemode,
    String? position,
    String? tear,
  ) async {
    try {
      await _postDB.doc(postid).update({
        'title': title,
        'maintext': maintext,
        'gamemode': gamemode,
        'position': position,
        'tear': tear,
      });
    } catch (e) {
      print('updatePost error : ${e}');
    }
  }

  /* 게시물 삭제하기 */
  Future deletePost(postid) async {
    try {
      final data = await _postDB.doc(postid).delete();
      return data;
    } catch (e) {
      print('deletePost error : ${e}');
    }
  }
}
