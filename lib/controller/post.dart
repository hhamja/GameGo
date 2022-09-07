import 'package:mannergamer/utilites/index.dart';

class PostController extends GetxController {
  // /* Initialize Firestore Instance */
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  /* 파이어스토어 Post 컬렉션 참조 instance */
  final CollectionReference _post =
      FirebaseFirestore.instance.collection('posts');

  /* Put -> 홈페이지 드랍다운버튼 컨트롤러 */
  HomePageDropDownBTController _ = Get.find<HomePageDropDownBTController>();

  /* RxList postList [] 선언 */
  RxList<PostModel> postList = <PostModel>[].obs;

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
        .map((QuerySnapshot query) {
      List<PostModel> posts = [];
      for (var post in query.docs) {
        final todoModel = PostModel.fromDocumentSnapshot(post);
        posts.add(todoModel);
      }
      return posts;
    });
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
  Stream<List<PostModel>> gamemodeFilter(gamemode) {
    /* 각 게임모드 case의 중복코드 단일화 */
    filter(gamemode) {
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
      case '솔로랭크':
        filter(gameModes[0]);
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
    throw ['게임모드 필터 오류'];
  }

  /* PostList -> Position Filtering */
  Stream<List<PostModel>> positionFilter(position) {
    /* 각 포지션 case의 중복코드 단일화 */
    filter(position) {
      _post
          .orderBy('createdAt', descending: true)
          .where('gamemode', isEqualTo: position)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((e) {
                return PostModel.fromDocumentSnapshot(e);
              }).toList());
    }

    /* switch - case */
    switch (position) {
      case '탑':
        filter(postions[0]);
        break;
      case '정글':
        filter(postions[1]);
        break;
      case '미드':
        filter(postions[2]);
        break;
      case '원딜':
        filter(postions[3]);
        break;
      case '서포터':
        filter(postions[4]);
        break;
    }
    throw [];
  }

  /* Tear -> Position Filtering */
  Stream<List<PostModel>> tearFilter(tear) {
    /* 각 티어 case의 중복코드 단일화 */
    filter(tear) {
      _post
          .orderBy('createdAt', descending: true)
          .where('gamemode', isEqualTo: tear)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((e) {
                return PostModel.fromDocumentSnapshot(e);
              }).toList());
    }

    /* switch - case */
    switch (tear) {
      case '언랭크':
        filter(tears[0]);
        break;
      case '아이언':
        filter(tears[1]);
        break;
      case '브론즈':
        filter(tears[2]);
        break;
      case '실버':
        filter(tears[3]);
        break;
      case '골드':
        filter(tears[4]);
        break;
      case '플래티넘':
        filter(tears[5]);
        break;
      case '다이아몬드':
        filter(tears[6]);
        break;
    }
    throw [];
  }
}
