import 'package:mannergamer/utilites/index/index.dart';

class DeleteDialog extends StatefulWidget {
  DeleteDialog({Key? key}) : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  final PostController _post = Get.find<PostController>();
  // 게시물의 index 값을 전달받음
  final String postId = Get.arguments['postId'];
  // 홈 드랍다운버튼 컨트롤러
  final HomePageDropDownBTController _ =
      Get.put(HomePageDropDownBTController());

  // 드랍다운버튼 선택한 값에 따른 페이지 새로고침
  Future<void> _deletePost() async {
    // 이전페이지 홈페이지가 있다면? 홈으로, 나의 정보페이지가 있다면? 나의정보로
    Get.until((route) => Get.currentRoute == '/myapp');
    await _post.deletePost(postId);
    if (_.selectedTearValue != '티어') {
      // 티어 선택한 경우( = 3개 다 선택한 경우)
      await _post.filterTear(
          _.selectedModeValue, _.selectedPositionValue, _.selectedTearValue);
    } else if (_.selectedPositionValue != '포지션') {
      // 티어 선택 X, 모드와 포지션을 선택한 경우
      await _post.filterPosition(_.selectedModeValue, _.selectedPositionValue);
    } else if (_.selectedModeValue != '게임모드') {
      // 티어, 포지션 선택 X, 게임모드만 선택한 경우
      await _post.filterGamemode(_.selectedModeValue);
    } else {
      // 티어, 포지션, 게임모드 아무것도 선택하지 않은 경우
      await _post.readPostData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomSmallDialog(
      '게시글을 삭제 하시겠어요?',
      '취소',
      '삭제',
      () {
        Get.back();
      },
      () async {
        _deletePost();
      },
   
    );
  }
}
