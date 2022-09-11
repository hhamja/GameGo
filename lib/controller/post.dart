import 'package:mannergamer/utilites/index.dart';

class PostController extends GetxController {
  // /* Initialize Firestore Instance */
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  /* 파이어스토어 Post 컬렉션 참조 instance */
  final CollectionReference _post =
      FirebaseFirestore.instance.collection('post');

  /* Home DropDwonButton Controller 불러오기 */
  HomePageDropDownBTController _buttonController =
      Get.put(HomePageDropDownBTController());
  /* RxList postList [] 선언 */
  RxList<PostModel> postList = <PostModel>[].obs;
  /* 버튼컨트롤러의 selectedValue 담은 변수 */
  var selectedMode, selectedPosition, selectedTear;

  /* Lifecycle */
  @override
  void onInit() {
    super.onInit();
    selectedMode = _buttonController.selectedModeValue;
    selectedPosition = _buttonController.selectedPositionValue;
    selectedTear = _buttonController.selectedTearValue;
    print(selectedMode);
    print(selectedPosition);
    print(selectedTear);
    postList
        .bindStream(postFilter(selectedMode, selectedPosition, selectedTear));
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

  /* PostList를 게임모드, 포지션, 티어 Filtering 함수 */
  Stream<List<PostModel>> postFilter(gamemode, position, tear) {
    /* 각 게임모드 case의 중복코드 단일화 */
    void filter(g, p, t) {
      _post
          .orderBy('createdAt', descending: true)
          .where('gamemode', isEqualTo: g)
          .where('position', isEqualTo: p)
          .where('tear', isEqualTo: t)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((e) {
                return PostModel.fromDocumentSnapshot(e);
              }).toList());
    }

    /* 게임모드 switch - case */
    switch (gamemode) {
      case null:
        filter;
        break;

      case '솔로랭크':
        filter('솔로랭크', null, null);
        break;
      case '자유랭크':
        filter('자유랭크', null, null);
        break;
      case '일반게임':
        filter('일반게임', null, null);
        break;
      case '무작위 총력전':
        filter('무작위 총력전', null, null);
        break;
      case 'AI 대전':
        filter('AI 대전', null, null);
        break;
    }

    /* 포지션 switch - case */
    switch (position) {
      case null:
        filter(gamemode, null, null);
        break;
      case '포지션 전체':
        filter;
        break;
      case '탑':
        filter(gamemode, '탑', null);
        break;
      case '정글':
        filter(gamemode, '정글', null);
        break;
      case '미드':
        filter(gamemode, '미드', null);
        break;
      case '원딜':
        filter(gamemode, '원딜', null);
        break;
      case '서포터':
        filter(gamemode, '서포터', null);
        break;
    }

    /* 티어 switch - case */
    switch (tear) {
      case null:
        filter(gamemode, position, null);
        break;
      case '언랭크':
        filter(gamemode, position, '언랭크');
        break;
      case '아이언':
        filter(gamemode, position, '아이언');
        break;
      case '브론즈':
        filter(gamemode, position, '브론즈');
        break;
      case '실버':
        filter(gamemode, position, '실버');
        break;
      case '골드':
        filter(gamemode, position, '골드');
        break;
      case '플래티넘':
        filter(gamemode, position, '플래티넘');
        break;
      case '다이아몬드':
        filter(gamemode, position, '다이아몬드');
        break;
    }
    throw '필터 실패';
  }

/* ------------------------------------------------------------------------ */
  /* PostList -> Position Filtering */
  Stream<List<PostModel>> positionFilter(POSITION position) {
    /* 각 포지션 case의 중복코드 단일화 */
    filter(position) {
      _post
          .orderBy('createdAt', descending: true)
          .where('position', isEqualTo: position)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((e) {
                return PostModel.fromDocumentSnapshot(e);
              }).toList());
    }

    /* switch - case */
    switch (position) {
      case POSITION.ALL:
        filter;
        break;
      case POSITION.Top:
        filter(postions[0]);
        break;
      case POSITION.Jungle:
        filter(postions[1]);
        break;
      case POSITION.Mid:
        filter(postions[2]);
        break;
      case POSITION.AD:
        filter(postions[3]);
        break;
      case POSITION.Supporter:
        filter(postions[4]);
        break;
    }

    throw '포지션 필터 오류';
  }

  /* Tear -> Position Filtering */
  Stream<List<PostModel>> tearFilter(gamemode, position, tear) {
    /* 각 티어 case의 중복코드 단일화 */
    filter(tear) {
      _post
          .orderBy('createdAt', descending: true)
          .where('gamemode', isEqualTo: gamemode)
          .where('position', isEqualTo: position)
          .where('tear', isEqualTo: tear)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((e) {
                return PostModel.fromDocumentSnapshot(e);
              }).toList());
    }

    /* switch - case */
    switch (tear) {
      case TEAR.ALL:
        filter(tears[0]);
        break;
      case TEAR.Unrank:
        filter(tears[0]);
        break;
      case TEAR.Iron:
        filter(tears[1]);
        break;
      case TEAR.Bronze:
        filter(tears[2]);
        break;
      case TEAR.Silver:
        filter(tears[3]);
        break;
      case TEAR.Gold:
        filter(tears[4]);
        break;
      case TEAR.Platinum:
        filter(tears[5]);
        break;
      case TEAR.Diamond:
        filter(tears[6]);
        break;
    }
    throw '티어 필터 오류';
  }
}
