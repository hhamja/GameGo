import 'package:mannergamer/utilites/index.dart';

class NewMessage extends StatefulWidget {
  NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  /* 메시지 입력 칸 */
  final TextEditingController _messageController = TextEditingController();
  /* 채팅 GetX 컨트롤러 */
  final ChatController _chat = Get.put(ChatController());
  /* 유저 GetX 컨트롤러 */
  final UserController _user = Get.put(UserController());
  /* 입력한 메시지 DB에 보내기 */
  void _sendMessage() {
    final message = MessageModel(
      dateTime: Timestamp.now(),
      messageText: _messageController.text.trim(),
      recieverId: '', //보내는 유저의 UID
      senderId: '', //받는 유저의 UID
    );
    _chat.addMessageToDB(message);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /* 메시지 입력란 */
        Expanded(
          child: TextField(
            autocorrect: false,
            controller: _messageController,
            keyboardType: TextInputType.text,
            maxLines: 1,
            showCursor: true,
            cursorColor: Colors.blue,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '메시지 보내기',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        /* 보내기 버튼 */
        IconButton(
          onPressed: _messageController.text.trim().isEmpty
              ? null // 메시지 아무것도 입력되어 있지 않으면 버튼 작동 X
              : _sendMessage, //클릭 시 chat DB에 입력 데이터 보냄
          icon: Icon(Icons.send),
          color: Colors.blue,
        ),
      ],
    );
  }
}
