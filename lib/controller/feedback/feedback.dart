import 'package:mannergamer/utilites/index/index.dart';

//유저가 탈퇴하기 '기타'사유로 클릭 시 작성하는 수기 작성에 대한 피드백 DB에 저장
class FeedBackController extends GetxController {
  final CollectionReference _feedBackDB =
      FirebaseFirestore.instance.collection('feedback');

  // 작성한 피드백 파이어스토어에 저장하기
  // 1. 탈퇴하기 페이지에서 기타사유를 선택하여 수기작성 후 '겜고와 이별하기'버튼을 클릭한 경우 (탈퇴하지 않더라도 OTP인증페이지로 이동하는 버튼 클릭시 정보수집)
  // 이유 : 마지막에 변심해서 최종적으로 유저가 탈퇴를 하지 않더라도 유저 의견을 수용 위해
  Future addFeedBack(SignOutFeedBackModel model) async {
    await _feedBackDB.add(
      {
        'feedBackContent': model.feedBackContent,
        'createdAt': model.createdAt,
      },
    );
  }
}
