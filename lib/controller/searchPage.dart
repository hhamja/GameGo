import 'package:mannergamer/utilites/index.dart';

class SearchPageController extends GetxController {
  /* 파이어스토어 Post 컬렉션 참조 instance */
  final CollectionReference _post =
      FirebaseFirestore.instance.collection('post');

  Stream<List<PostModel>> getSearch(text) {
    return _post
        .orderBy('createdAt', descending: true)
        .where('title', isEqualTo: text)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) {
              return PostModel.fromDocumentSnapshot(e);
            }).toList());
  }
}
