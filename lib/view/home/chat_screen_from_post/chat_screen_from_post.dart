import 'package:mannergamer/utilites/index/index.dart';

class ChatScreenPageFromPost extends StatefulWidget {
  ChatScreenPageFromPost({Key? key}) : super(key: key);

  @override
  State<ChatScreenPageFromPost> createState() => _ChatScreenPageFromPostState();
}

class _ChatScreenPageFromPostState extends State<ChatScreenPageFromPost> {
  /* PostDetailPage에서 받은 게시자 uid, 이름, 프로필, 매너나이 */
  final String uid = Get.arguments['uid'];
  final String userName = Get.arguments['userName'];
  final String mannerAge = Get.arguments['mannerAge'];
  final String profileUrl = Get.arguments['profileUrl'];
  /* PostDetailPage에서 게시글의 고유 id값 */
  final String postId = Get.arguments['postId'];

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
              userName, // 게시자 유저이름
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 5),
            Text(
              mannerAge + '세', //유저 매너나이 (글씨 작게)
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
                  uid: uid, //게시글 유저 uid
                  postId: postId, //게시물 id값
                  profileUrl: profileUrl, // 상대유저 프로필
                ),
              ],
            ),
          ),
          NewMessageFromPost(
            uid: uid, //게시글 유저 uid값 전달
            postId: postId, //게시물 id값 전달
          ),
        ],
      ),
    );
  }
}
