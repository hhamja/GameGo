import 'package:mannergamer/utilites/index/index.dart';

class ChatScreenPage extends StatefulWidget {
  ChatScreenPage({Key? key}) : super(key: key);

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  /* 상대유저정보 (이름, 프로필, 매너나이, uid) */
  final String userName = Get.arguments['userName'];
  final String profileUrl = Get.arguments['profileUrl'];
  final String mannerAge = Get.arguments['mannerAge'];
  final String uid = Get.arguments['uid'];
  final String chatRoomId = Get.arguments['chatRoomId'];
  final String postId = Get.arguments['postId'];
  final PostController _post = Get.put(PostController());
  final ChatController _chat = Get.find<ChatController>();

  @override
  void initState() {
    _post.getPostInfoByid(postId); //게시글에 대한 데이터 받기
    super.initState();
  }

  @override
  void dispose() {
    _chat.clearUnReadCount(chatRoomId, uid);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('userName 값은 ${userName}');
    print('profileUrl 값은 ${profileUrl}');
    print('mannerAge 값은 ${mannerAge}');
    print('chatRoomId 값은 ${chatRoomId}');
    print('postId : ${postId}');

    return Scaffold(
      appBar: AppBar(
        title: Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userName,
              style: TextStyle(fontSize: 20),
            ), // 상대유저이름
            SizedBox(width: 5),
            Text(
              mannerAge + '세',
              style: TextStyle(fontSize: 15),
            ), //유저 매너나이 (글씨 작게)
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /* 채팅에 해당하는 게시글 정보 */
          CustomPostInfo(
            postId,
            _post.postInfo['title'], //제목
            _post.postInfo['gamemode'], //게임모드
            _post.postInfo['position'], //포지션
            _post.postInfo['tear'], //티어
          ),

          /* 약속 잡는 버튼 */
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: InkWell(
              onTap: () {
                Get.to(() => AppointmentPage()); //약속시간 정하는 페이지로 이동
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      size: 15,
                      Icons.calendar_month,
                      color: Colors.black,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '약속 잡기',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Disvider(thickness: 1),
          /* 메시지 보여주는 부분 */
          Expanded(
            child: Stack(
              children: [
                Messages(
                  chatRoomId: chatRoomId,
                  userName: userName,
                  profileUrl: profileUrl,
                  mannerAge: mannerAge,
                ),
              ],
            ),
          ),

          /* 메시지 보내는 부분*/
          NewMessage(
            chatRoomId: chatRoomId,
          ),
        ],
      ),
    );
  }
}
