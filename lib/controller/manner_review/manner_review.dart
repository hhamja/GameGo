import 'package:mannergamer/utilites/index/index.dart';

class MannerReviewController extends GetxController {
  /* 현재유저의 uid */
  final String _currentUid = FirebaseAuth.instance.currentUser!.uid;
  /* 유저 Collection 경로 */
  final CollectionReference _userDB =
      FirebaseFirestore.instance.collection('user');
  /* 내가 보낸 매너후기 담는 Map 자료 형태 */
  RxMap<String, dynamic> myReview = Map<String, dynamic>().obs;
  /* 매너리뷰 리스트 */
  RxList<ReviewModel> reviewList = <ReviewModel>[].obs;
  /* 보낸 매너리뷰가 있는지의 여부를 담는 변수 */
  RxBool isExistReview = false.obs;

  /* 매너후기를 유저의 하위 컬렉션 'review'에 추가하기
  * 매너후기를 채팅의 하위 컬렉션 'reivew'에 보내는 사람 UID로 문서 추가하기 */
  Future addMannerReview(uid, chatRoomId, ReviewModel reviewModel) async {
    //유저 하위 컬렉션으로 리뷰 저장하기
    await _userDB.doc(uid).collection('review').doc(chatRoomId).set({
      'feeling': reviewModel.feeling,
      'content': reviewModel.content,
      'reviewType': reviewModel.reviewType,
      'createdAt': reviewModel.createdAt,
    });
    // //해당 채팅 하위 컬렉션으로 리뷰 저장하기
    // await _chatDB.doc(chatRoomId).collection('review').doc(_currentUid).set({
    //   'feeling': reviewModel.feeling,
    //   'content': reviewModel.content,
    //   'reviewType': reviewModel.reviewType,
    //   'createdAt': reviewModel.createdAt,
    // });
  }

  /* 해당 유저가 받은 매너리뷰 GET */
  Future getMannerReview(uid) async {
    final ref = _userDB.doc(uid).collection('review');
    await ref.get().then((snapshot) => reviewList.assignAll(
        snapshot.docs.map((e) => ReviewModel.fromDocumentSnapshot(e))));
  }

  /* 내가 보낸 매너리뷰 GET */
  Future getMySentReview(uid, chatRoomId) async {
    await _userDB
        .doc(uid)
        .collection('review')
        .doc(chatRoomId)
        .get()
        .then((value) {
      myReview.value = value.data() as Map<String, dynamic>;
      print(myReview); //게시글 데이터 프린트
    });
  }

  /* 내가 이미 보낸 리뷰가 있는지 여부 확인하기 */
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

  // /* 내가 보낸 매너리뷰 삭제하기 */
  // Future deleteMannerReview(uid, ReviewModel reviewModel) async {
  //   await _userDB.doc(uid).collection('review').add({
  //     'feeling': reviewModel.feeling,
  //     'content': reviewModel.content,
  //     'reviewType': reviewModel.reviewType,
  //     'createdAt': reviewModel.createdAt,
  //   });
  // }
}
