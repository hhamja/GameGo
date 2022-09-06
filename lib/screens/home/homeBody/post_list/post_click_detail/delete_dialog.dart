import 'package:mannergamer/utilites/index.dart';

class DeleteDialog extends StatefulWidget {
  DeleteDialog({Key? key}) : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  /* find -> PostConroller  */
  final PostController _controller = Get.find<PostController>();
  /* HomePostList Listview의 index 값을 전달받음 */
  final index = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(index);
    print(_controller.postList[index].postid!);
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
                  onPressed: () async {
                    await _controller
                        .deletePost(_controller.postList[index].postid!);
                    await _controller.readPostData();
                    Get.offAll(() => Homepage());
                  },
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
