import 'package:mannergamer/utilites/index/index.dart';

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

  /// 메시지 보내기 클릭 시
  void _sendMessage() async {
    final messageModel = MessageModel(
      timestamp: Timestamp.now(),
      content: _messageController.text.trim(),
      idFrom: CurrentUser.uid,
      idTo: widget.uid,
      type: 'message',
    );

    /// 메시지 보내기
    await _chat.sendNewMessege(messageModel, widget.chatRoomId);

    /// 채팅방 데이터의 마지막 채팅 내용, 시간, 맴버 업데이트
    /// 맴버 다시 추가 : 상대가 채팅방 나가기하면 맴버에서 uid가 빠지기 때문
    _chat.updateChatRoom(
      [CurrentUser.uid, widget.uid],
      widget.chatRoomId,
      _messageController.text.trim(),
      Timestamp.now(),
    );
    // 입력한 메시지 지우기
    setState(() => _messageController.clear());
    // 맨밑으로 스크롤이동
    _chat.scroll.jumpTo(0);
  }

  @override
  Widget build(BuildContext context) {
    print('채팅방id는 ' + widget.chatRoomId);
    return Container(
      margin: EdgeInsets.fromLTRB(10, 3, 0, 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // IconButton(
          //   onPressed: () {}, //클릭 시 사진보내기 (나중)
          //   icon: Icon(
          //     Icons.add_sharp,
          //     size: 30,
          //     color: Colors.grey[500],
          //   ),
          // ),
          /* 메시지 입력란 */
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                minHeight: 40,
              ),
              child: TextField(
                // onTap: () =>
                // _chat.scroll.jumpTo(_chat.scroll.position.maxScrollExtent),
                autocorrect: false,
                controller: _messageController,
                keyboardType: TextInputType.text,
                maxLines: null,
                showCursor: true,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none),
                  hintText: '메시지 보내기',
                  hintStyle: TextStyle(height: 0.0005, color: Colors.grey[400]),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),
          /* 보내기 버튼 */
          IconButton(
            alignment: Alignment.center,
            onPressed: _messageController.text.trim().isEmpty
                ? null // 메시지 아무것도 입력되어 있지 않으면 버튼 작동 X
                : _sendMessage, //클릭 시 chat DB에 입력 데이터 보냄
            icon: Icon(
              Icons.send,
              color: _messageController.text.trim().isNotEmpty
                  ? Colors.blue //입력하는 순간 아이콘 블루 색
                  : Colors.grey[400], // 텍스트 입력 x -> 그레이 색
            ),
          ),
        ],
      ),
    );
  }
}
