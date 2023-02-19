import 'package:gamego/utilites/index/index.dart';

class DeleteDialog extends GetView<DeletePostController> {
  DeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DeletePostController());
    return CustomSmallDialog(
      '게시글을 삭제 하시겠어요?',
      '취소',
      '삭제',
      () {
        Get.back();
      },
      () async {
        controller.deletePost();
      },
    );
  }
}
