import 'package:mannergamer/utilites/index/index.dart';

class DetailPostController extends GetxController
    with StateMixin<Rx<PostModel>> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  final MannerLevelController _levelController =
      Get.put(MannerLevelController());
  final CollectionReference _favoriteDB =
      FirebaseFirestore.instance.collection('favorite');
  final NtfController _ntf = Get.put(NtfController());

  // 게시글정보
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
    isHidden: false,
    isDeleted: false,
    updatedAt: Timestamp.now(),
  ).obs;
  PostModel get postInfo => _postInfo.value;
  // 매너레벨 컨트롤러에서 매너Lv. 값 getter
  String get level => _levelController.level;

  // PostList Page 와 Favorite 에서 PostId값 전달 받음
  final String postId = Get.arguments['postId'];
  // 게시물 관심 버튼 클릭하면 on/off 되는 bool 값
  RxBool isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    getPostInfoByid(postId);
    isFavoritePost(postId);
  }

  // postId을 통해서 특정 게시글의 데이터 받기
  Future getPostInfoByid(postId) async {
    change(_postInfo, status: RxStatus.loading());
    await _postDB.doc(postId).get().then(
          (e) => _postInfo.value = PostModel.fromDocumentSnapshot(e),
          onError: (err) =>
              change(null, status: RxStatus.error(err.toString())),
        );
    if (_postInfo.value.postId == '') {
      // 값을 받지 못한 경우
      return change(_postInfo, status: RxStatus.empty());
    } else {
      // 해당 유저의 매너 레벨 데이터 받기
      await _levelController.getUserMannerLevel(_postInfo.value.uid);
      // 값을 성공적으로 받은 경우
      return change(_postInfo, status: RxStatus.success());
    }
  }

  // 관심게시글로 지정했는지 확인
  isFavoritePost(postId) async {
    // 나의 관심게시글 경로 참조
    final ref = await _favoriteDB
        .doc('favorite')
        .collection(_auth.currentUser!.uid)
        .doc(postId)
        .get();
    // 해당 게시글이 나의 관심게시글인지 확인
    if (ref.exists) {
      // 나의 관심게시글인 경우
      isFavorite.value = true;
    } else {
      // 나의 관심게시글이 아닌 경우
      isFavorite.value = false;
    }
  }

  // 관심 버튼 클릭 시 추가 및 제거
  Future clickfavoriteButton(
      FavoriteModel favoriteModel, NotificationModel ntfModel) async {
    if (isFavorite.value) {
      // 관심게시글인 경우
      print('이 게시글은 나의 관심게시글임');
      // 나의 관심목록에서 제거
      _favoriteDB
          .doc('favorite')
          .collection(_auth.currentUser!.uid)
          .doc(favoriteModel.postId)
          .delete();
      // 해당 게시물 like값 -1
      _postDB.doc(favoriteModel.postId).update({
        'like': FieldValue.increment(-1),
      });
    } else {
      // 관심게시글 아닌 경우
      print('이 게시글은 나의 관심게시글이 아님');
      // 관심게시글로 추가
      _favoriteDB
          .doc('favorite')
          .collection(_auth.currentUser!.uid)
          .doc(favoriteModel.postId)
          .set(
        {
          'postId': favoriteModel.postId,
          'idFrom': favoriteModel.idFrom,
          'idTo': favoriteModel.idTo,
          'createdAt': favoriteModel.createdAt,
        },
      );
      // 관심게시글 추가에 대해 알림 추가
      _ntf.addNotification(ntfModel);
      // 해당 게시물의 like값 +1
      _postDB.doc(favoriteModel.postId).update(
        {
          'like': FieldValue.increment(1),
        },
      );
    }
    // 관심버튼 상태를 나타내는 bool변수 토글화
    isFavorite.value = !isFavorite.value;
  }

  // 매너Lv 받기
  Future getUserMannerLevel(uid) async {
    await _levelController.getUserMannerLevel(uid);
  }
}
