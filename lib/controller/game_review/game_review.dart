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
    //1. 'gameReview'에 보내기
    await _gameReviewDB.add(
      {
        'idFrom': GameReviewModel.idFrom,
        'idTo': GameReviewModel.idTo,
        'profileUrl': GameReviewModel.profileUrl,
        'userName': GameReviewModel.userName,
        'content': GameReviewModel.content,
        'gameType': GameReviewModel.gameType,
        'createdAt': GameReviewModel.createdAt,
      },
    ).then(
      //2. 보낸 사람 하위컬렉션에 문서 id에 대한 정보 저장
      (docRef) => FirebaseFirestore.instance
          .collection('user')
          .doc(CurrentUser.uid)
          .collection('sentGameReview') //'sentGameReview'
          .doc(docRef.id)
          .set(
        {
          'id': docRef.id, //게임후기 문서 id
          'chatRoomId': chatRoomId, //해당이 되는 채팅방 id
          'createdAt': GameReviewModel.createdAt, //게임 후기 보낸 시간
        },
      ),
    );
    //3. 매너 게임 후기 받는 유저의 매너나이 (+ 0.1)
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

  /* 내가 받은 게임후기 리스트로 받기 */
  Future getGameReviewList(uid) async {
    return _gameReviewDB
        .where('idTo', isEqualTo: CurrentUser.uid)
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
    //후기는 선택사항이라 문서자체가 없어서 null 반환 에러 뜨므로
    //문서가 존재할때만 데이터 받도록 하기
    FirebaseFirestore.instance
        .collection('user')
        .doc(CurrentUser.uid)
        .collection('sentGameReview')
        .where('chatRoomId', isEqualTo: chatRoomId)
        .get()
        .then(
      (docRef) {
        //내가 보낸 게임후기 존재하는 경우에만 게임후기 데이터 받기
        if (docRef.docs.isNotEmpty) {
          //review Id 데이터 받기
          String docId = '';
          docRef.docs.forEach((e) {
            docId = e.reference.id;
          });
          //받은 문서 id값을 'gameReview'에서 데이터 받기
          _gameReviewDB.doc(docId).get().then(
            (value) {
              var snapshot = value.data() as Map<String, dynamic>;
              myReviewContent.value = snapshot['content'];
            },
          );
        } else
          null;
      },
    );
  }
}
