import 'package:mannergamer/utilites/index/index.dart';

class MannerEvaluationController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference _ntfDB =
      FirebaseFirestore.instance.collection('notification');

  // /* 매너평가 항목들의 Rxbool 변수 선언 */
  // RxBool kindManner = false.obs;
  // RxBool goodAppointment = false.obs;
  // RxBool fastAnswer = false.obs;
  // RxBool strongMental = false.obs;
  // RxBool goodGameSkill = false.obs;
  // RxBool softMannerTalk = false.obs;
  // RxBool goodCommunication = false.obs;
  // RxBool comfortable = false.obs;
  // RxBool hardGame = false.obs;

  // /* 비매너평가 항목들의 RxBool 변수 선언 */
  // RxBool badManner = false.obs;
  // RxBool badAppointment = false.obs;
  // RxBool slowAnswer = false.obs;
  // RxBool weakMental = false.obs;
  // RxBool badGameSkill = false.obs;
  // RxBool troll = false.obs;
  // RxBool abuseWord = false.obs;
  // RxBool sexualWord = false.obs;
  // RxBool shortTalk = false.obs;
  // RxBool noCommunication = false.obs;
  // RxBool uncomfortable = false.obs;
  // RxBool privateMeeting = false.obs;

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
  RxList<GoodEvaluationModel> goodEvaluationList = <GoodEvaluationModel>[].obs;
  /* 내가 받은 비매너 평가 리스트 */
  RxList<BadEvaluationModel> badEvaluationList = <BadEvaluationModel>[].obs;
  /* 보낸 매너평가가 있는지 여부 */
  RxBool isExistEvaluation = false.obs;

  /***************************************************************************/

  /* 매너 평가 추가 
  * 유저의 하위 컬렉션 'evaluation'에 추가하기
  * 푸시알림 위해 notifiaciton에도 추가 */
  Future addGoodEvaluation(uid, chatRoomId, GoodEvaluationModel goodEvaluation,
      NotificationModel ntfModel) async {
    //1. 유저의 하위 컬렉션에 추가
    await _userDB.doc(uid).collection('evaluation').doc(chatRoomId).set(
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
    await _userDB.doc(uid).collection('evaluation').doc(chatRoomId).set(
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
  Future getGoodEvaluation(uid) async {
    final ref = _userDB.doc(uid).collection('evaluation');
    await ref
        .orderBy('createdAt', descending: true) //최신일 수록 위로 오게
        .where('evaluationType', isEqualTo: 'good') //매너 평가만
        .get()
        .then(
          (snapshot) => goodEvaluationList.assignAll(
            snapshot.docs.map(
              (e) => GoodEvaluationModel.fromDocumentSnapshot(e),
            ),
          ),
        );
  }

  /* 비매너 평가 리스트 받기 */
  Future getBadEvaluationList(uid) async {
    final ref = _userDB.doc(uid).collection('evaluation');
    await ref
        .orderBy('createdAt', descending: true) //최신일 수록 위로 오게
        .where('evaluationType', isEqualTo: 'bad') //비매너 평가만
        .get()
        .then(
          (snapshot) => badEvaluationList.assignAll(
            snapshot.docs.map(
              (e) => BadEvaluationModel.fromDocumentSnapshot(e),
            ),
          ),
        );
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

  /* 내가 이미 보낸 매너평가가 있는지 여부 확인하기
  * 채팅페이지에 들어가면서 함수 실행 */
  checkExistReview(uid, chatRoomId) async {
    final ref =
        await _userDB.doc(uid).collection('evaluation').doc(chatRoomId).get();
    //이미 보낸 리뷰가 있는 경우
    if (ref.exists) {
      isExistEvaluation.value = true;
    }
    //이미 보낸 리뷰가 없는 경우
    else {
      isExistEvaluation.value = false;
    }
  }
}
