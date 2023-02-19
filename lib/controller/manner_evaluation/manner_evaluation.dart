import 'package:gamego/utilites/index/index.dart';

class EvaluationController extends GetxController {
  final MannerLevelController _level = Get.put(MannerLevelController());
  final CollectionReference _evaluationDB =
      FirebaseFirestore.instance.collection('evaluation');
  final NtfController _ntf = Get.put(NtfController());

  // 매너 평가 항목들을 순서대로 담은 리스트 선언
  RxList kindManner = [].obs;
  RxList goodAppointment = [].obs;
  RxList fastAnswer = [].obs;
  RxList strongMental = [].obs;
  RxList goodGameSkill = [].obs;
  RxList softMannerTalk = [].obs;
  RxList goodCommunication = [].obs;
  RxList comfortable = [].obs;
  RxList hardGame = [].obs;

  // 비매너평가 항목들을 따로 담을 Rx List 선언
  RxList badManner = [].obs;
  RxList badAppointment = [].obs;
  RxList slowAnswer = [].obs;
  RxList weakMental = [].obs;
  RxList badGameSkill = [].obs;
  RxList troll = [].obs;
  RxList abuseWord = [].obs;
  RxList sexualWord = [].obs;
  RxList shortTalk = [].obs;
  RxList noCommunication = [].obs;
  RxList uncomfortable = [].obs;
  RxList privateMeeting = [].obs;

  // 보낸 매너평가가 있는지 여부
  RxBool isExistEvaluation = false.obs;

  // 매너 평가 보내기
  Future addGoodEvaluation(uid, chatRoomId, GoodEvaluationModel goodEvaluation,
      NotificationModel ntfModel) async {
    final WriteBatch _batch = FirebaseFirestore.instance.batch();

    // evaluation / {받는uid} / goodEvaluation / { chatRoomId}에 저장
    _batch.set(
      _evaluationDB.doc(uid).collection('goodEvaluation').doc(chatRoomId),
      {
        'evaluationType': goodEvaluation.evaluationType,
        'idFrom': goodEvaluation.idFrom,
        'idTo': goodEvaluation.idTo,
        'kindManner': goodEvaluation.kindManner,
        'goodAppointment': goodEvaluation.goodAppointment,
        'fastAnswer': goodEvaluation.fastAnswer,
        'strongMental': goodEvaluation.strongMental,
        'goodGameSkill': goodEvaluation.goodGameSkill,
        'comfortable': goodEvaluation.comfortable,
        'softMannerTalk': goodEvaluation.softMannerTalk,
        'goodCommunication': goodEvaluation.goodCommunication,
        'hardGame': goodEvaluation.hardGame,
        'createdAt': goodEvaluation.createdAt,
      },
    );

    // 푸시알림 위해 notifiaciton에 추가
    _ntf.addNotification(ntfModel, _batch);
    // 매너평가 받는 유저의 매너Lv +
    _level.plusMannerLevel(uid, _batch);

    await _batch.commit();
  }

  // 비매너 평가 추가
  // 푸시알림 필요 X이므로 ntf는 추가 X
  Future addBadEvaluation(
      uid, chatRoomId, BadEvaluationModel badEvaluation) async {
    final WriteBatch _batch = FirebaseFirestore.instance.batch();

    // evaluation / {받는uid} / badEvaluation / {chatRoomId}에 저장
    _batch.set(
      _evaluationDB.doc(uid).collection('badEvaluation').doc(chatRoomId),
      {
        'evaluationType': badEvaluation.evaluationType,
        'idFrom': badEvaluation.idFrom,
        'idTo': badEvaluation.idTo,
        'badManner': badEvaluation.badManner,
        'badAppointment': badEvaluation.badAppointment,
        'slowAnswer': badEvaluation.slowAnswer,
        'weakMental': badEvaluation.weakMental,
        'badGameSkill': badEvaluation.badGameSkill,
        'troll': badEvaluation.troll,
        'abuseWord': badEvaluation.abuseWord,
        'sexualWord': badEvaluation.sexualWord,
        'shortTalk': badEvaluation.shortTalk,
        'noCommunication': badEvaluation.noCommunication,
        'uncomfortable': badEvaluation.uncomfortable,
        'privateMeeting': badEvaluation.privateMeeting,
        'createdAt': badEvaluation.createdAt,
      },
    );
    // 비매너 평가 받은 유저의 매너Lv -
    _level.minusMannerLevel(uid, _batch);
    await _batch.commit();
  }

