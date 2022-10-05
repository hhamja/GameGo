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
  /* 파베 auth 인스턴스 */
  final _currentUser = FirebaseAuth.instance.currentUser!;
  /* 채팅방 id값 */
  static var chatRoomID;

  /* 입력한 메시지 DB에 보내기 */
  void _sendMessage() async {
    //채팅방이름 = 게시글유저ID_현재폰유저ID
    //채팅방이 이미 있다면 ? 메시지 update : 없다면 채팅방추가 함수 실행
    chatRoomID = widget.uid! + '_' + _currentUser.uid;
    final chatRoomModel = ChatRoomModel(
      id: chatRoomID,
      postingUserId: _currentUser.uid,
      peerUserId: widget.uid,
      //마지막글, 마지막시간은 메시지리스트의 마지막값을 받아서 보여주는 식?
      lastContent: _messageController.text.trim(),
      updatedAt: Timestamp.now().toString(),
    );
    final messageModel = MessageModel(
      timestamp: Timestamp.now().toString(),
      content: _messageController.text.trim(),
      senderId: _currentUser.uid, //보내는 유저의 UID
    );

    await _chat.createNewChatRoom(chatRoomModel);
    await _chat.sendNewMessege(messageModel, chatRoomID);
    _messageController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(
      '채팅방id는 ' + widget.uid! + '_' + _currentUser.uid,
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
