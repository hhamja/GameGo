import 'package:mannergamer/utilites/index.dart';

class PostController extends GetxController {
  static PostController get to => Get.find<PostController>();
  /* 파이어스토어 Post 컬렉션 참조 instance */
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  /* RxList postList [] 선언 */
  RxList<PostModel> postList = <PostModel>[].obs;
  /* 게시물 리스트 받아올 때 로딩상태를 나타내줄 값 */
  var isLoading = false.obs;

  @override
  void onInit() {
    readPostData();
    super.onInit();
  }

  /* Create Post */
  Future createPost(PostModel postModel) async {
    final res = await _postDB.doc(postModel.postId).set({
      'postId': postModel.postId,
      'uid': postModel.uid,
      'userName': postModel.userName,
      'profileUrl': postModel.profileUrl,
      'mannerAge': postModel.mannerAge,
      'title': postModel.title,
      'maintext': postModel.maintext,
      'gamemode': postModel.gamemode,
      'position': postModel.position,
      'tear': postModel.tear,
      'createdAt': postModel.createdAt,
    });
    return res;
  }

  /* Future로 게시물 전체 받기 */
  Future readPostData() async {
    isLoading == true; //데이터 받기 전 로딩 중
    final res = await _postDB.orderBy('createdAt', descending: true).get();
    postList.assignAll(res.docs.map((e) => PostModel.fromDocumentSnapshot(e)));
    isLoading == false; //데이터 받은 후 로딩 끝
    return postList;
  }

  /* 게시글을 게임모드 필터링하여 받기 */
  Future filterGamemode(gamemode) async {
    postList.clear(); //리스트 초기화
    isLoading == true; //데이터 받기 전 로딩 중
    final res = await _postDB
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .get();
    postList.assignAll(res.docs.map((e) => PostModel.fromDocumentSnapshot(e)));
    isLoading == false; //데이터 받은 후 로딩 끝
    return postList;
  }

  /* 게시글을 게임모드, 포지션 필터링하여 받기 */
  Future filterPosition(gamemode, position) async {
    postList.clear(); //리스트 초기화
    isLoading == true; //데이터 받기 전 로딩 중
    final res = await _postDB
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .where('position', isEqualTo: position)
        .get();
    postList.assignAll(res.docs.map((e) => PostModel.fromDocumentSnapshot(e)));
    isLoading == false; //데이터 받은 후 로딩 끝
    return postList;
  }

  /* 게시글을 게임모드, 포지션, 티어 필터링하여 받기 */
  Future filterTear(gamemode, position, tear) async {
    postList.clear(); //리스트 초기화
    isLoading == true; //데이터 받기 전 로딩 중
    final res = await _postDB
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .where('position', isEqualTo: position)
        .where('tear', isEqualTo: tear)
        .get();
    postList.assignAll(res.docs.map((e) => PostModel.fromDocumentSnapshot(e)));
    isLoading == false; //데이터 받은 후 로딩 끝
    return postList;
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
