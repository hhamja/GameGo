import 'package:mannergamer/utilites/index/index.dart';

class MessagePageFromPost extends StatefulWidget {
  MessagePageFromPost({Key? key}) : super(key: key);

  @override
  State<MessagePageFromPost> createState() => _MessagePageFromPostState();
}

class _MessagePageFromPostState extends State<MessagePageFromPost> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userName), // 게시자 유저이름
            Text(mannerAge), //유저 매너나이 (글씨 작게)
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {Get.bottomSheet(ChatBottomSheet())}, //바텀시트호출
            icon: Icon(Icons.more_vert), //알림끄기, 차단, 신고, 나가기(red), 취소
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: MessagesFromPost(
                uid: uid, //게시글 유저 uid값 전달
                postId: postId, //게시물 id값 전달
              ),
            ),
            NewMessageFromPost(
              uid: uid, //게시글 유저 uid값 전달
              postId: postId, //게시물 id값 전달
            ),
          ],
        ),
      ),
    );
  }
}
