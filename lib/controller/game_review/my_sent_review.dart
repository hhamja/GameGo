import 'package:gamego/utilites/index/index.dart';

class MySentGameReviewController extends GetxController with StateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _evaluationDB =
      FirebaseFirestore.instance.collection('evaluation');
  final CollectionReference _gameReviewDB =
      FirebaseFirestore.instance.collection('gameReview');
  // 내가 보낸 후기가 매너 후기인지? 비매너 후기 인지? 판단하게 해줄 bool
  RxBool isGood = false.obs;
  var goodCheckList = [].obs;
  var badCheckList = [].obs;
  // 채팅방에서 확인하는 내가 작성해서 보낸 매너리뷰
  RxString myReviewContent = ''.obs;

  // 내가 보낸 매너평가 받기
  Future getMySentEvaluation(uid, chatRoomId) async {
    change(null, status: RxStatus.loading());
    GoodEvaluationModel? goodEvaluation;
    BadEvaluationModel? badEvaluation;
    final goodRef = await _evaluationDB
        .doc(uid)
        .collection('goodEvaluation')
        .doc(chatRoomId)
        .get();
    final badRef = await _evaluationDB
        .doc(uid)
        .collection('badEvaluation')
        .doc(chatRoomId)
        .get();
    // 매너, 비매너평가 구분
    if (goodRef.exists) {
      // 매너 평가인 경우
      isGood.value = true;
      // 서버에서 매너평가에 대한 데이터 받기
      await _evaluationDB
          .doc(uid)
          .collection('goodEvaluation')
          .doc(chatRoomId)
          .get()
          .then(
        (value) {
          goodEvaluation = GoodEvaluationModel.fromDocumentSnapshot(value);
        },
      );
      change(null, status: RxStatus.success());
      // 받은 데이터를 세분화된 9개의 항목으로 분류
      goodCheckList.add(goodEvaluation!.kindManner);
      goodCheckList.add(goodEvaluation!.goodAppointment);
      goodCheckList.add(goodEvaluation!.fastAnswer);
      goodCheckList.add(goodEvaluation!.strongMental);
      goodCheckList.add(goodEvaluation!.goodGameSkill);
      goodCheckList.add(goodEvaluation!.softMannerTalk);
      goodCheckList.add(goodEvaluation!.comfortable);
      goodCheckList.add(goodEvaluation!.goodCommunication);
      goodCheckList.add(goodEvaluation!.hardGame);
      print(goodCheckList);
    } else if (badRef.exists) {
      // 비매너 평가인 경우
      isGood.value = false;
      // 서버에서 비매너평가 데이터 받기
      await _evaluationDB
          .doc(uid)
          .collection('badEvaluation')
          .doc(chatRoomId)
          .get()
          .then(
        (value) {
          badEvaluation = BadEvaluationModel.fromDocumentSnapshot(value);
        },
      );
      change(null, status: RxStatus.success());
      // 받은 데이터를 세분화된 12개의 항목으로 분류
      badCheckList.add(badEvaluation!.badManner);
      badCheckList.add(badEvaluation!.badAppointment);
      badCheckList.add(badEvaluation!.slowAnswer);
      badCheckList.add(badEvaluation!.weakMental);
      badCheckList.add(badEvaluation!.badGameSkill);
      badCheckList.add(badEvaluation!.troll);
      badCheckList.add(badEvaluation!.abuseWord);
      badCheckList.add(badEvaluation!.sexualWord);
      badCheckList.add(badEvaluation!.shortTalk);
      badCheckList.add(badEvaluation!.noCommunication);
      badCheckList.add(badEvaluation!.uncomfortable);
      badCheckList.add(badEvaluation!.privateMeeting);
      print(badCheckList);
    } else {
      // 둘다 존재하지 않는 경우
      change(null, status: RxStatus.empty());
      null;
    }
    // 이미 채팅방에 들어올 때, 보낸 게임 후기가 있는지 확인을 하므로
    // 데이터 상태에 따라 조건식을 넣지 않음.
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
          myReviewContent.value = '';
          print('내가 보낸 게임후기 null');
        }
      },
    );
  }
}
