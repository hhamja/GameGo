import 'package:mannergamer/utilites/index.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userName), // 상대유저이름
            Text(mannerAge), //유저 매너나이 (글씨 작게)
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
                index: index,
                userName: userName,
                profileUrl: profileUrl,
                mannerAge : mannerAge,
              ),
            ),
            NewMessage(
              chatRoomId: chatRoomId,
              index: index,
            ),
          ],
        ),
      ),
    );
  }
}
