import 'package:mannergamer/utilites/index/index.dart';

class MannerEvaluationController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference _ntfDB =
      FirebaseFirestore.instance.collection('notification');

  /* 채팅방에서 확인하는 내가 보낸 매너 평가 */
  Rx<MannerEvaluationModel> myEvaluation = MannerEvaluationModel(
    idFrom: '',
    idTo: '',
    evaluationType: '',
    selectList: [],
    createdAt: Timestamp.now(),
  ).obs;

  /* 내가 받은 매너 평가 리스트 */
  RxList<MannerEvaluationModel> goodEvaluationList =
      <MannerEvaluationModel>[].obs;
  /* 내가 받은 비매너 평가 리스트 */
  RxList<MannerEvaluationModel> badEvaluationList =
      <MannerEvaluationModel>[].obs;

  /* 보낸 매너평가가 있는지 여부 */
  RxBool isExistEvaluation = false.obs;

  /* 매너평가 받는 유저의 하위 컬렉션 'evaluation'에 추가하기
  * 매너평가인 경우 :  푸시알림 위해 notifiaciton에도 추가
  * 비매너평가인 경우 : X */
  Future addMannerEvaluation(uid, chatRoomId,
      MannerEvaluationModel evaluationModel, NotificationModel ntfModel) async {
    //유저의 하위 컬렉션에 추가
    await _userDB.doc(uid).collection('evaluation').doc(chatRoomId).set(
      {
        'idFrom': evaluationModel.idFrom,
        'idTo': evaluationModel.idTo,
        'evaluationType': evaluationModel.evaluationType,
        'selectList': evaluationModel.selectList,
        'createdAt': evaluationModel.createdAt,
      },
    );
    //매너평가인 경우, notification에 추가
    evaluationModel.evaluationType == 'good'
        ? await _ntfDB.add(
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
          )
        : null;
  }

  /* 매너 평가 리스트 받기 */
  Future getGoodEvaluation(uid) async {
    final ref = _userDB.doc(uid).collection('evaluation');
    await ref
        .orderBy('createdAt', descending: true) //최신일 수록  위로 오게
        .where('evaluationType', isEqualTo: 'good') //매너 평가만
        .get()
        .then(
          (snapshot) => goodEvaluationList.assignAll(
            snapshot.docs.map(
              (e) => MannerEvaluationModel.fromDocumentSnapshot(e),
            ),
          ),
        );
  }

  /* 비매너 평가 리스트 받기 */
  Future getBadEvaluation(uid) async {
    final ref = _userDB.doc(uid).collection('evaluation');
    await ref
        .orderBy('createdAt', descending: true) //최신일 수록 위로 오게
        .where('feeling', isEqualTo: 'bad') //비매너 평가만
        .get()
        .then(
          (snapshot) => badEvaluationList.assignAll(
            snapshot.docs.map(
              (e) => MannerEvaluationModel.fromDocumentSnapshot(e),
            ),
          ),
        );
  }

  /* 내가 보낸 매너평가 받기 
  * 채팅페이지에서 버튼 클릭 시 보여지는 페이지 */
  Future getMySentReview(uid, chatRoomId) async {
    _userDB.doc(uid).collection('evaluation').doc(chatRoomId).get().then(
      (value) {
        myEvaluation.value = MannerEvaluationModel.fromDocumentSnapshot(value);
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
