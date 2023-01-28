import 'package:mannergamer/utilites/index/index.dart';

class NoUserChatScreenPage extends StatelessWidget {
  NoUserChatScreenPage({Key? key}) : super(key: key);
  // 상대유저정보 (이름, 프로필, 매너나이, uid)
  final String userName = Get.arguments['userName'] + ' (탈퇴)';
  final String profileUrl = Get.arguments['profileUrl'];
  final String uid = Get.arguments['uid'];
  final String chatRoomId = Get.arguments['chatRoomId'];
  final String postId = Get.arguments['postId'];
  final ChatController _chat = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            // 프로필 페이지 이동
            Get.to(() => NoUserProfilePage());
          },
          child: Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 상대유저이름
              Text(
                userName,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {
              Get.bottomSheet(
                ChatBottomSheet(
                  chatRoomId: chatRoomId,
                  //신고받은 uid
                  uid: uid,
                ),
              ),
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 메시지 보여주는 부분
            Expanded(
              child: Stack(
                children: [
                  Messages(
                    chatRoomId: chatRoomId,
                    userName: userName,
                    profileUrl: profileUrl,
                    mannerAge: _chat.mannerAge.value,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}