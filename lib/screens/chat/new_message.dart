import 'package:mannergamer/utilites/index.dart';

class NewMessage extends StatefulWidget {
  /* 상대유저의 uid 값 */
  final String? uid;
  NewMessage({Key? key, required this.uid}) : super(key: key);

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
  /* 파베 auth 인스턴스 */
  final _auth = FirebaseAuth.instance;

  /* 입력한 메시지 DB에 보내기 */
  void _sendMessage() async {
    final chatRoomID = _auth.currentUser!.uid + '_' + widget.uid!;
    final chatRoomModel = ChatRoomModel(
      id: chatRoomID,
      postingUserId: _auth.currentUser!.uid,
      peerUserId: widget.uid,
      // lastContent: _chat.messageList[_chat.messageList.length].content ?? '',
      // updatedAt: _chat.messageList[_chat.messageList.length].timestamp ?? '',
    );
    final messageModel = MessageModel(
      timestamp: Timestamp.now().toString(),
      content: _messageController.text.trim(),
      senderId: _auth.currentUser!.uid, //받는 유저의 UID
    );
    await _chat.createNewChatRoom(chatRoomModel);
    await _chat.sendNewMessege(messageModel, chatRoomID);
    _messageController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(_auth.currentUser!.uid + '1xxxxxxxxxxxxxxxx');
    print(widget.uid! + '2xxxxxxxxxxxxxxxx');

    print(
      _auth.currentUser!.uid + '_' + widget.uid!,
    );
    return Row(
      children: [
        /* 메시지 입력란 */
        Expanded(
          child: TextField(
            autocorrect: false,
            controller: _messageController,
            keyboardType: TextInputType.text,
            maxLines: null,
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
