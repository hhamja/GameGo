import 'package:mannergamer/utilites/index/index.dart';

class PostController extends GetxController with StateMixin<RxList<PostModel>> {
  static PostController get to => Get.find<PostController>();
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  /* RxList postList [] 선언 */
  RxList<PostModel> postList = <PostModel>[].obs;
  /* Post Id로 받은 게시글정보 */
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
  /* postId로 받은 데이터에서 uid를 다시 넣어 유저의 매너나이 받기 */
  RxString _mannerAge = ''.obs;
  String get mannerAge => _mannerAge.value;

  @override
  void onInit() {
    readPostData();
    super.onInit();
  }

  /* 만든 게시글 데이터 서버로 보내기 */
  Future createPost(PostModel postModel) async {
    //1. post에 보내기
    await _postDB.doc(postModel.postId).set(
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
    //2. 나의 하위컬렉션 post에 게시글 docId 값 보내기
    await _userDB
        .doc(CurrentUser.uid)
        .collection('post')
        .doc(postModel.postId)
        .set(
      {
        'id': postModel.postId,
        'createdAt': postModel.createdAt,
      },
    );
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
  Future updatePost(postid, String title, String maintext, String gamemode,
      String? position, String? tear) async {
    //1. post 정보를 수정
    await _postDB.doc(postid).update(
      {
        'title': title,
        'maintext': maintext,
        'gamemode': gamemode,
        'position': position,
        'tear': tear,
      },
    );
    //2. notification의 postTitle 수정
    await FirebaseFirestore.instance
        .collection('notification')
        .where('postId', isEqualTo: postid)
        .get()
        .then(
      (value) {
        //2-1. ntf id를 담을 빈 리스트
        var _ntfIdList = [];
        //2-2. 쿼리한 postId에 해당 하는 ntf id를 리스트에 넣기
        _ntfIdList.assignAll(
          value.docs.map(
            (e) => e.reference.id,
          ),
        );
        //2-3. 반복문 -> notification의 postTitle 수정
        _ntfIdList.forEach(
          (id) {
            FirebaseFirestore.instance
                .collection('notification')
                .doc(id)
                .update(
              {
                'postTitle': title, //게시글 제목 수정
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
    //1. 특정 게시글의 데이터 Rx<PostModel> _postInfo에 담기
    await _postDB.doc(postId).get().then(
      (e) {
        _postInfo.value = PostModel.fromDocumentSnapshot(e);
        print(_postInfo);
      },
    );
    //2. 1번에서 담은 데이터 중 uid를 넣어 게시자의 매너나이 데이터 받기
    await _userDB.doc(_postInfo.value.uid).get().then(
      (e) {
        var data = e.data()! as Map<String, dynamic>;
        print(data['mannerAge']); //매너나이 프린트
        _mannerAge.value = data['mannerAge'].toString(); //num인 매너나이 String으로
      },
    );
  }
}
