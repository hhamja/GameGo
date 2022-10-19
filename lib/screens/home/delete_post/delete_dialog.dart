import 'package:mannergamer/utilites/index/index.dart';

class DeleteDialog extends StatefulWidget {
  DeleteDialog({Key? key}) : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  /* find -> PostConroller  */
  final PostController _post = Get.find<PostController>();
  /* HomePostList Listview의 index 값을 전달받음 */
  final index = Get.arguments;
  /* 홈 드랍다운버튼 컨트롤러 */
  final HomePageDropDownBTController _button =
      Get.put(HomePageDropDownBTController());
/* 드랍다운버튼 선택한 값에 따른 페이지 새로고침 */
  Future<void> _deletePost() async {
    await _post.deletePost(_post.postList[index].postId); //게시물 DB에서 삭제
    if (_button.selectedModeValue != '게임모드') {
      await _post.filterGamemode(_button.selectedModeValue);
    } //게임모드 버튼 값이 선택되어 있다면?
    else if (_button.selectedPositionValue != '포지션') {
      await _post.filterPosition(
          _button.selectedModeValue, _button.selectedPositionValue);
    } //포지션 버튼 값이 선택되어 있다면?
    else if (_button.selectedTearValue != '티어') {
      await _post.filterTear(_button.selectedModeValue,
          _button.selectedPositionValue, _button.selectedTearValue);
    } //티어 버튼 값이 선택되어 있다면?
    else {
      await _post.readPostData();
    } //아무것도 선택되어 있지 않다면?
    Get.until((route) => Get.currentRoute == 'myapp');
  }

  @override
  Widget build(BuildContext context) {
    print(index);
    print(_post.postList[index].postId);
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
