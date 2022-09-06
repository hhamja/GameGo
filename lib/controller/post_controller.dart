import 'package:mannergamer/utilites/index.dart';

class PostController extends GetxController {
  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  /* Initialize Firestore Instance */
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  /* RxList streamPostList [] 선언 */
  RxList<PostModel> postList = <PostModel>[].obs;

  /* Lifecycle */
  @override
  void onInit() {
    super.onInit();
    readPostData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /* Create Post */
  Future createPost(PostModel postModel) async {
    try {
      final res = await firestore.collection('post').add({
        'username': postModel.username,
        'title': postModel.title,
        'maintext': postModel.maintext,
        'gamemode': postModel.gamemode,
        'position': postModel.position,
        'tear': postModel.tear,
        'createdAt': Timestamp.now(),
      });
      print(res);
      return res;
    } catch (e) {
      print('createPost error');
    }
  }

  /* Read Post Data(realtime X) */
  Future readPostData() async {
    try {
      final res = await firestore
          .collection('post')
          .orderBy('createdAt', descending: true)
          .get();
      print(res.docs);
      for (var re in res.docs) {
        final postModel = PostModel.fromDocumentSnapshot(re);
        print(postModel);
        postList.add(postModel);
      }
    } catch (e) {
      print('read error : ${e}');
    }
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
      await firestore.collection('post').doc(postid).update({
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
      final data = await firestore.collection('post').doc(postid).delete();
      return data;
    } catch (e) {
      print('deletePost error : ${e}');
    }
  }
}
