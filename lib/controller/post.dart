import 'package:mannergamer/utilites/index.dart';

class PostController extends GetxController {
  /* 파이어스토어 Post 컬렉션 참조 instance */
  final CollectionReference _post =
      FirebaseFirestore.instance.collection('post');

  /* RxList postList [] 선언 */
  RxList<PostModel> postList = <PostModel>[].obs;
  /* 버튼컨트롤러의 selectedValue 담은 변수 */

  /* Lifecycle */
  @override
  void onInit() {
    super.onInit();
    postList.bindStream(readPostData());
  }

  @override
  void onClose() {
    super.onClose();
  }

  /* Create Post */
  Future createPost(PostModel postModel) async {
    try {
      final res = await _post.add({
        'username': postModel.username,
        'title': postModel.title,
        'maintext': postModel.maintext,
        'gamemode': postModel.gamemode,
        'position': postModel.position,
        'tear': postModel.tear,
        'createdAt': postModel.createdAt,
      });
      print(res);
      return res;
    } catch (e) {
      print('createPost error');
    }
  }

  /* Stream Read Post */
  Stream<List<PostModel>> readPostData() {
    return _post
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              return PostModel.fromDocumentSnapshot(e);
            }).toList());
  }

  /* 게시물 게임모드 필터링 */
  Stream<List<PostModel>> filterGamemode(gamemode) {
    postList.clear();
    return _post
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              return PostModel.fromDocumentSnapshot(e);
            }).toList());
  }

  /* 게시물 포지션 필터링 */
  Stream<List<PostModel>> filterPosition(gamemode, position) {
    postList.clear();
    return _post
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .where('position', isEqualTo: position)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              return PostModel.fromDocumentSnapshot(e);
            }).toList());
  }

  /* 게시물 티어 필터링 */
  Stream<List<PostModel>> filterTear(gamemode, position, tear) {
    postList.clear();
    return _post
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .where('position', isEqualTo: position)
        .where('tear', isEqualTo: tear)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              return PostModel.fromDocumentSnapshot(e);
            }).toList());
  }

/* dsfddsf */
  /* Update Post, edit post*/
  Future updatePost(
    postid,
    String title,
    String maintext,
    String gamemode,
    String? position,
    String? tear,
  ) async {
    try {
      await _post.doc(postid).update({
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

  /* Delete Post () */
  Future deletePost(postid) async {
    try {
      final data = await _post.doc(postid).delete();
      return data;
    } catch (e) {
      print('deletePost error : ${e}');
    }
  }
}
