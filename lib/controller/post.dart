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

  /* Lifecycle */
  @override
  void onInit() {
    super.onInit();
    var selectedMode = _buttonController.selectedModeValue;
    var selectedPosition = _buttonController.selectedPositionValue;
    var selectedTear = _buttonController.selectedTearValue;
    postList.bindStream(
        gamemodeFilter(selectedMode, selectedPosition, selectedTear));
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

  /* PostList -> Gamemode Filtering */
  Stream<List<PostModel>> gamemodeFilter(gamemode, position, tear) {
    /* 각 게임모드 case의 중복코드 단일화 */
    void filter(gamemode) {
      postList.clear();
      _post
          .orderBy('createdAt', descending: true)
          .where('gamemode', isEqualTo: gamemode)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((e) {
                return PostModel.fromDocumentSnapshot(e);
              }).toList());
    }

    /* switch - case */
    switch (gamemode) {
      case '게임모드':
        filter;
        break;
      case '솔로랭크':
        filter(gameModes[0]);
        switch(position){
          case}
        
        
        break;
      case '자유랭크':
        filter(gameModes[1]);
        break;
      case '일반게임':
        filter(gameModes[2]);
        break;
      case '무작위 총력전':
        filter(gameModes[3]);
        break;
      case 'AI 대전':
        filter(gameModes[4]);
        break;
    }
    throw '게임모드 필터 오류';
  }

  /* PostList -> Position Filtering */
  Stream<List<PostModel>> positionFilter(POSITION position) {
    /* 각 포지션 case의 중복코드 단일화 */
    filter(position) {
      _post
          .orderBy('createdAt', descending: true)
          .where('gamemode', isEqualTo: gamemode)
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
  Stream<List<PostModel>> tearFilter(gamemode, position, TEAR tear) {
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
