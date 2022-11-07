import 'package:mannergamer/utilites/index/index.dart';

class ChatScreenPage extends StatefulWidget {
  ChatScreenPage({Key? key}) : super(key: key);

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  final String userName = Get.arguments['userName'];
  final String profileUrl = Get.arguments['profileUrl'];
  final String mannerAge = Get.arguments['mannerAge'];
  final String chatRoomId = Get.arguments['chatRoomId'];
  final int index = Get.arguments['index'];

  @override
  Widget build(BuildContext context) {
    print('userName 값은 ${userName}');
    print('profileUrl 값은 ${profileUrl}');
    print('mannerAge 값은 ${mannerAge}');
    print('chatRoomId 값은 ${chatRoomId}');
    print('index 값은 ${index}');

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
              mannerAge,
              style: TextStyle(fontSize: 12),
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
        children: [
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
