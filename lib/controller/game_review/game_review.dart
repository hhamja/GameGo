import 'package:mannergamer/utilites/index/index.dart';

class GameReviewController extends GetxController {
  final MannerAgeController _age = Get.put(MannerAgeController());
  final CollectionReference _reportDB =
      FirebaseFirestore.instance.collection('report');
  final CollectionReference _gameReviewDB =
      FirebaseFirestore.instance.collection('gameReview');

  /* 채팅방에서 확인하는 내가 작성해서 보낸 매너리뷰 */
  RxString myReviewContent = ''.obs;
  /* 게임후기 리스트 */
  RxList<GameReviewModel> gameReviewList = <GameReviewModel>[].obs;

  /* 선택사항인 게임후기 작성시, gameReview에 보내기
  * 게임후기를 채팅의 하위 컬렉션 'reivew'에 보내는 사람 UID로 문서 추가하기
  * 매너후기를 보낸 경우에만 보내기
  * 비매너 후기를 보낸 경우에는 신고로 매너게이머 팀에 보내지도록 하기 */
  Future addMannerReview(
    uid,
    chatRoomId,
    GameReviewModel GameReviewModel,
  ) async {
    //1. gameReview/gameReview/{uid}/{chatRoomId}에 보내기
    await _gameReviewDB.doc('gameReview').collection(uid).doc(chatRoomId).set(
      {
        'idFrom': GameReviewModel.idFrom,
        'idTo': GameReviewModel.idTo,
        'profileUrl': GameReviewModel.profileUrl,
        'userName': GameReviewModel.userName,
        'content': GameReviewModel.content,
        'createdAt': GameReviewModel.createdAt,
      },
    );
    //2. 매너 게임 후기 받는 유저의 매너나이 (+ 0.1)
    await _age.plusMannerAge(uid);
  }

  /* 비매너 게임 후기를 작성한 경우 
  * 상대방에게 전달하지 않고 신고하기로 처리하여 운영자가 관리하도록 하기 */
  Future addUnMannerReview(ReportModel model) async {
    //1. 서버의 'report'에 저장하기
    await _reportDB.add(
      {
        'idFrom': model.idFrom,
        'idTo': model.idTo,
        'postId': model.postId,
        'chatRoomId': model.chatRoomId,
        'reportContent': model.reportContent,
        'createdAt': model.createdAt,
      },
    );
    //2. 비매너 게임 후기 받는 유저의 매너나이 (- 0.1)
    await _age.minusMannerAge(model.idTo);
  }

  /* 게임후기 리스트로 받기 */
  Future getGameReviewList(uid) async {
    return _gameReviewDB
        .doc('gameReview')
        .collection(uid)
        .orderBy('createdAt', descending: true) //최신일 수록 위로 오게
        .get()
        .then(
          (snapshot) => gameReviewList.assignAll(
            snapshot.docs.map(
              (e) => GameReviewModel.fromDocumentSnapshot(e),
            ),
          ),
        );
  }

  /* 내가 보낸 게임후기 받기 
  * 채팅페이지에서 버튼 클릭 시 보여지는 페이지 */
  Future getMySentReviewContent(uid, chatRoomId) async {
    final ref = await _gameReviewDB
        .doc('gameReview')
        .collection(uid)
        .doc(chatRoomId)
        .get();
    //후기는 선택사항이라 문서자체가 없어서 null 반환 에러 뜨므로
    //문서가 존재할때만 데이터 받도록 하기
    ref.exists
        ? _gameReviewDB
            .doc('gameReview')
            .collection(uid)
            .doc(chatRoomId)
            .get()
            .then(
            (value) {
              var snapshot = value.data() as Map<String, dynamic>;
              myReviewContent.value = snapshot['content'];
            },
          )
        : null;
  }
}
