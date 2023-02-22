import 'package:gamegoapp/utilites/index/index.dart';

class NewMessage extends StatefulWidget {
  final String chatRoomId;
  // 상대유저uid
  final String uid;

  NewMessage({Key? key, required this.chatRoomId, required this.uid})
      : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatController _chat = Get.put(ChatController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // 메시지 보내기 클릭 시
  void _sendMessage() async {
    final messageModel = MessageModel(
      idFrom: _auth.currentUser!.uid,
      idTo: widget.uid,
      content: _messageController.text.trim(),
      type: 'message',
      isDeleted: false,
      timestamp: Timestamp.now(),
    );
    // 입력한 메시지 지우기
    setState(() => _messageController.clear());
    // 메시지 보내기
    _chat.sendNewMessege(messageModel, widget.chatRoomId);

    // 채팅방 데이터의 마지막 채팅 내용, 시간, 맴버 업데이트
    // 맴버 다시 추가 : 상대가 채팅방 나가기하면 맴버에서 uid가 빠지기 때문
    _chat.updateChatRoom(messageModel, widget.chatRoomId);

    // 맨밑으로 스크롤이동
    _chat.scroll.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 메시지 입력란
          Expanded(
            child: TextField(
              autocorrect: false,
              cursorColor: cursorColor,
              style: Theme.of(context).textTheme.bodyMedium,
              controller: _messageController,
              keyboardType: TextInputType.text,
              maxLines: null,
              showCursor: true,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                hintText: '메시지 보내기',
                hintStyle: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  color: appGreyColor,
                ),
              ),
              onChanged: (value) {
                setState(() => value);
              },
            ),
          ),
          // 보내기 버튼
          IconButton(
            alignment: Alignment.center,
            onPressed: _messageController.text.trim().isEmpty
                // 메시지 아무것도 입력되어 있지 않으면 버튼 작동 X
                ? null
                // 클릭 시 chat DB에 입력 데이터 보냄
                : _sendMessage,
            icon: Icon(
              Icons.send,
              color: _messageController.text.trim().isNotEmpty
                  // 텍스트 입력 : primaryColor
                  ? appPrimaryColor
                  // 텍스트 입력 x -> 그레이 색
                  : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
