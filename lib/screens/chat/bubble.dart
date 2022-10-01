import 'package:mannergamer/utilites/index.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({Key? key}) : super(key: key);

  /* 채팅 GetX 컨트롤러 */
  final ChatController _chat = Get.put(ChatController());
  /* 유저 GetX 컨트롤러 */
  final UserController _user = Get.put(UserController());
  /* 내가보낸 메시지인지 반환하는 bool값 */
  var isMe;
  var message;

  @override
  Widget build(BuildContext context) {
    return Row(
      //내가보냄 ? 오른쪽위치 : 왼쪽위치
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Colors.blue,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0)),
          ),
          width: 145,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            '',
            style: TextStyle(color: isMe ? Colors.black : Colors.white),
          ),
        ),
      ],
    );
  }
}
