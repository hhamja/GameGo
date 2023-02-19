import 'package:gamego/utilites/index/index.dart';

class SendGameReviewController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final MannerLevelController _level = Get.put(MannerLevelController());
  final CollectionReference _reportDB =
      FirebaseFirestore.instance.collection('report');
  final CollectionReference _gameReviewDB =
      FirebaseFirestore.instance.collection('gameReview');

  // 채팅방에서 확인하는 내가 작성해서 보낸 매너리뷰
  RxString myReviewContent = ''.obs;

  // 선택사항인 게임후기 작성시, gameReview에 보내기
  // 게임후기를 채팅의 하위 컬렉션 'reivew'에 보내는 사람 UID로 문서 추가하기
  // 매너후기를 보낸 경우에만 보내기
  // 비매너 후기를 보낸 경우에는 신고로 겜고 팀에 보내지도록 하기
  Future addMannerReview(uid, GameReviewModel GameReviewModel) async {
    final WriteBatch _batch = FirebaseFirestore.instance.batch();

    // 루트 컬렉션 'gameReview'에 저장
    _batch.set(
      _gameReviewDB.doc(),
      {
        'idFrom': GameReviewModel.idFrom,
        'idTo': GameReviewModel.idTo,
        'chatRoomId': GameReviewModel.chatRoomId,
        'profileUrl': GameReviewModel.profileUrl,
        'userName': GameReviewModel.userName,
        'content': GameReviewModel.content,
        'gameType': GameReviewModel.gameType,
        'createdAt': GameReviewModel.createdAt,
      },
    );
    // 매너 게임 후기 받는 유저의 매너Lv +
    _level.plusMannerLevel(uid, _batch);
    await _batch.commit();
  }

  // 비매너 게임 후기를 작성한 경우
  // 상대방에게 전달하지 않고 신고하기로 처리하여 운영자가 관리하도록 하기
  Future addUnMannerReview(ReportModel model) async {
    final WriteBatch _batch = FirebaseFirestore.instance.batch();

    // 루트 컬렉션 'report'에 저장
    _batch.set(
      _reportDB.doc(),
      {
        'idFrom': model.idFrom,
        'idTo': model.idTo,
        'postId': model.postId,
        'chatRoomId': model.chatRoomId,
        'reportContent': model.reportContent,
        'createdAt': model.createdAt,
      },
    );
    // 비매너 게임 후기 받는 유저의 매너Lv -
    _level.minusMannerLevel(model.idTo, _batch);
    await _batch.commit();
  }

  // 내가 보낸 게임후기 받기
  Future getMySentReviewContent(uid, chatRoomId) async {
    // 후기는 선택사항이라 문서자체가 없어서 null 반환 에러 뜨므로
    // 문서가 존재할때만 데이터 받도록 하기
    await _gameReviewDB
        .where('chatRoomId', isEqualTo: chatRoomId)
        .where('idFrom', isEqualTo: _auth.currentUser!.uid)
        // 가장 최근의 값을 반환
        .orderBy('createdAt', descending: true)
        // 혹시나 여러개 있을 수 있으므로 에러방지를 위해 한개만 밪기
        .limit(1)
        .get()
        .then(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          snapshot.docs.forEach(
            (e) {
              // 데이터 화
              var docData = e.data() as Map<String, dynamic>;
              // 게임후기의 내용 담기
              myReviewContent.value = docData['content'];
            },
          );
        } else {
          print('내가 보낸 게임후기 null');
        }
      },
    );
  }
}
