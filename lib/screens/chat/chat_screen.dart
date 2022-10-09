import 'package:mannergamer/utilites/index.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  /* 게시물 올린 유저의 uid */
  final String? uid = Get.arguments['uid'];
  /* 게시물 Id 값 */
  final postId = Get.arguments['postId'];
  /* User 컨트롤러 */
  final UserController _user = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    print('유저 UID 값은 ${uid}');

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () {
            _user.getUserInfo(uid); //UID 값으로 유저정보 받기
            print(_user.userInfo['userName']); //받은 유저정보 중 유저이름 프린트
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_user.userInfo['userName'] ?? '이름없음'), // 상대유저이름
                Text(_user.userInfo['mannerAge'] ?? '20세'), //유저 매너나이 (글씨 작게)
              ],
            );
          },
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
                uid: uid ?? '', //상대 유저 uid값 전달
                postId: postId, //게시물 id값 전달
              ),
            ),
            NewMessage(
              uid: uid ?? '', //상대 유저 uid값 전달
              postId: postId, //게시물 id값 전달
            ),
          ],
        ),
      ),
    );
  }
}
