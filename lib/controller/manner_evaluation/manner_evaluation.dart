import 'package:mannergamer/utilites/index/index.dart';

class EvaluationController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference _ntfDB =
      FirebaseFirestore.instance.collection('notification');

  /* 매너 평가 항목들을 순서대로 담은 리스트 선언 */
  RxList kindManner = [].obs;
  RxList goodAppointment = [].obs;
  RxList fastAnswer = [].obs;
  RxList strongMental = [].obs;
  RxList goodGameSkill = [].obs;
  RxList softMannerTalk = [].obs;
  RxList goodCommunication = [].obs;
  RxList comfortable = [].obs;
  RxList hardGame = [].obs;

  /* 비매너평가 항목들을 따로 담을 Rx List 선언 */
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

  /* 매너 평가 담는 GoodEvaluationModel */
  Rx<GoodEvaluationModel> goodEvaluation = GoodEvaluationModel(
    evaluationType: '',
    idFrom: '',
    idTo: '',
    kindManner: false,
    strongMental: false,
    goodAppointment: false,
    fastAnswer: false,
    goodGameSkill: false,
    goodCommunication: false,
    comfortable: false,
    hardGame: false,
    softMannerTalk: false,
    createdAt: Timestamp.now(),
  ).obs;
  /* 비매너 평가 담는 BadEvaluationModel */
  Rx<BadEvaluationModel> badEvaluation = BadEvaluationModel(
    evaluationType: '',
    idFrom: '',
    idTo: '',
    badManner: false,
    badAppointment: false,
    slowAnswer: false,
    weakMental: false,
    badGameSkill: false,
    troll: false,
    abuseWord: false,
    sexualWord: false,
    shortTalk: false,
    noCommunication: false,
    uncomfortable: false,
    privateMeeting: false,
    createdAt: Timestamp.now(),
  ).obs;
  /* 내가 받은 매너 평가 리스트 */
  RxList<int> goodEvaluationList = <int>[].obs;
  /* 내가 받은 비매너 평가 리스트 */
  RxList<int> badEvaluationList = <int>[].obs;
  /* 보낸 매너평가가 있는지 여부 */
  RxBool isExistEvaluation = false.obs;

  /***************************************************************************/

  /* 매너 평가 추가 
  * 유저의 하위 컬렉션 'evaluation'에 추가하기
  * 푸시알림 위해 notifiaciton에도 추가 */
  Future addGoodEvaluation(uid, chatRoomId, GoodEvaluationModel goodEvaluation,
      NotificationModel ntfModel) async {
    //1. 유저의 하위 컬렉션에 추가
    await _userDB.doc(uid).collection('goodEvaluation').doc(chatRoomId).set(
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
    //2. notification에 추가
    await _ntfDB.add(
      {
        'idFrom': ntfModel.idFrom,
        'idTo': ntfModel.idTo,
        'postId': ntfModel.postId,
        'userName': ntfModel.userName,
        'postTitle': ntfModel.postTitle,
        'content': ntfModel.content,
        'type': ntfModel.type,
        'createdAt': ntfModel.createdAt,
      },
    );
  }

  /* 비매너 평가 추가 
  * 유저의 하위 컬렉션 'evaluation'에 추가하기
  * 푸시알림 필요 X이므로 ntf는 추가 X */
  Future addBadEvaluation(
    uid,
    chatRoomId,
    BadEvaluationModel badEvaluation,
  ) async {
    //유저의 하위 컬렉션에 추가
    await _userDB.doc(uid).collection('badEvaluation').doc(chatRoomId).set(
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
  }

  /* 매너 평가 리스트 받기 */
  Future getGoodEvaluationList(uid) async {
    var _goodEvaluationList = [];
    final ref = _userDB.doc(uid).collection('goodEvaluation');
    await ref
        .orderBy('createdAt', descending: true) //최신일 수록 위로 오게
        .where('evaluationType', isEqualTo: 'good') //매너 평가만
        .get()
        .then(
          (snapshot) => _goodEvaluationList.assignAll(
            snapshot.docs.map(
              (e) => GoodEvaluationModel.fromDocumentSnapshot(e),
            ),
          ),
        );
    // 매너평가 각 항목의 리스트로 세분화 하여 나누기(true인 값만)
    kindManner.value = _goodEvaluationList
        .where((element) => element.kindManner == true)
        .toList();
    goodAppointment.value = _goodEvaluationList
        .where((element) => element.goodAppointment == true)
        .toList();
    fastAnswer.value = _goodEvaluationList
        .where((element) => element.fastAnswer == true)
        .toList();
    strongMental.value = _goodEvaluationList
        .where((element) => element.strongMental == true)
        .toList();
    goodGameSkill.value = _goodEvaluationList
        .where((element) => element.goodGameSkill == true)
        .toList();
    softMannerTalk.value = _goodEvaluationList
        .where((element) => element.softMannerTalk == true)
        .toList();
    comfortable.value = _goodEvaluationList
        .where((element) => element.comfortable == true)
        .toList();
    goodCommunication.value = _goodEvaluationList
        .where((element) => element.goodCommunication == true)
        .toList();
    hardGame.value = _goodEvaluationList
        .where((element) => element.hardGame == true)
        .toList();
  }

  /* 비매너 평가 리스트 받기 */
  Future getBadEvaluationList(uid) async {
    var badEvaluationList = [];
    final ref = _userDB.doc(uid).collection('badEvaluation');
    await ref
        .orderBy('createdAt', descending: true) //최신일 수록 위로 오게
        // .where('evaluationType', isEqualTo:'bad') //비매너 평가만
        .get()
        .then(
          (snapshot) => badEvaluationList.assignAll(
            snapshot.docs.map(
              (e) => BadEvaluationModel.fromDocumentSnapshot(e),
            ),
          ),
        );
    // 비매너 평가 각 항목의 리스트로 세분화 하여 나누기
    //(true인 값만)
    badManner.value = badEvaluationList
        .where((element) => element.badManner == true)
        .toList();
    badAppointment.value = badEvaluationList
        .where((element) => element.badAppointment == true)
        .toList();
    slowAnswer.value = badEvaluationList
        .where((element) => element.slowAnswer == true)
        .toList();
    weakMental.value = badEvaluationList
        .where((element) => element.weakMental == true)
        .toList();
    badGameSkill.value = badEvaluationList
        .where((element) => element.badGameSkill == true)
        .toList();
    troll.value =
        badEvaluationList.where((element) => element.troll == true).toList();
    abuseWord.value = badEvaluationList
        .where((element) => element.abuseWord == true)
        .toList();
    sexualWord.value = badEvaluationList
        .where((element) => element.sexualWord == true)
        .toList();
    shortTalk.value = badEvaluationList
        .where((element) => element.shortTalk == true)
        .toList();
    noCommunication.value = badEvaluationList
        .where((element) => element.noCommunication == true)
        .toList();
    uncomfortable.value = badEvaluationList
        .where((element) => element.uncomfortable == true)
        .toList();
    privateMeeting.value = badEvaluationList
        .where((element) => element.privateMeeting == true)
        .toList();
  }

  /* 내가 보낸 매너평가 받기 
  * 채팅페이지에서 버튼 클릭 시 보여지는 페이지 
  * evaluationType == good ? goodEvaluation에 담기
  * evaluationType == bad ? badEvaluation에 담기 */
  Future getMySentReview(uid, chatRoomId) async {
    _userDB.doc(uid).collection('evaluation').doc(chatRoomId).get().then(
      (value) {
        var snapshot = value.data() as Map<String, dynamic>;
        //1. 매너평가인 경우
        if (snapshot['evaluationType'] == 'good') {
          goodEvaluation.value =
              GoodEvaluationModel.fromDocumentSnapshot(value);
        } //2. 비매너평가인 경우
        else if (snapshot['evaluationType'] == 'bad') {
          badEvaluation.value = BadEvaluationModel.fromDocumentSnapshot(value);
        }
        null;
      },
    );
  }

  /* 내가 이미 보낸 매너평가가 있는지 확인하기
  * 채팅페이지에 들어가면서 함수 실행 */
  checkExistReview(uid, chatRoomId) async {
    final goodRef = await _userDB
        .doc(uid)
        .collection('goodEvaluation')
        .doc(chatRoomId)
        .get();
    final badRef = await _userDB
        .doc(uid)
        .collection('badEvaluation')
        .doc(chatRoomId)
        .get();
    //이미 보낸 평가가 있는 경우
    //good과 bad중 하나만 있어도 true
    if (goodRef.exists || badRef.exists) {
      isExistEvaluation.value = true;
    }
    //이미 보낸 평가가 없는 경우
    //good과 bad 둘 다 없는 경우
    else {
      isExistEvaluation.value = false;
    }
  }
}
