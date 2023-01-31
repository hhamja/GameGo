import 'package:mannergamer/utilites/index/index.dart';

class ChatScreenPageFromPost extends StatefulWidget {
  ChatScreenPageFromPost({Key? key}) : super(key: key);

  @override
  State<ChatScreenPageFromPost> createState() => _ChatScreenPageFromPostState();
}

class _ChatScreenPageFromPostState extends State<ChatScreenPageFromPost> {
  final ChatController _chat = Get.put(ChatController());
  final String postId = Get.arguments['postId'];
  // PostDetailPage에서 받은 게시자 uid, 이름, 프로필, 매너나이
  final String uid = Get.arguments['uid'];
  final String userName = Get.arguments['userName'];
  final String mannerAge = Get.arguments['mannerAge'];
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
    print('유저 UID 값은 ${uid}');
    print('PostId 값은 ${postId}');

    return Scaffold(
      appBar: AppBar(
        title: Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              userName,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 5),
            Text(
              mannerAge + '세',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        centerTitle: true,
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
