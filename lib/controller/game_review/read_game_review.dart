import 'package:gamegoapp/utilites/index/index.dart';

class ReadGameReviewController extends GetxController
    with StateMixin<RxList<GameReviewModel>> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _gameReviewDB =
      FirebaseFirestore.instance.collection('gameReview');

  // 게임후기 리스트
  RxList<GameReviewModel> gameReviewList = <GameReviewModel>[].obs;

  // 내가 받은 게임후기 리스트로 받기
  Future getGameReviewList(uid) async {
    change(gameReviewList, status: RxStatus.loading());
    await _gameReviewDB
        .where('idTo', isEqualTo: _auth.currentUser!.uid)
        .orderBy('createdAt', descending: true)
        .get()
        .then(
          (snapshot) => gameReviewList.assignAll(
            snapshot.docs.map(
              (e) => GameReviewModel.fromDocumentSnapshot(e),
            ),
          ),
        );
    // 데이터 상태
    if (gameReviewList.isNotEmpty || gameReviewList.length > 0) {
      // 받은 게임 리뷰 있음
      return change(gameReviewList, status: RxStatus.success());
    } else {
      // 받은 게임 리뷰 없음
      return change(gameReviewList, status: RxStatus.empty());
    }
  }
}
