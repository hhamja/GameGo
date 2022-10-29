import 'package:mannergamer/utilites/index/index.dart';

class NewMessage extends StatefulWidget {
  final String chatRoomId;
  NewMessage({Key? key, required this.chatRoomId}) : super(key: key);

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

  /* 메시지 보내기 클릭 시 */
  void _sendMessage() async {
    final messageModel = MessageModel(
      timestamp: Timestamp.now(), // FieldValue.serverTimestamp() -> DB서버시간
      content: _messageController.text.trim(),
      senderId: _currentUser.uid, //보내는 유저의 UID
    );
    // _chat.focusOnLastMessage(); //마지막 메시지로 스크롤 이동
    await _chat.sendNewMessege(messageModel, widget.chatRoomId);
    await _chat.updateChatRoom(
      widget.chatRoomId, //대상이 될 채팅방 id
      _messageController.text.trim(), //마지막 메시지 내용
      Timestamp.now(), // 마지막 메시지의 시간
    ); //마지막 채팅내용과 시간만 업데이트
    setState(() {
      _messageController.clear(); //입력한 메시지 클리어
    });
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
