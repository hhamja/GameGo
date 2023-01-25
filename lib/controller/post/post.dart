import 'package:mannergamer/utilites/index/index.dart';

class PostController extends GetxController with StateMixin<RxList<PostModel>> {
  static PostController get to => Get.find<PostController>();
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  // RxList postList [] 선언
  RxList<PostModel> postList = <PostModel>[].obs;
  // Post Id로 받은 게시글정보
  Rx<PostModel> _postInfo = PostModel(
    postId: '',
    uid: '',
    userName: '',
    profileUrl: '',
    title: '',
    maintext: '',
    gamemode: '',
    like: 0,
    gameType: '',
    createdAt: Timestamp.now(),
  ).obs;
  PostModel get postInfo => _postInfo.value;
  // postId로 받은 데이터에서 uid를 다시 넣어 유저의 매너나이 받기
  RxString _mannerAge = ''.obs;
  String get mannerAge => _mannerAge.value;

  @override
  void onInit() {
    readPostData();
    super.onInit();
  }

  /* 만든 게시글 데이터 서버로 보내기 */
  Future createPost(PostModel postModel) async {
    // 루트 컬렉션 post에 저장
    _postDB.doc(postModel.postId).set(
      // 문서의 id는 파이어스토어의 자동id 생성 값
      {
        'postId': postModel.postId,
        'uid': postModel.uid,
        'userName': postModel.userName,
        'profileUrl': postModel.profileUrl,
        'title': postModel.title,
        'maintext': postModel.maintext,
        'gamemode': postModel.gamemode,
        'position': postModel.position,
        'tear': postModel.tear,
        'like': postModel.like,
        'gameType': postModel.gameType,
        'createdAt': postModel.createdAt,
      },
    );
  }

  /* 모든 게시물 리스트로 받기 */
  Future readPostData() async {
    // 데이터 받기 전 로딩상태
    change(postList, status: RxStatus.loading());
    // 파이어스토어 DB에서 데이터 받기
    await _postDB.orderBy('createdAt', descending: true).get().then(
          (snapshot) => postList.assignAll(
              snapshot.docs.map((e) => PostModel.fromDocumentSnapshot(e))),
          onError: (err) => change(null,
              status: RxStatus.error(err.toString())), //데이터 받는 과정에서 에러나는 경우
        );
    // 데이터가 있다 ? 완료상태 : 빈 상태
    if (postList.isNotEmpty || postList.length > 0) {
      //데이터 받은 후 완료상태로 변경
      return change(postList, status: RxStatus.success());
    } else {
      //리스트가 비었을 경우
      return change(postList, status: RxStatus.empty());
    }
  }

  /* 게시글을 게임모드 필터링하여 받기 */
  Future filterGamemode(gamemode) async {
    // 리스트 초기화
    postList.clear();
    // 데이터 받기 전 로딩상태
    change(postList, status: RxStatus.loading());
    await _postDB
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .get()
        .then(
          (snapshot) => postList.assignAll(
              snapshot.docs.map((e) => PostModel.fromDocumentSnapshot(e))),
          // 데이터 받는 과정에서 에러나는 경우
          onError: (err) =>
              change(null, status: RxStatus.error(err.toString())),
        );
    // 데이터가 있다 ? 완료상태 : 빈 상태
    if (postList.isNotEmpty || postList.length > 0) {
      // 데이터 받은 후 완료상태로 변경
      return change(postList, status: RxStatus.success());
    } else {
      // 리스트가 비었을 경우
      return change(postList, status: RxStatus.empty());
    }
  }

  /* 게시글을 게임모드, 포지션 필터링하여 받기 */
  Future filterPosition(gamemode, position) async {
    // 리스트 초기화
    postList.clear();
    // 데이터 받기 전 로딩상태
    change(postList, status: RxStatus.loading());
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
    // 데이터가 있다 ? 완료상태 : 빈 상태
    if (postList.isNotEmpty || postList.length > 0) {
      // 데이터 받은 후 완료상태로 변경
      return change(postList, status: RxStatus.success());
    } else {
      // 리스트가 비었을 경우
      return change(postList, status: RxStatus.empty());
    }
  }

  /* 게시글을 게임모드, 포지션, 티어 필터링하여 받기 */
  Future filterTear(gamemode, position, tear) async {
    // 리스트 초기화
    postList.clear();
    // 데이터 받기 전 로딩상태
    change(postList, status: RxStatus.loading());
    await _postDB
        .orderBy('createdAt', descending: true)
        .where('gamemode', isEqualTo: gamemode)
        .where('position', isEqualTo: position)
        .where('tear', isEqualTo: tear)
        .get()
        .then(
            (snapshot) => postList.assignAll(
                snapshot.docs.map((e) => PostModel.fromDocumentSnapshot(e))),
            //데이터 받는 과정에서 에러나는 경우
            onError: (err) => change(
                  null,
                  status: RxStatus.error(err.toString()),
                ));
    // 데이터가 있다 ? 완료상태 : 빈 상태
    if (postList.isNotEmpty || postList.length > 0) {
      //데이터 받은 후 완료상태로 변경
      return change(postList, status: RxStatus.success());
    } else {
      //리스트가 비었을 경우
      return change(postList, status: RxStatus.empty());
    }
  }

  /* 게시글 수정하기 */
  Future updatePost(postid, String title, String maintext, String gamemode,
      String? position, String? tear) async {
    // post 정보를 수정
    await _postDB.doc(postid).update(
      {
        'title': title,
        'maintext': maintext,
        'gamemode': gamemode,
        'position': position,
        'tear': tear,
      },
    );
    // notification의 postTitle 수정
    await FirebaseFirestore.instance
        .collection('notification')
        .where('postId', isEqualTo: postid)
        .get()
        .then(
      (value) {
        // ntf id를 담을 빈 리스트
        var _ntfIdList = [];
        // 쿼리한 postId에 해당 하는 ntf id를 리스트에 넣기
        _ntfIdList.assignAll(
          value.docs.map(
            (e) => e.reference.id,
          ),
        );
        // 반복문 -> notification의 postTitle 수정
        _ntfIdList.forEach(
          (id) {
            FirebaseFirestore.instance
                .collection('notification')
                .doc(id)
                .update(
              //게시글 제목 수정
              {
                'postTitle': title,
              },
            ).then(
              (_) => print('ntf에서 게시글 제목 수정'),
            );
          },
        );
      },
      onError: (e) => print(e),
    );
  }

  /* 게시글 삭제하기 */
  Future deletePost(postid) async {
    final data = await _postDB.doc(postid).delete();
    return data;
  }

  /* postId을 통해서 특정 게시글의 데이터 받기 */
  Future getPostInfoByid(postId) async {
    // 특정 게시글의 데이터 Rx<PostModel> _postInfo에 담기
    await _postDB.doc(postId).get().then(
      (e) {
        _postInfo.value = PostModel.fromDocumentSnapshot(e);
        print(_postInfo);
      },
    );
    // 1번에서 담은 데이터 중 uid를 넣어 게시자의 매너나이 데이터 받기
    _userDB.doc(_postInfo.value.uid).get().then(
      (e) {
        var data = e.data() as Map<String, dynamic>;
        // 매너나이 프린트
        print(data['mannerAge']);
        // num인 매너나이 String으로
        _mannerAge.value = data['mannerAge'].toString();
        print(_mannerAge.value);
      },
    );
  }
}
