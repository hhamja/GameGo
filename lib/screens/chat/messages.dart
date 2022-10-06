import 'package:mannergamer/utilites/index.dart';

class Messages extends StatefulWidget {
  /* 상대유저의 uid 값 */
  final String uid;

  Messages({Key? key, required this.uid}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  /* 기기의 현재 유저 */
  final _currentUser = FirebaseAuth.instance.currentUser!;
  /* 채팅 GetX 컨트롤러 */
  final ChatController _chat = Get.put(ChatController());
  @override
  void initState() {
    _chat.messageList.bindStream(
        _chat.readAllMessageList(widget.uid + '_' + _currentUser.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: _chat.messageList.length,
        itemBuilder: (context, index) {
          //현재기기유저와 메시지 보낸사람의 id가 같다면 true, 아니면 false
          final bool _isMe =
              // false;
              _currentUser.uid == _chat.messageList[index].senderId;
          return Container(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Row(
              //내가보냄 ? 오른쪽위치 : 왼쪽위치
              mainAxisAlignment:
                  _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: _isMe
                  ? [
                      Text(
                        '오후 1:32',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 10, height: 3, color: Colors.grey[500]),
                      ),
                      SizedBox(width: 5),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue, //박스색상
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Text(
                          _chat.messageList[index].content
                              .toString(), //메시지 입력 리스트
                          style: TextStyle(color: Colors.grey[100]), //메시지 글 색상
                        ),
                      ),
                    ]
                  : [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Text(
                          _chat.messageList[index].content
                              .toString(), //메시지 입력 리스트
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '오후 1:32',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 10, height: 3, color: Colors.grey[500]),
                      ),
                    ],
            ),
          );
        },
      ),
    );
  }
}
