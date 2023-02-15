import 'package:mannergamer/utilites/index/index.dart';

class ChatScreenPageFromPost extends StatefulWidget {
  ChatScreenPageFromPost({Key? key}) : super(key: key);

  @override
  State<ChatScreenPageFromPost> createState() => _ChatScreenPageFromPostState();
}

class _ChatScreenPageFromPostState extends State<ChatScreenPageFromPost> {
  final ChatController _chat = Get.put(ChatController());
  final String postId = Get.arguments['postId'];
  // PostDetailPage에서 받은 게시자 uid, 이름, 프로필, 매너Lv
  final String uid = Get.arguments['uid'];
  final String userName = Get.arguments['userName'];
  final String mannerLevel = Get.arguments['mannerLevel'];
  final String profileUrl = Get.arguments['profileUrl'];

  @override
  void initState() {
    super.initState();
    // chatrringWith 상대유저로 업데이트
    _chat.updateChattingWith(uid);
  }

  @override
  void dispose() {
    // chatrringWith null로 업데이트
    _chat.clearChattingWith();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Get.toNamed(
              // 상대 프로필 정보 페이지로 이동
              '/userProfile',
              // 상대 데이터 전달
              arguments: {
                'profileUrl': profileUrl,
                'userName': userName,
                'mannerLevel': mannerLevel,
                'uid': uid,
              },
            );
          },
          child: Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(width: 3.sp),
              // 매너Lv
              FutureBuilder(
                future: _chat.getUserMannerLevel(uid),
                builder: (context, snapshot) => Text(
                  'Lv.${_chat.level}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    letterSpacing: 0.25.sp,
                    color: mannerLevelColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        // 앱바 타이틀의 중앙을 맞추기 위한 박스
        actions: [SizedBox(width: 30.sp)],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                MessagesFromPost(
                  uid: uid,
                  postId: postId,
                  profileUrl: profileUrl,
                ),
              ],
            ),
          ),
          NewMessageFromPost(
            uid: uid,
            postId: postId,
          ),
        ],
      ),
    );
  }
}
