import 'package:mannergamer/utilites/index/index.dart';

class DeleteDialog extends StatefulWidget {
  DeleteDialog({Key? key}) : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  final PostController _post = Get.find<PostController>();
  /* 게시물의 index 값을 전달받음 */
  final String postId = Get.arguments['postId'];
  /* 홈 드랍다운버튼 컨트롤러 */
  final HomePageDropDownBTController _ =
      Get.put(HomePageDropDownBTController());
/* 드랍다운버튼 선택한 값에 따른 페이지 새로고침 */
  Future<void> _deletePost() async {
    Get.until((route) => Get.currentRoute == "/myapp");
    await _post.deletePost(postId); //게시물 DB에서 삭제
    if (_.selectedTearValue != '티어') {
      await _post.filterTear(
          _.selectedModeValue, _.selectedPositionValue, _.selectedTearValue);
    } //티어 선택한 경우( = 3개 다 선택한 경우)
    else if (_.selectedPositionValue != '포지션') {
      await _post.filterPosition(_.selectedModeValue, _.selectedPositionValue);
    } //티어 선택 X, 모드와 포지션을 선택한 경우
    else if (_.selectedModeValue != '게임모드') {
      await _post.filterGamemode(_.selectedModeValue);
    } // 티어, 포지션 선택 X, 게임모드만 선택한 경우
    else {
      await _post.readPostData();
    } //티어, 포지션, 게임모드 아무것도 선택하지 않은 경우
  }

  @override
  Widget build(BuildContext context) {
    print('xxxxxxx' + Get.currentRoute);
    print(postId);
    return Container(
      child: AlertDialog(
        buttonPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
        insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            '게시글을 삭제 하시겠어요?',
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    '취소',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[300],
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: _deletePost,
                  child: Text(
                    '삭제',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
