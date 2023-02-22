import 'package:gamegoapp/utilites/index/index.dart';

class ChatBottomSheet extends StatefulWidget {
  // 신고할 때 넣을 채팅방 id값
  final String chatRoomId;
  // 신고 받는 uid
  final String uid;

  ChatBottomSheet({
    Key? key,
    required this.chatRoomId,
    required this.uid,
  });

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSpaceData.screenPadding),
      decoration: BoxDecoration(
        color: appWhiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      // 아이템 개수*50 + 10 (위아래 공간 각  5)
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtomSheet(
            '신고하기',
            appBlackColor,
            () {
              Get.back();
              Get.toNamed(
                // 신고목록 페이지로 이동
                '/report',
                arguments: {
                  'chatRoomId': widget.chatRoomId,
                  // 신고 받는 사람의 uid
                  'uid': widget.uid,
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
