import 'package:gamegoapp/utilites/index/index.dart';

class NoUserChatScreenPage extends StatefulWidget {
  NoUserChatScreenPage({Key? key}) : super(key: key);

  @override
  State<NoUserChatScreenPage> createState() => _NoUserChatScreenPageState();
}

class _NoUserChatScreenPageState extends State<NoUserChatScreenPage> {
  // 상대유저정보 (이름, 프로필, uid)
  final String userName = Get.arguments['userName'] + ' (탈퇴)';
  final String uid = Get.arguments['uid'];
  final String chatRoomId = Get.arguments['chatRoomId'];

  @override
  void initState() {
    super.initState();
    Get.put(ChatController());
  }

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
                style: Theme.of(context).textTheme.titleSmall,
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
                  // 신고받은 uid
                  uid: uid,
                ),
              ),
            },
            icon: Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 메시지 보여주는 부분
          Expanded(
            child: Stack(
              children: [
                Messages(
                  // 탈퇴유저 이므로 기기본프로필
                  profileUrl: DefaultProfle.url,
                  // 탈퇴유저 이므로 + ('탈퇴')
                  userName: userName,
                  chatRoomId: chatRoomId,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
