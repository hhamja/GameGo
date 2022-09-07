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

  /* 게시물 필터 결과값 담을 resultList 선언 */
  RxList<PostModel> resultList = <PostModel>[].obs;

  /* Lifecycle */
  @override
  void onInit() {
    super.onInit();
    postList.bindStream(readPostData());
    resultList.bindStream(
      streamPostData(
        _.selectedModeValue,
        _.selectedPositionValue,
        _.selectedTearValue,
      ),
    );
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

  /* Stream Read Post */
  Stream<List<PostModel>> gamemodeFilter(
      String gamemode, String? position, String? tear) {
    filter(List gamemode, index) {
      List gamemode = gameModes;
      _post
          .orderBy('createdAt', descending: true)
          .where('gamemode', isEqualTo: gamemode)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((e) {
                return PostModel.fromDocumentSnapshot(e);
              }).toList());
    }

    switch (gamemode) {
      case '솔로랭크':
        resultList.clear();
        _post
            .orderBy('createdAt', descending: true)
            .where('gamemode', isEqualTo: '솔로랭크')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());

        break;
      case '자유랭크':
        resultList.clear();
        _post
            .orderBy('createdAt', descending: true)
            .where('gamemode', isEqualTo: gameModes[0])
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());

        break;
      case '일반게임':
        resultList.clear();
        _post
            .orderBy('createdAt', descending: true)
            .where('gamemode', isEqualTo: '일반게임')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());

        break;
      case '무작위 총력전':
        resultList.clear();
        _post
            .orderBy('createdAt', descending: true)
            .where('gamemode', isEqualTo: '무작위 총력전')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
      case 'AI 대전':
        resultList.clear();
        _post
            .orderBy('createdAt', descending: true)
            .where('gamemode', isEqualTo: 'AI 대전')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
    }
    switch (position) {
      case '탑':
        _post
            .orderBy('createdAt', descending: true)
            .where('position', isEqualTo: 'AI 대전')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
      case '정글':
        _post
            .orderBy('createdAt', descending: true)
            .where('position', isEqualTo: '정글')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
      case '미드':
        _post
            .orderBy('createdAt', descending: true)
            .where('position', isEqualTo: '미드')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
      case '원딜':
        _post
            .orderBy('createdAt', descending: true)
            .where('position', isEqualTo: '원딜')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
      case '서포터':
        _post
            .orderBy('createdAt', descending: true)
            .where('position', isEqualTo: '서포터')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
    }
    switch (tear) {
      case '언랭크':
        _post
            .orderBy('createdAt', descending: true)
            .where('tear', isEqualTo: '언랭크')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
      case '아이언':
        _post
            .orderBy('createdAt', descending: true)
            .where('tear', isEqualTo: '아이언')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
      case '브론즈':
        _post
            .orderBy('createdAt', descending: true)
            .where('tear', isEqualTo: '브론즈')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
      case '실버':
        _post
            .orderBy('createdAt', descending: true)
            .where('tear', isEqualTo: '실버')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
      case '골드':
        _post
            .orderBy('createdAt', descending: true)
            .where('tear', isEqualTo: '골드')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
      case '플래티넘':
        _post
            .orderBy('createdAt', descending: true)
            .where('tear', isEqualTo: '플래티넘')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
      case '다이아몬드':
        _post
            .orderBy('createdAt', descending: true)
            .where('tear', isEqualTo: '다이아몬드')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((e) {
                  return PostModel.fromDocumentSnapshot(e);
                }).toList());
        break;
    }
    throw [];
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
}
