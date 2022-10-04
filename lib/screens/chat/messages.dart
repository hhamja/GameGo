import 'package:mannergamer/utilites/index.dart';

class Messages extends StatelessWidget {
  Messages({Key? key, required this.uid}) : super(key: key);
  /* 상대유저의 uid 값 */
  final String uid;
  /* 기기의 현재 유저 */
  final user = FirebaseAuth.instance.currentUser!;
  /* 채팅 GetX 컨트롤러 */
  final ChatController _chat = Get.put(ChatController());
  /* 내가보낸 메시지인지 반환하는 bool값 */
  final _isMe = true;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: _chat.messageList.length,
        itemBuilder: (context, index) {
          return Row(
            //내가보냄 ? 오른쪽위치 : 왼쪽위치
            mainAxisAlignment:
                _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                decoration: BoxDecoration(
                  color: _isMe ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                      bottomRight:
                          _isMe ? Radius.circular(0) : Radius.circular(12),
                      bottomLeft:
                          _isMe ? Radius.circular(12) : Radius.circular(0)),
                ),
                width: 145,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  _chat.messageList[index].content.toString(), //메시지 입력 리스트
                  style: TextStyle(color: _isMe ? Colors.black : Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
