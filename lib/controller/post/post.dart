import 'package:mannergamer/utilites/index/index.dart';

class PostController extends GetxController with StateMixin<RxList<PostModel>> {
  static PostController get to => Get.find<PostController>();
  /* 파이어스토어 Post 컬렉션 참조 instance */
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  /* RxList postList [] 선언 */
  RxList<PostModel> postList = <PostModel>[].obs;
  /* Post Id로 받은 게시글정보 */
  RxMap<String, dynamic> postInfo = Map<String, dynamic>().obs;
  /* Post Id로 받은 게시글정보 */
  // Rx<PostModel> postInfo = <PostModel>().obs;

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
      'like': postModel.like,
      'createdAt': postModel.createdAt,
    });
    return res;
  }

  /* Future로 게시물 전체 받기 */
  Future readPostData() async {
    change(postList, status: RxStatus.loading()); //데이터 받기 전 로딩상태
    //파이어스토어 DB에서 데이터 받기
    await _postDB.orderBy('createdAt', descending: true).get().then(
          (snapshot) => postList.assignAll(
              snapshot.docs.map((e) => PostModel.fromDocumentSnapshot(e))),
          onError: (err) => change(null,
              status: RxStatus.error(err.toString())), //데이터 받는 과정에서 에러나는 경우
        );
    /* 데이터가 있다 ? 완료상태 : 빈 상태 */
    if (postList.isNotEmpty || postList.length > 0) {
      return change(postList, status: RxStatus.success()); //데이터 받은 후 완료상태로 변경
    } else {
      return change(postList, status: RxStatus.empty()); //리스트가 비었을 경우
    }
  }

  /* 게시글을 게임모드 필터링하여 받기 */
  Future filterGamemode(gamemode) async {
    postList.clear(); //리스트 초기화
    change(postList, status: RxStatus.loading()); //데이터 받기 전 로딩상태
    await _postDB
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .get()
        .then(
          (snapshot) => postList.assignAll(
              snapshot.docs.map((e) => PostModel.fromDocumentSnapshot(e))),
          onError: (err) => change(null,
              status: RxStatus.error(err.toString())), //데이터 받는 과정에서 에러나는 경우
        );
    /* 데이터가 있다 ? 완료상태 : 빈 상태 */
    if (postList.isNotEmpty || postList.length > 0) {
      return change(postList, status: RxStatus.success()); //데이터 받은 후 완료상태로 변경
    } else {
      return change(postList, status: RxStatus.empty()); //리스트가 비었을 경우
    }
  }

  /* 게시글을 게임모드, 포지션 필터링하여 받기 */
  Future filterPosition(gamemode, position) async {
    postList.clear(); //리스트 초기화
    change(postList, status: RxStatus.loading()); //데이터 받기 전 로딩상태
    await _postDB
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .where('position', isEqualTo: position)
        .get()
        .then(
          (snapshot) => postList.assignAll(
              snapshot.docs.map((e) => PostModel.fromDocumentSnapshot(e))),
          onError: (err) => change(null,
              status: RxStatus.error(err.toString())), //데이터 받는 과정에서 에러나는 경우
        );
    /* 데이터가 있다 ? 완료상태 : 빈 상태 */
    if (postList.isNotEmpty || postList.length > 0) {
      return change(postList, status: RxStatus.success()); //데이터 받은 후 완료상태로 변경
    } else {
      return change(postList, status: RxStatus.empty()); //리스트가 비었을 경우
    }
  }

  /* 게시글을 게임모드, 포지션, 티어 필터링하여 받기 */
  Future filterTear(gamemode, position, tear) async {
    postList.clear(); //리스트 초기화
    change(postList, status: RxStatus.loading()); //데이터 받기 전 로딩상태
    await _postDB
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .where('position', isEqualTo: position)
        .where('tear', isEqualTo: tear)
        .get()
        .then(
            (snapshot) => postList.assignAll(
                snapshot.docs.map((e) => PostModel.fromDocumentSnapshot(e))),
            onError: (err) => change(
                  null,
                  status: RxStatus.error(err.toString()),
                ) //데이터 받는 과정에서 에러나는 경우
            );
    /* 데이터가 있다 ? 완료상태 : 빈 상태 */
    if (postList.isNotEmpty || postList.length > 0) {
      return change(postList, status: RxStatus.success()); //데이터 받은 후 완료상태로 변경
    } else {
      return change(postList, status: RxStatus.empty()); //리스트가 비었을 경우
    }
  }

  /* 게시글 수정하기 */
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

  /* 게시글 삭제하기 */
  Future deletePost(postid) async {
    try {
      final data = await _postDB.doc(postid).delete();
      return data;
    } catch (e) {
      print('deletePost error : ${e}');
    }
  }

  /* postId을 통해서 특정 게시글의 데이터 받기 */
  Future getPostInfoByid(postId) async {
    await _postDB.doc(postId).get().then((value) {
      postInfo.value = value.data()! as Map<String, dynamic>;
      print(postInfo); //게시글 데이터 프린트
    });
  }
}
