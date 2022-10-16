import 'package:mannergamer/utilites/index.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  /* PostDetailPage에서 받은 게시물 올린 유저의 uid */
  final String uid = Get.arguments['uid'];
  /* PostDetailPage에서 받은 게시물 id 값*/
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
            Text('d'), // 상대유저이름
            Text('d'), //유저 매너나이 (글씨 작게)
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => {}, //바텀시트호출
            icon: Icon(Icons.more_vert), //알림끄기, 차단, 신고, 나가기(red), 취소
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(
                uid: uid, //게시글 유저 uid값 전달
                postId: postId, //게시물 id값 전달
              ),
            ),
            NewMessage(
              uid: uid, //게시글 유저 uid값 전달
              postId: postId, //게시물 id값 전달
            ),
          ],
        ),
      ),
    );
  }
}
