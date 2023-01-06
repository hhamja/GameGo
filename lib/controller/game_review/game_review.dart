import 'package:mannergamer/utilites/index/index.dart';

class GameReviewController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');

  /* 채팅방에서 확인하는 내가 작성해서 보낸 매너리뷰 */
  RxString myReviewContent = ''.obs;
  /* 게임후기 리스트 */
  RxList<GameReviewModel> gameReviewList = <GameReviewModel>[].obs;

  /* 선택사항인 게임후기 작성시, 받는 유저 하위 컬렉션 'review'에 추가
  * 게임후기를 채팅의 하위 컬렉션 'reivew'에 보내는 사람 UID로 문서 추가하기 */
  Future addMannerReview(
    uid,
    chatRoomId,
    GameReviewModel GameReviewModel,
  ) async {
    //유저 하위 컬렉션에 리뷰 저장하기
    await _userDB.doc(uid).collection('review').doc(chatRoomId).set(
      {
        'idFrom': GameReviewModel.idFrom,
        'idTo': GameReviewModel.idTo,
        'profileUrl': GameReviewModel.profileUrl,
        'userName': GameReviewModel.userName,
        'content': GameReviewModel.content,
        'createdAt': GameReviewModel.createdAt,
      },
    );
  }

  /* 게임후기 리스트로 받기 */
  Future getGameReview(uid) async {
    final ref = _userDB.doc(uid).collection('review');
    await ref
        .orderBy('createdAt', descending: true) //최신일 수록 위로 오게
        .where('feeling', isEqualTo: 'bad') //비매너후기만
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
    final ref =
        await _userDB.doc(uid).collection('review').doc(chatRoomId).get();

    //후기는 선택사항이라 문서자체가 없어서 null 반환 에러 뜨므로
    //문서가 존재할때만 데이터 받도록 하기
    ref.exists
        ? _userDB.doc(uid).collection('review').doc(chatRoomId).get().then(
            (value) {
              var snapshot = value.data() as Map<String, dynamic>;
              myReviewContent.value = snapshot['content'];
            },
          )
        : null;
  }
}
