import 'package:mannergamer/utilites/index.dart';

class PostController extends GetxController {
  /* Initialize Firestore Instance */
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  /* RxList postList [] 선언 */
  RxList<PostModel> postList = <PostModel>[].obs;

  /* Lifecycle */
  @override
  void onInit() {
    super.onInit();
    postList.bindStream(readPostData);
    print(postList);
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
        'createdAt': postModel.createdAt,
      });
      print(res);
      return res;
    } catch (e) {
      print('createPost error');
    }
  }

  /* Read Post Data(realtime X) */
  Stream readPostData() async* {
    try {
      yield* firestore
          .collection('post')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((element) =>
              element.docs.map((e) => PostModel.fromDocumentSnapshot(e)));

      // for (var re in res.docs) {
      //   final postModel = PostModel.fromDocumentSnapshot(re);
      //   print(postModel);
      //   postList.add(postModel);
      // }
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
