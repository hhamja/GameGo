import 'package:mannergamer/utilites/index/index.dart';

class DeletePostController extends GetxController {
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  final String postId = Get.arguments['postId'];
  final HomePostController _ = Get.put(HomePostController());

  // 삭제 다이어로그 확인 버튼 클릭
  Future<void> deletePost() async {
    // 이전페이지 홈페이지가 있다면? 홈으로, 나의 정보페이지가 있다면? 나의정보로
    Get.back();
    Get.back();
    // 서버에서 게시글 삭제 플래그 처리
    await _deletePost(postId);
    if (_.selectedTearValue != '티어') {
      // 티어 선택한 경우( = 3개 다 선택한 경우)
      await _.filterTear(
          _.selectedModeValue, _.selectedPositionValue, _.selectedTearValue);
    } else if (_.selectedPositionValue != '포지션') {
      // 티어 선택 X, 모드와 포지션을 선택한 경우
      await _.filterPosition(_.selectedModeValue, _.selectedPositionValue);
    } else if (_.selectedModeValue != '게임모드') {
      // 티어, 포지션 선택 X, 게임모드만 선택한 경우
      await _.filterGamemode(_.selectedModeValue);
    } else {
      // 티어, 포지션, 게임모드 아무것도 선택하지 않은 경우
      await _.readPostData();
    }
  }

  Future _deletePost(postId) async {
    // idDeleted 삭제 플래그 true로 업데이트
    return _postDB.doc(postId).update(
      {
        'isDeleted': true,
      },
    );
  }
}