  // 매너 평가 리스트 받기
  Future getGoodEvaluationList(uid) async {
    var _goodEvaluationList = [];
    await _evaluationDB
        .doc(uid)
        .collection('goodEvaluation')
        .orderBy('createdAt', descending: true) //최신일 수록 위로
        .get()
        .then(
          (snapshot) => _goodEvaluationList.assignAll(
            snapshot.docs.map(
              (e) => GoodEvaluationModel.fromDocumentSnapshot(e),
            ),
          ),
        );
    // 매너평가 각 항목의 리스트로 세분화 하여 나누기(true만)
    kindManner.value =
        _goodEvaluationList.where((e) => e.kindManner == true).toList();
    goodAppointment.value =
        _goodEvaluationList.where((e) => e.goodAppointment == true).toList();
    fastAnswer.value =
        _goodEvaluationList.where((e) => e.fastAnswer == true).toList();
    strongMental.value =
        _goodEvaluationList.where((e) => e.strongMental == true).toList();
    goodGameSkill.value =
        _goodEvaluationList.where((e) => e.goodGameSkill == true).toList();
    softMannerTalk.value =
        _goodEvaluationList.where((e) => e.softMannerTalk == true).toList();
    comfortable.value =
        _goodEvaluationList.where((e) => e.comfortable == true).toList();
    goodCommunication.value =
        _goodEvaluationList.where((e) => e.goodCommunication == true).toList();
    hardGame.value =
        _goodEvaluationList.where((e) => e.hardGame == true).toList();
  }

  // 비매너 평가 리스트 받기
  Future getBadEvaluationList(uid) async {
    var badEvaluationList = [];
    await _evaluationDB
        .doc(uid)
        .collection('badEvaluation')
        .orderBy('createdAt', descending: true) //최신일 수록 위로
        .get()
        .then(
          (snapshot) => badEvaluationList.assignAll(
            snapshot.docs.map(
              (e) => BadEvaluationModel.fromDocumentSnapshot(e),
            ),
          ),
        );
    // 비매너 평가 각 항목의 리스트로 세분화 하여 나누기 (true 만)
    badManner.value =
        badEvaluationList.where((e) => e.badManner == true).toList();
    badAppointment.value =
        badEvaluationList.where((e) => e.badAppointment == true).toList();
    slowAnswer.value =
        badEvaluationList.where((e) => e.slowAnswer == true).toList();
    weakMental.value =
        badEvaluationList.where((e) => e.weakMental == true).toList();
    badGameSkill.value =
        badEvaluationList.where((e) => e.badGameSkill == true).toList();
    troll.value = badEvaluationList.where((e) => e.troll == true).toList();
    abuseWord.value =
        badEvaluationList.where((e) => e.abuseWord == true).toList();
    sexualWord.value =
        badEvaluationList.where((e) => e.sexualWord == true).toList();
    shortTalk.value =
        badEvaluationList.where((e) => e.shortTalk == true).toList();
    noCommunication.value =
        badEvaluationList.where((e) => e.noCommunication == true).toList();
    uncomfortable.value =
        badEvaluationList.where((e) => e.uncomfortable == true).toList();
    privateMeeting.value =
        badEvaluationList.where((e) => e.privateMeeting == true).toList();
  }

  // 내가 이미 보낸 매너평가가 있는지 확인
  // 채팅페이지에 들어가면서 선언
  Future checkExistEvaluation(uid, chatRoomId) async {
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

    // 매너평가, 비매너평가 문서 존재여부 확인
    if (goodRef.exists || badRef.exists) {
      // 이미 보낸 평가가 있는 경우
      isExistEvaluation.value = true;
    } else {
      // 이미 보낸 평가가 없는 경우 (good과 bad 둘 다 없는 경우)
      isExistEvaluation.value = false;
    }
  }
}
