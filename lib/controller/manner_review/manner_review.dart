import 'package:mannergamer/utilites/index/index.dart';

class MannerReviewController extends GetxController {
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference _ntfDB =
      FirebaseFirestore.instance.collection('notification');
  /* 내가 보낸 매너후기 담는 Map 자료 형태 */
  RxMap<String, dynamic> myReview = Map<String, dynamic>().obs;
  /* 매너 후기 리스트 */
  RxList<MannerReviewModel> goodReviewList = <MannerReviewModel>[].obs;
  /* 비매너 후기 리스트 */
  RxList<MannerReviewModel> badReviewList = <MannerReviewModel>[].obs;
  /* 보낸 매너리뷰가 있는지의 여부를 담는 변수 */
  RxBool isExistReview = false.obs;
  /* 각 평가 항목의 bool 값 */

  /* 매너후기를 유저의 하위 컬렉션 'review'에 추가하기
  * 매너후기를 채팅의 하위 컬렉션 'reivew'에 보내는 사람 UID로 문서 추가하기 */
  Future addMannerReview(uid, chatRoomId, MannerReviewModel MannerReviewModel,
      NotificationModel ntfModel) async {
    //유저 하위 컬렉션으로 리뷰 저장하기
    await _userDB.doc(uid).collection('review').doc(chatRoomId).set(
      {
        'idFrom': MannerReviewModel.idFrom,
        'idTo': MannerReviewModel.idTo,
        'profileUrl': MannerReviewModel.profileUrl,
        'userName': MannerReviewModel.userName,
        'feeling': MannerReviewModel.feeling,
        'content': MannerReviewModel.content,
        'reviewType': MannerReviewModel.reviewType,
        'createdAt': MannerReviewModel.createdAt,
      },
    );
    //비매너 후기가 아닌 매너후기인 경우에만 notification에 추가
    MannerReviewModel.feeling == 'good'
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

  /* 해당 유저가 받은 매너 후기 리스트 받기 */
  Future getGoodReviewList(uid) async {
    final ref = _userDB.doc(uid).collection('review');
    await ref
        .orderBy('createdAt', descending: true) //최신일 수록 리스트 위로 오게
        .where('feeling', isEqualTo: 'good') //매너후기만
        .get()
        .then(
          (snapshot) => goodReviewList.assignAll(
            snapshot.docs.map(
              (e) => MannerReviewModel.fromDocumentSnapshot(e),
            ),
          ),
        );
  }

  /* 해당 유저가 받은 비매너 후기 리스트 받기 */
  Future getBadReviewList(uid) async {
    final ref = _userDB.doc(uid).collection('review');
    await ref
        .orderBy('createdAt', descending: true) //최신일 수록 리스트 위로 오게
        .where('feeling', isEqualTo: 'bad') //비매너후기만
        .get()
        .then(
          (snapshot) => badReviewList.assignAll(
            snapshot.docs.map(
              (e) => MannerReviewModel.fromDocumentSnapshot(e),
            ),
          ),
        );
  }

  /* 내가 보낸 매너리뷰 GET 
  * 채팅페이지에서 버튼 클릭 시 보여지는 페이지 */
  Future getMySentReview(uid, chatRoomId) async {
    await _userDB.doc(uid).collection('review').doc(chatRoomId).get().then(
      (value) {
        myReview.value = value.data() as Map<String, dynamic>;
      },
    );
  }

  /* 내가 이미 보낸 리뷰가 있는지 여부 확인하기
  * 채팅페이지에 들어가면서 함수 실행 */
  checkExistReview(uid, chatRoomId) async {
    final ref =
        await _userDB.doc(uid).collection('review').doc(chatRoomId).get();
    //이미 보낸 리뷰가 있는 경우
    if (ref.exists) {
      isExistReview.value = true;
    }
    //이미 보낸 리뷰가 없는 경우
    else {
      isExistReview.value = false;
    }
  }
}
