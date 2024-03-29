import 'package:gamego/utilites/index/index.dart';

class CreatePostController extends GetxController {
  final CollectionReference _postDB =
      FirebaseFirestore.instance.collection('post');
  final HomePostController _ = Get.put(HomePostController());

  // 포지션 드랍다운 버튼 보여주는 bool값
  bool showPosition = false;
  // 티어 드랍다운 버튼 보여주는 bool값
  bool showTear = false;

  // 게임모드 선택 value
  var seledtedPostGamemodeValue;
  // 포지션 선택 value
  var seledtedPostdPositionValue;
  // 티어 선택 value
  var seledtedPostTearValue;

  // 게임모드가
  // 솔로,자유 ? 포지션, 티어 둘다 표시
  // 일반 ? 포지션만 표시
  // 칼바람, AI ? null
  showPositonAndTear(modeValue) {
    seledtedPostGamemodeValue = modeValue as String;
    if (seledtedPostGamemodeValue == '솔로랭크' ||
        seledtedPostGamemodeValue == '자유랭크') {
      showPosition = true;
      showTear = true;
      update();
    } else if (seledtedPostGamemodeValue == '일반게임') {
      showPosition = true;
      showTear = false;
      update();
    } else {
      showPosition = false;
      showTear = false;
      update();
    }
    update();
  }

  // 서버에 게시글 추가하기
  Future createPost(PostModel postModel) async {
    final WriteBatch _batch = FirebaseFirestore.instance.batch();

    _batch.set(
      // 문서의 id는 파이어스토어의 자동id 생성 값
      _postDB.doc(postModel.postId),
      {
        'postId': postModel.postId,
        'uid': postModel.uid,
        'userName': postModel.userName,
        'profileUrl': postModel.profileUrl,
        'title': postModel.title,
        'maintext': postModel.maintext,
        'gamemode': postModel.gamemode,
        'position': postModel.position,
        'tear': postModel.tear,
        'like': postModel.like,
        'gameType': postModel.gameType,
        'isHidden': postModel.isHidden,
        'isDeleted': postModel.isDeleted,
        'updatedAt': postModel.updatedAt,
      },
    );
    await _batch.commit();
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
}
